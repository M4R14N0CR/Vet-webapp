<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Borrar registro de la tabla consulta</title>
</head>
<body>
	<h1>Borrar registro de la tabla consulta</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String id = request.getParameter("id");
                        
                        PreparedStatement pst2 = con.prepareStatement("DELETE FROM consulta_veterinario WHERE ID_CONSULTA=?");
                        pst2.setString(1, id);
                        int rowsDeleted2 = pst2.executeUpdate();
                        
                        PreparedStatement pst4 = con.prepareStatement("DELETE FROM consulta_medicamento WHERE ID_CONSULTA=?");
                        pst4.setString(1, id);
                        int rowsDeleted4 = pst4.executeUpdate();
                        
                        PreparedStatement pst3 = con.prepareStatement("DELETE FROM consulta_mascota WHERE ID_CONSULTA=?");
                        pst3.setString(1, id);
                        int rowsDeleted3 = pst3.executeUpdate();
                        
			PreparedStatement pst = con.prepareStatement("DELETE FROM consulta WHERE ID_CONSULTA=?");
			pst.setString(1, id);

			int rowsDeleted = pst.executeUpdate();
                        
			if(rowsDeleted > 0){
				out.println("Registro con el id: " + id + " borrado exitosamente.");
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
	<a href="Consulta.jsp">De vuelta a la tabla consulta</a>

</body>
</html>
