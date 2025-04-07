<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla medicamento</title>
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
	<h1>Actualizar registro de la tabla medicamento</h1>

	<% 
                session = request.getSession();
                String username = (String) session.getAttribute("username");
                String password = (String) session.getAttribute("password");
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", username, password);

			String id = request.getParameter("id");

			if(id != null){
				PreparedStatement pst = con.prepareStatement("SELECT * FROM VETERINARIA.medicamento WHERE ID = ?");
				pst.setString(1, id);
				ResultSet rs = pst.executeQuery();

				if(rs.next()){
					String nombre = rs.getString("NOMBRE");
					String precio = rs.getString("PRECIO");
					%>
						<form method="post" action="updateMedicamento.jsp">
							<input type="hidden" name="id" value="<%= id %>">
							<label for="id">Nombre:</label>
							<input type="text" name="nombre" value="<%= nombre %>" required>
							<label for="nombre">Precio:</label>
							<input type="text" name="precio" value="<%= precio %>" required>
							<button type="submit">Guardar cambios</button>
						</form>
					<%
				} else {
					out.println("No se encontro medicamento con el id: " + id);
				}

				rs.close();
				pst.close();
			} else {
				out.println("No se suministro una cedula");
			}

			con.close();
		} catch(Exception e){
out.println("Error: " + e.getMessage());
}
%>

</body>
</html>
