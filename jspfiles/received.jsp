<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*,java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
</head>
<body>
    <h3>Your Incoming History</h3>
    <table>
    <%
            String receiver = "";

            Cookie cookies[] = request.getCookies();
            for(int i=0;i<cookies.length;i++){
                if(cookies[i].getName().compareTo("name")==0){
                    receiver = cookies[i].getValue();
                    break;
                }
            }
            out.print("Username : "+receiver.toUpperCase()+"<br>");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase","admin","admin");

            PreparedStatement ps = con.prepareStatement("select * from transactions where receiver=?");
            ps.setString(1, receiver);
            ResultSet rs = ps.executeQuery();
            if(rs.next()==false){
                out.print("No transactions to show!");
                con.close();
                return;
            }
    %> 
            <tr>
                <td><b>Sender</b></td>
                <td><b>Receiver</b></td>
                <td><b>Date</b></td>
                <td><b>Amount</b></td>
            </tr> 
    <%
            while(rs.next()){
    %> 
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
                    <td><%= "$ "+rs.getInt(4)%></td>
                </tr> 
    <%
            }
            con.close();
    %>
    </table>
</body>