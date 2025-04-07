<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla Veterinario</title>
	<style>
		body {
			background-color: #f5f5f5;
			font-family: Arial, sans-serif;
			font-size: 16px;
			color: #333;
			margin: 0;
			padding: 0;
		}

		h1 {
			text-align: center;
			margin-top: 2em;
		}

		form {
			background-color: #fff;
			padding: 2em;
			margin: 2em auto;
			max-width: 600px;
			box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
			border-radius: 4px;
		}

		form label {
			display: block;
			margin-bottom: 0.5em;
		}

		form input {
			display: block;
			width: 100%;
			padding: 0.5em;
			font-size: 1em;
			border-radius: 4px;
			border: 1px solid #ccc;
			margin-bottom: 1em;
		}

		form button[type="submit"] {
			padding: 0.5em 1em;
			background-color: #424242;
			color: #fff;
			border: none;
			cursor: pointer;
			border-radius: 4px;
			font-size: 1em;
			margin-top: 1em;
		}

		form button[type="submit"]:hover {
			background-color: #333;
		}
	</style>
</head>
<body>
	<h1>Agregar Registro a la tabla Veterinario</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String nombre = request.getParameter("nombre");
                                String id_especialidad = request.getParameter("id_especialidad");
                                
				PreparedStatement pst = con.prepareStatement("INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (secuencia_veterinario.nextval, ?)");
				pst.setString(1, nombre);

				int rowsInserted = pst.executeUpdate();
                                
                                PreparedStatement pst2 = con.prepareStatement("INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO) VALUES (?, secuencia_veterinario.currval)");
				pst2.setString(1, id_especialidad);

				int rowsInserted2 = pst2.executeUpdate();

				if(rowsInserted > 0){
					out.println("<p>Registro insertado exitosamente.</p>");
				} else {
					out.println("<p class=\"error\">No se pudo insertar el registro</p>");
				}

				pst.close();
				con.close();
			} catch(SQLException e){
				out.println("SQL Exception: " + e.getMessage());
			} catch(ClassNotFoundException e){
				out.println("Class Not Found Exception: " + e.getMessage());
			} catch(Exception e){
				out.println("General Exception: " + e.getMessage());
			}
		}
%>

<form method="post">
	<label for="nombre">Nombre:</label>
	<input type="text" id="nombre" name="nombre" required>
        
        <label for="id_especialidad">ID especialidad:</label>
	<input type="text" id="id_especialidad" name="id_especialidad" required>

	<button type="submit">Agregar</button>
</form>

<a href="Veterinario.jsp">Volver a la tabla veterinario</a>
</body>
</html>