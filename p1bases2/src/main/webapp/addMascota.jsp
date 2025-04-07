<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla mascota</title>
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
	<h1>Agregar Registro a la tabla Mascota</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String nombre = request.getParameter("nombre");
                                String especie_id = request.getParameter("especie_id");
                                String raza_id = request.getParameter("raza_id");
                                String edad = request.getParameter("edad");
                                String peso = request.getParameter("peso");
                                String id_propietario = request.getParameter("id_propietario");
				PreparedStatement pst = con.prepareStatement("INSERT INTO VETERINARIA.MASCOTA (ID, NOMBRE, ESPECIE_ID, RAZA_ID, EDAD, PESO, ID_PROPIETARIO) VALUES (veterinaria.secuencia_mascota.nextval, ?, ?, ?, ?, ?, ?)");
				pst.setString(1, nombre);
                                pst.setString(2, especie_id);
                                pst.setString(3, raza_id);
                                pst.setString(4, edad);
                                pst.setString(5, peso);
                                pst.setString(6, id_propietario);

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

	<label for="nombre">Nombre mascota:</label>
	<input type="text" id="nombre" name="nombre" required>
        
        <label for="especie_id">ID Especie:</label>
	<input type="text" id="especie_id" name="especie_id" required>
        
        <label for="raza_id">ID Raza:</label>
	<input type="text" id="raza_id" name="raza_id" required>
        
        <label for="edad">Edad mascota:</label>
	<input type="text" id="edad" name="edad" required>
        
        <label for="peso">Peso mascota:</label>
	<input type="text" id="peso" name="peso" required>
        
        <label for="id_propietario">ID propietario:</label>
	<input type="text" id="id_propietario" name="id_propietario" required>
        
	<button type="submit">Agregar</button>
</form>

<a href="Mascota.jsp">Volver a la tabla Mascota</a>
</body>
</html>
