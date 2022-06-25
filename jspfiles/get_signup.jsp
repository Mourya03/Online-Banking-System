<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Page</title>
</head>
<body>

    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase","admin","admin");

        String uname = request.getParameter("uname");
        String pword = request.getParameter("pword");
        String email = request.getParameter("email");

        PreparedStatement ps = con.prepareStatement("select * from users where name=?");
        ps.setString(1,uname);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            out.println("User already Exists!");
        }else{

        Statement st = con.createStatement();
        st.executeUpdate("insert into users values('"+uname+"','"+pword+"','"+email+"')");
        out.println("User created successfully!");

        }

        con.close();
    %>

    
</body>
</html>