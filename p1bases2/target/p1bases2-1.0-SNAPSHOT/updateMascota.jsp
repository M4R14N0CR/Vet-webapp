<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla mascota</title>
</head>
<body>
	<h1>Actualizar registro de la tabla mascota</h1>

	<% 
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");

			String id = request.getParameter("id");
			String nombre = request.getParameter("nombre");
                        String especie_id = request.getParameter("especie_id");
                        String raza_id = request.getParameter("raza_id");
                        String edad = request.getParameter("edad");
                        String peso = request.getParameter("peso");
                        String id_propietario = request.getParameter("id_propietario");
                        
                        CallableStatement cstmt = con.prepareCall("{call actualizaciones.actualizar_mascota(?, ?, ?, ?, ?, ?, ?)}");
                        cstmt.setString(1, nombre);
                        cstmt.setString(2, especie_id);
                        cstmt.setString(3, raza_id);
                        cstmt.setString(4, edad);
                        cstmt.setString(5, peso);
                        cstmt.setString(6, id_propietario);
                        cstmt.setString(7, id);
                        cstmt.execute();

			out.println("Registro editado exitosamente.");
                        con.commit();
			con.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
        
        <br>
	<a href="Mascota.jsp">Volver a la Tabla mascota</a>
</body>
</html>
