<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla raza</title>
</head>
<body>
	<h1>Actualizar registro de la tabla raza</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String id = request.getParameter("id");
			String nombre = request.getParameter("nombre");
                        
                        CallableStatement cstmt = con.prepareCall("{call actualizaciones.actualizar_raza(?, ?)}");
                        cstmt.setString(1, nombre);
                        cstmt.setString(2, id);
                        cstmt.execute();
                        
			out.println("Registro editado exitosamente.");
                        
                        con.commit();
			con.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
        
        <br>
	<a href="Raza.jsp">Volver a la Tabla raza</a>
</body>
</html>
