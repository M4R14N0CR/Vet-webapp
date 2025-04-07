<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Actualizar registro de la tabla medicamento</title>
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
			String nombre = request.getParameter("nombre");
			String precio = request.getParameter("precio");
                        
                        CallableStatement cstmt = con.prepareCall("{call veterinaria.actualizaciones.actualizar_medicamento(?, ?, ?)}");
                        cstmt.setString(1, nombre);
			cstmt.setString(2, precio);
                        cstmt.setString(3, id);
                        cstmt.execute();
                        
			out.println("Registro editado exitosamente.");
                                
                        con.commit();
			con.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
        
        <br>
	<a href="Medicamento.jsp">Volver a la Tabla medicamento</a>
</body>
</html>
