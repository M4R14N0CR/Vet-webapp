<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla veterinario</title>
</head>
<body>
	<h1>Actualizar registro de la tabla veterinario</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String id = request.getParameter("id");
			String nombre = request.getParameter("nombre");
                        String id_especialidad = request.getParameter("id_especialidad");

			CallableStatement cstmt = con.prepareCall("{call actualizaciones.actualizar_veterinario(?, ?)}");
                        cstmt.setString(1, nombre);
                        cstmt.setString(2, id);
                        cstmt.execute();

                        
                        CallableStatement cstmt2 = con.prepareCall("{call actualizaciones.actualizar_veterinario_especialidad(?, ?)}");
                        cstmt2.setString(1, id_especialidad);
                        cstmt2.setString(2, id);
                        cstmt2.execute();

                        out.println("Registro editado exitosamente.");
                        
                        con.commit();
			con.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
        
        <br>
	<a href="Veterinario.jsp">Volver a la Tabla Veterinario</a>
</body>
</html>
