<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Borrar registro de la tabla propietario</title>
</head>
<body>
	<h1>Borrar registro de la tabla propietario</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String cedula = request.getParameter("id");

			PreparedStatement pst = con.prepareStatement("DELETE FROM propietario WHERE CEDULA=?");
			pst.setString(1, cedula);

			int rowsDeleted = pst.executeUpdate();

			if(rowsDeleted > 0){
				out.println("Registro con la cedula: " + cedula + " borrado exitosamente.");
			} else {
				out.println("El registro no puedo ser borrado");
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
	%>

	<br>
	<a href="Propietario.jsp">De vuelta a la tabla Propietario</a>

</body>
</html>
