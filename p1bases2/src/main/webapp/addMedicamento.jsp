<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla Medicamento</title>
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
	<h1>Agregar Registro a la tabla Medicamento</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
                    
                        session = request.getSession();
                        String username = (String) session.getAttribute("username");
                        String password = (String) session.getAttribute("password");
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", username, password);

				String nombre = request.getParameter("nombre");
				String precio = request.getParameter("precio");
                                
				PreparedStatement pst = con.prepareStatement("INSERT INTO VETERINARIA.MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (VETERINARIA.secuencia_medicamento.nextval, ?, ?)");
				pst.setString(1, nombre);
				pst.setString(2, precio);

				int rowsInserted = pst.executeUpdate();

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

	<label for="precio">Precio:</label>
	<input type="text" id="precio" name="precio" required>

	<button type="submit">Agregar</button>
</form>

<a href="Medicamento.jsp">Volver a la tabla medicamento</a>
</body>
</html>
