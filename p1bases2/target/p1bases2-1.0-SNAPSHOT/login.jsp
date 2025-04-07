<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="oracle.jdbc.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar sesion</title>
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
    <h1>Iniciar sesion</h1>
    <form action="login.jsp" method="post">
        <label for="username">Nombre de usuario:</label>
        <input type="text" id="username" name="username" required><br>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required><br>

        <input type="submit" value="Iniciar Sesion">
    </form>

    <% if ("POST".equals(request.getMethod())) { %>
        <%-- Sacar el usuario y la contrasena del form --%>
        <% String username = request.getParameter("username"); %>
        <% String password = request.getParameter("password"); %>

        <%-- Intentar conectarse a la base de datos con los datos suministrados --%>
        <% try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", username, password);
                
                session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                
                // Si la conneccion es exitosa, se redirige al menuPrincipal.jsp
                response.sendRedirect("menuPrincipal.jsp");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                out.println("<p>Contrasena o usuario Invalidos.</p>");
            } %>
    <% } %>
</body>
</html>
