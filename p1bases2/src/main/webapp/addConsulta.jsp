<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Agregar Registro a la tabla Consulta</title>
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
	<h1>Agregar Registro a la tabla Consulta</h1>

	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String fecha = request.getParameter("fecha");
				String precio_total = request.getParameter("precio_total");
				String diagnostico = request.getParameter("diagnostico");
                                String veterinario_id = request.getParameter("veterinario_id");
                                String mascota_id = request.getParameter("mascota_id");
                                String medicamento_id = request.getParameter("medicamento_id");
                                String cantidad_medicamento = request.getParameter("cantidad_medicamento");
                                
                                
				PreparedStatement pst = con.prepareStatement("INSERT INTO consulta (ID_CONSULTA, FECHA, PRECIO_TOTAL, DIAGNOSTICO) VALUES (secuencia_consulta.nextval, ?, ?, ?)");
				pst.setString(1, fecha);
				pst.setString(2, precio_total);
				pst.setString(3, diagnostico);

				int rowsInserted = pst.executeUpdate();
                                
                                PreparedStatement pst2 = con.prepareStatement("INSERT INTO consulta_veterinario (ID_CONSULTA, ID_VETERINARIO) VALUES (secuencia_consulta.currval, ?)");
                                pst2.setString(1, veterinario_id);
                                
                                int rowsInserted2 = pst2.executeUpdate();
                                
                                PreparedStatement pst3 = con.prepareStatement("INSERT INTO consulta_mascota (ID_CONSULTA, ID_MASCOTA) VALUES (secuencia_consulta.currval, ?)");
                                pst3.setString(1, mascota_id);
                                
                                int rowsInserted3 = pst3.executeUpdate();
                                
                                PreparedStatement pst4 = con.prepareStatement("INSERT INTO consulta_medicamento (ID_CONSULTA, ID_MEDICAMENTO, CANTIDAD) VALUES (secuencia_consulta.currval, ?, ?)");
                                pst4.setString(1, medicamento_id);
                                pst4.setString(2, cantidad_medicamento);
                                
                                int rowsInserted4 = pst4.executeUpdate();
                                
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

	<label for="fecha">Fecha:</label>
	<input type="text" id="fecha" name="fecha" required>

	<label for="precio_total">Precio consulta</label>
	<input type="text" id="precio_total" name="precio_total" required>

	<label for="diagnostico">Diagnostico:</label>
	<input type="text" id="diagnostico" name="diagnostico" required>
        
        <label for="veterinario_id">Veterinario ID:</label>
	<input type="text" id="veterinario_id" name="veterinario_id" required>
        
        <label for="mascota_id">Mascota ID:</label>
	<input type="text" id="mascota_id" name="mascota_id" required>
        
        <label for="medicamento_id">Medicamento ID:</label>
	<input type="text" id="medicamento_id" name="medicamento_id" required>
        
        <label for="cantidad_medicamento">Cantidad Medicamento:</label>
	<input type="text" id="cantidad_medicamento" name="cantidad_medicamento" required>
        
	<button type="submit">Agregar</button>
</form>

<a href="Consulta.jsp">Volver a la tabla consulta</a>
</body>
</html>
