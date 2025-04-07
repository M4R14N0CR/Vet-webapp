<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tabla Mascota</title>
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
				<th>ID</th>
				<th>Nombre</th>
				<th>Edad</th>
				<th>Peso</th>
                                <th>Especie</th>
                                <th>Raza</th>
                                <th>ID_Propietario</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody>
			<% 
				try{
					Class.forName("oracle.jdbc.driver.OracleDriver");
					Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");
					PreparedStatement pst = con.prepareStatement("Select M.ID, M.NOMBRE, M.EDAD, M.PESO, E.NOMBRE AS ESPECIE, R.NOMBRE AS RAZA, M.ID_PROPIETARIO FROM MASCOTA M INNER JOIN RAZA R ON M.RAZA_ID = R.ID INNER JOIN ESPECIE E ON M.ESPECIE_ID = E.ID");
					ResultSet rs = pst.executeQuery();
					
					while(rs.next()){
						String column1 = rs.getString("ID");
						String column2 = rs.getString("NOMBRE");
						String column3 = rs.getString("EDAD");
						String column4 = rs.getString("PESO");
                                                String column5 = rs.getString("ESPECIE");
                                                String column6 = rs.getString("RAZA");
                                                String column7 = rs.getString("ID_PROPIETARIO");
						%>
							<tr>
								<td><%= column1 %></td>
								<td><%= column2 %></td>
								<td><%= column3 %></td>
								<td><%= column4 %></td>
                                                                <td><%= column5 %></td>
                                                                <td><%= column6 %></td>
                                                                <td><%= column7 %></td>
								<td>
									<button onclick="window.location.href='addMascota.jsp';">Agregar</button>
									<button onclick="window.location.href='editMascota.jsp?id=<%= column1 %>';">Editar</button>
									<button onclick="if(confirm('Esta seguro de que quiere borrar este registro?')){window.location.href='deleteMascota.jsp?id=<%= column1 %>';}">Borrar</button>
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
        <button onclick="window.location.href='buscarMascota.jsp'">Buscar registro en la tabla</button>
</body>
</html>
