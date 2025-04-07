<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Prueba Base</h1>
    </body>
    <%
DriverManager.registerDriver(new OracleDriver());
String url = "jdbc:oracle:thin:@localhost:1521:grp04db";
String username = "veterinaria";
String password = "oracle";


try {
    Connection connection = DriverManager.getConnection(url, username, password);
    System.out.println("Connection successful!");
    
    // Execute SQL query to select the current date from the dual table
    String sql = "SELECT SYSDATE FROM dual";
    PreparedStatement statement = connection.prepareStatement(sql);
    ResultSet resultSet = statement.executeQuery();
    
    // Print the current date
    if (resultSet.next()) {
        Date currentDate = resultSet.getDate(1);
        out.println("Current date: " + currentDate.toString());
    }
    // Close the result set, statement, and connection
    resultSet.close();
    statement.close();
    connection.close();
} catch (SQLException e) {
    System.err.println(e.getMessage());
}
    %>

</html>
