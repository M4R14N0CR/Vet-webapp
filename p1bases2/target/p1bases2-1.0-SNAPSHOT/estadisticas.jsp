<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page import="oracle.sql.*" %>

<html>
<head>
    <title>Consulta de ventas</title>
    <style>
        body {
            font-size: 24px;
            font-family: Arial, sans-serif;
        }
        
        h1 {
            font-size: 36px;
            text-align: center;
        }
        
        p {
            margin-top: 24px;
        }
    </style>
</head>
<body>
    <h1>Consulta de ventas</h1>

<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:grp04db", "veterinaria", "oracle");
    
    // Sacar mes, dia y anio actuales
    Calendar calendar = Calendar.getInstance();
    int currentYear = calendar.get(Calendar.YEAR);
    int currentMonth = calendar.get(Calendar.MONTH) + 1;
    int currentDay = calendar.get(Calendar.DAY_OF_MONTH);
    
    CallableStatement cs1 = conn.prepareCall("{? = call consultas.ventaTotalMes(?, ?)}");
    CallableStatement cs2 = conn.prepareCall("{? = call consultas.ventaTotalAnio(?)}");
    CallableStatement cs3 = conn.prepareCall("{? = call consultas.ventaTotalDia(?, ?, ?)}");
    
    cs1.setInt(2, currentMonth);
    cs1.setInt(3, currentYear);
    cs2.setInt(2, currentYear);
    cs3.setInt(2, currentDay);
    cs3.setInt(3, currentMonth);
    cs3.setInt(4, currentYear);
    
    cs1.registerOutParameter(1, Types.NUMERIC);
    cs2.registerOutParameter(1, Types.NUMERIC);
    cs3.registerOutParameter(1, Types.NUMERIC);
    
    // Execute the functions
    cs1.execute();
    cs2.execute();
    cs3.execute();
    
    // Get the return values of the functions
    double totalMes = cs1.getDouble(1);
    double totalAnio = cs2.getDouble(1);
    double totalDia = cs3.getDouble(1);
    
    // Print the return values
%>

<p>Total venta del mes <%= currentMonth %> del año <%= currentYear %>: <%= String.format("%.2f", totalMes) %></p>
    <p>Total venta del año <%= currentYear %>: <%= String.format("%.2f", totalAnio) %></p>
    <p>Total venta del día <%= currentDay %>/<%= currentMonth %>/<%= currentYear %>: <%= String.format("%.2f", totalDia) %></p>
    <a href="menuPrincipal.jsp">De vuelta al menu principal</a>
</body>
</html>
