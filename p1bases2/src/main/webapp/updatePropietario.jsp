<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla propietario</title>
</head>
<body>
	<h1>Actualizar registro de la tabla propietario</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String cedula = request.getParameter("cedula");
			String email = request.getParameter("email");
			String telefono = request.getParameter("telefono");
			String nombre = request.getParameter("nombre");
                        
                        CallableStatement cstmt = con.prepareCall("{call actualizaciones.actualizar_propietario(?, ?, ?, ?)}");
                        cstmt.setString(1, email);
			cstmt.setString(2, telefono);
			cstmt.setString(3, nombre);
			cstmt.setString(4, cedula);
                        cstmt.execute();

			out.println("Registro editado exitosamente.");
			
                        con.commit();
			con.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
        
        <br>
	<a href="Propietario.jsp">Volver a la Tabla Propietario</a>
</body>
</html>
