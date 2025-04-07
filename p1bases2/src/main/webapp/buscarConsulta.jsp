<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Buscar registro en la tabla consulta</title>
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
                
                table {
			border-collapse: collapse;
			width: 100%;
			margin-bottom: 1em;
			font-size: 0.9em;
			background-color: #f5f5f5;
			color: #000;
		}

		table thead th {
			background-color: #424242;
			color: #fff;
			text-align: left;
			padding: 0.5em;
		}

		table tbody td {
			border-bottom: 1px solid #ddd;
			padding: 0.5em;
		}

		table tbody tr:nth-child(even) {
			background-color: #e0e0e0;
		}

		button {
			padding: 0.5em;
			background-color: #424242;
			color: #fff;
			border: none;
			cursor: pointer;
			margin-top: 1em;
		}

		button:hover {
			background-color: #333;
		}
                
                form span {
                        display: inline-block;
                        margin-right: 1em;
                }

                form label, form input {
                        display: inline-block;
                        vertical-align: middle;
}

	</style>
</head>
<body>
	<h1>Buscar registro en la tabla Consulta</h1>
        
<form method="post" action="buscarConsulta.jsp">
  <div style="display: flex; justify-content: space-between;">
    <span style="flex: 1;">
      <label for="busqueda">Busqueda:</label>
      <input type="text" id="busqueda" name="busqueda">
    </span>

    <div style="margin-left: 1em;">
      <button type="submit">Buscar</button>
    </div>
  </div>
</form>

<table>
		<thead>
			<tr>
				<th>ID_Consulta</th>
				<th>Fecha</th>
				<th>Veterinario</th>
                                <th>Mascota</th>
				<th>ID</th>
				<th>ID prop.</th>
                                <th>Diagnostico</th>
                                <th>Medicamento</th>
                                <th>Cantidad</th>
                                <th>Total</th>
			</tr>
		</thead>
                <tbody>
	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String busqueda = request.getParameter("busqueda");
                                String sql = "SELECT c.ID_CONSULTA, c.fecha, v.nombre AS VETERINARIO, M.nombre AS MASCOTA, M.ID, M.ID_PROPIETARIO, c.diagnostico, ME.NOMBRE AS MEDICAMENTO, CME.CANTIDAD, ((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) AS TOTAL FROM consulta c INNER JOIN consulta_veterinario cv ON c.ID_CONSULTA = cv.ID_CONSULTA INNER JOIN consulta_mascota cm ON c.ID_CONSULTA = cm.ID_CONSULTA INNER JOIN consulta_medicamento CME ON c.ID_CONSULTA = CME.ID_CONSULTA INNER JOIN mascota M ON M.ID = cm.ID_MASCOTA INNER JOIN veterinario v ON v.id = cv.ID_VETERINARIO INNER JOIN medicamento ME ON ME.ID = CME.ID_MEDICAMENTO WHERE c.ID_CONSULTA LIKE '%"+busqueda+"%' OR c.fecha LIKE '%"+busqueda+"%' OR v.nombre LIKE '%"+busqueda+"%' OR M.nombre LIKE '%"+busqueda+"%' OR M.ID LIKE '%"+busqueda+"%' OR M.ID_PROPIETARIO LIKE '%"+busqueda+"%' OR c.diagnostico LIKE '%"+busqueda+"%' OR ME.NOMBRE LIKE '%"+busqueda+"%' OR CME.CANTIDAD LIKE '%"+busqueda+"%' OR ((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) LIKE '%"+busqueda+"%'";

                                PreparedStatement pst = con.prepareStatement(sql);
				ResultSet rs = pst.executeQuery();
					
					while(rs.next()){
						String column1 = rs.getString("ID_CONSULTA");
						String column2 = rs.getString("FECHA");
						String column3 = rs.getString("VETERINARIO");
						String column4 = rs.getString("MASCOTA");
                                                String column5 = rs.getString("ID");
                                                String column6 = rs.getString("ID_PROPIETARIO");
                                                String column7 = rs.getString("DIAGNOSTICO");
                                                String column8 = rs.getString("MEDICAMENTO");
                                                String column9 = rs.getString("CANTIDAD");
                                                String column10 = rs.getString("TOTAL");
						%>
							<tr>
								<td><%= column1 %></td>
								<td><%= column2 %></td>
								<td><%= column3 %></td>
								<td><%= column4 %></td>
                                                                <td><%= column5 %></td>
                                                                <td><%= column6 %></td>
                                                                <td><%= column7 %></td>
                                                                <td><%= column8 %></td>
                                                                <td><%= column9 %></td>
                                                                <td><%= column10 %></td>
								<td>
									<button onclick="window.location.href='addConsulta.jsp';">Agregar</button>
									<button onclick="if(confirm('Esta seguro de que quiere borrar este registro?')){window.location.href='deleteConsulta.jsp?id=<%= column1 %>';}">Borrar</button>
								</td>
							</tr>
						<%
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

<tbody>
</table>

<a href="Consulta.jsp">Volver a la tabla consulta</a>
</body>
</html>
