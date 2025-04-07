<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla Propietario</title>
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
	<h1>Agregar Registro a la tabla Propietario</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String cedula = request.getParameter("cedula");
				String email = request.getParameter("email");
				String telefono = request.getParameter("telefono");
				String nombre = request.getParameter("nombre");

				PreparedStatement pst = con.prepareStatement("INSERT INTO veterinaria.propietario (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES (?, ?, ?, ?)");
				pst.setString(1, cedula);
				pst.setString(2, email);
				pst.setString(3, telefono);
				pst.setString(4, nombre);

				int rowsInserted = pst.executeUpdate();

				if(rowsInserted > 0){
					out.println("<p>Registro con la cedula: " + cedula + " insertado exitosamente.</p>");
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
	<label for="cedula">Cedula:</label>
	<input type="text" id="cedula" name="cedula" required>

	<label for="email">Email:</label>
	<input type="email" id="email" name="email" required>

	<label for="telefono">Telefono:</label>
	<input type="text" id="telefono" name="telefono" required>

	<label for="nombre">Nombre:</label>
	<input type="text" id="nombre" name="nombre" required>

	<button type="submit">Agregar</button>
</form>

<a href="Propietario.jsp">Volver a la tabla propietario</a>
</body>
</html>
