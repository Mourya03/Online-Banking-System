<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Balance</title>
</head>
<body>
    <%
        //getting username cookie from the request and displaying it

        Cookie cookies[] = request.getCookies();
        String name = "";
        
        try
        {
            for(int i=0;i<cookies.length;i++){
                    if(cookies[i].getName().compareTo("name")==0){
                        name = cookies[i].getValue();
                        break;
                    }
            }
        }catch(Exception e){
            out.print("<h3>Welcome Stranger, Please Login!</h3>");
            return;
        }

        if(name.length()==0){
            out.print("<h3>Unable to Fetch the balance, Please Login!</h3>");
        }else{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase","admin","admin");
            PreparedStatement st = con.prepareStatement("select * from users where name = ? ");
            st.setString(1,name);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                out.print("<h2>Welcome "+name.toUpperCase()+"!</h2>");
                out.print("<h1>Your Account Balance : $"+rs.getString(4)+"</h1>");
            }else{
                out.print("<h3>Unable to fetch Balance!</h3>");
            }
            con.close();
        }
        
    %>
</body>
</html>