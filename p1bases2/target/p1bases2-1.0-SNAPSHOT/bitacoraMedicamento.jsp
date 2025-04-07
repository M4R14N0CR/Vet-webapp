<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tabla Medicamento</title>
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
				<th>Fecha</th>
				<th>Hora</th>
				<th>Accion</th>
                                <th>Usuario</th>
				<th>ID medicamento</th>
				<th>Valor modificado</th>
                                <th>Valor nuevo</th>
			</tr>
		</thead>
		<tbody>
			<% 
				try{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");
					PreparedStatement pst = con.prepareStatement("SELECT * FROM bitacora_medicamento");
					ResultSet rs = pst.executeQuery();
					
					while(rs.next()){
						String column1 = rs.getString("FECHA");
						String column2 = rs.getString("HORA");
						String column3 = rs.getString("ACCION");
                                                String column4 = rs.getString("USUARIO");
						String column5 = rs.getString("ID_MEDICAMENTO");
						String column6 = rs.getString("VALOR_MODIFICADO");
                                                String column7 = rs.getString("VALOR_NUEVO");
						%>
							<tr>
								<td><%= column1 %></td>
								<td><%= column2 %></td>
								<td><%= column3 %></td>
                                                                <td><%= column4 %></td>
								<td><%= column5 %></td>
								<td><%= column6 %></td>
                                                                <td><%= column7 %></td>
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
</body>
</html>
