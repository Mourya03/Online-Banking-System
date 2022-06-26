<%@ page import = "java.io.*,java.lang.*,java.sql.*,java.util.*" %>
<%@ page import = "java.servlet.*,java.servlet.http.*,java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
<%
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase","admin","admin");

        // get name and balance from cookies

        Cookie cookies[] = request.getCookies();
        String name = "";
        for(int i=0;i<cookies.length;i++){
            if(cookies[i].getName().compareTo("name")==0){
                name = cookies[i].getValue();
            }
        }

        String balance = "";
        PreparedStatement ps = con.prepareStatement("select * from users where name = ? ");
        ps.setString(1,name);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            balance = rs.getString(4);
        }else{
        out.print("<h3>Unable to fetch Balance!</h3>");
        }

        if(name.length()==0 || balance.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }

        //parse date into text->java->sql format

        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        String date = request.getParameter("date");
        java.util.Date javaDate = format.parse(date);
        java.sql.Date sqlDate = new java.sql.Date(javaDate.getTime());

        //deposition amount
        String amount = String.valueOf(request.getParameter("amount"));

        Statement st = con.createStatement();
        // update transactions table
        // both sender and receiver are same (i.e.; name)
        st.executeUpdate("insert into transactions values('"+name+"','"+name+"','"+sqlDate+"','"+amount+"')");
        
        // update users table
        String total = Integer.toString(Integer.parseInt(balance) + Integer.parseInt(amount));
        st.executeUpdate("update users set balance = '"+total+"' where users.name='"+name+"'");
        
        con.close();
        out.print("<h3>Money Deposition Succesful!</h3>");
    }
    catch(Exception e){
        out.print(e);
    }
%>

</body>
</html>