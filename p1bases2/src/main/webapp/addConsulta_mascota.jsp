<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla Consulta_mascota</title>
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
	<h1>Agregar Registro a la tabla Consulta_mascota</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String id_consulta = request.getParameter("id_consulta");
				String id_mascota = request.getParameter("id_mascota");

				PreparedStatement pst = con.prepareStatement("INSERT INTO CONSULTA_MASCOTA (ID_CONSULTA, ID_MASCOTA) VALUES (?, ?)");
				pst.setString(1, id_consulta);
				pst.setString(2, id_mascota);

				int rowsInserted = pst.executeUpdate();

				if(rowsInserted > 0){
					out.println("<p>Registro con el id consulta: " + id_consulta + " insertado exitosamente.</p>");
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
	<label for="id_consulta">ID Consulta:</label>
	<input type="text" id="id_consulta" name="id_consulta" required>

	<label for="nombre">ID Mascota:</label>
	<input type="text" id="id_mascota" name="id_mascota" required>

	<button type="submit">Agregar</button>
</form>

<a href="Consulta_mascota.jsp">Volver a la tabla Consulta_mascota</a>
</body>
</html>
