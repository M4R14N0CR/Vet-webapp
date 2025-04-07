<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla propietario</title>
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
	<h1>Actualizar registro de la tabla propietario</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String cedula = request.getParameter("id");

			if(cedula != null){
				PreparedStatement pst = con.prepareStatement("SELECT * FROM propietario WHERE CEDULA = ?");
				pst.setString(1, cedula);
				ResultSet rs = pst.executeQuery();

				if(rs.next()){
					String email = rs.getString("EMAIL");
					String telefono = rs.getString("TELEFONO");
					String nombre = rs.getString("NOMBRE");
					%>
						<form method="post" action="updatePropietario.jsp">
							<input type="hidden" name="cedula" value="<%= cedula %>">
							<label for="email">Email:</label>
							<input type="email" name="email" value="<%= email %>" required>
							<label for="telefono">Telefono:</label>
							<input type="tel" name="telefono" value="<%= telefono %>" required>
							<label for="nombre">Nombre:</label>
							<input type="text" name="nombre" value="<%= nombre %>" required>
							<button type="submit">Guardar cambios</button>
						</form>
					<%
				} else {
					out.println("No se encontro propietario con la cedula: " + cedula);
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
