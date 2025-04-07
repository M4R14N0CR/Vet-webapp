<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tabla Consulta</title>
	<style>
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
	</style>
</head>
<body>
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
				try{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");
					PreparedStatement pst = con.prepareStatement("SELECT c.ID_CONSULTA, c.fecha, v.nombre AS VETERINARIO, M.nombre AS MASCOTA, M.ID, M.ID_PROPIETARIO, c.diagnostico, ME.NOMBRE AS MEDICAMENTO, CME.CANTIDAD, ((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) AS TOTAL FROM consulta c INNER JOIN consulta_veterinario cv ON c.ID_CONSULTA = cv.ID_CONSULTA INNER JOIN consulta_mascota cm ON c.ID_CONSULTA = cm.ID_CONSULTA INNER JOIN consulta_medicamento CME ON c.ID_CONSULTA = CME.ID_CONSULTA INNER JOIN mascota M ON M.ID = cm.ID_MASCOTA INNER JOIN veterinario v ON v.id = cv.ID_VETERINARIO INNER JOIN medicamento ME ON ME.ID = CME.ID_MEDICAMENTO");
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
					
					rs.close();
					pst.close();
					con.close();
				} catch(Exception e){
					e.printStackTrace();
				}
			%>
		</tbody>
	</table>
	<button onclick="window.location.href='menuPrincipal.jsp'">Regresar al menú principal</button>
        <button onclick="window.location.href='buscarConsulta.jsp'">Buscar registro en la tabla</button>
</body>
</html>
