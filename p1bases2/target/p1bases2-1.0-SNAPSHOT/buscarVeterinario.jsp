<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Buscar registro en la tabla veterinario</title>
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
	<h1>Buscar registro en la tabla Veterinario</h1>
        
<form method="post" action="buscarVeterinario.jsp">
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
				<th>ID</th>
				<th>Nombre</th>
                                <th>Nombre Especialidad</th>
				<th>Acciones</th>
			</tr>
		</thead>
                <tbody>
	<% 
		if(request.getMethod().equalsIgnoreCase("post")){
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

				String busqueda = request.getParameter("busqueda");
                                String sql = "Select V.ID, V.NOMBRE, E.NOMBRE_ESPECIALIDAD FROM VETERINARIO V INNER JOIN VETERINARIO_ESPECIALIDAD VE ON V.ID = VE.ID_VETERINARIO INNER JOIN ESPECIALIDAD E ON VE.ID_ESPECIALIDAD = E.ID WHERE V.NOMBRE LIKE '%"+busqueda+"%' OR E.NOMBRE_ESPECIALIDAD LIKE '%"+busqueda+"%' OR V.ID LIKE '%"+busqueda+"%'";
                                PreparedStatement pst = con.prepareStatement(sql);
				ResultSet rs = pst.executeQuery();
					
					while(rs.next()){
						String column1 = rs.getString("ID");
						String column2 = rs.getString("NOMBRE");
                                                String column3 = rs.getString("NOMBRE_ESPECIALIDAD");
						%>
							<tr>
								<td><%= column1 %></td>
								<td><%= column2 %></td>
                                                                <td><%= column3 %></td>
								<td>
									<button onclick="window.location.href='addVeterinario.jsp';">Agregar</button>
									<button onclick="window.location.href='editVeterinario.jsp?id=<%= column1 %>';">Editar</button>
									<button onclick="if(confirm('Esta seguro de que quiere borrar este registro?')){window.location.href='deleteVeterinario.jsp?id=<%= column1 %>';}">Borrar</button>
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

<a href="Veterinario.jsp">Volver a la tabla veterinario</a>
</body>
</html>
