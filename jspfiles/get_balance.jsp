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
        //getting balance cookie from the request and displaying it

        Cookie cookies[] = request.getCookies();
        for(int i=0;i<cookies.length;i++){
                if(cookies[i].getName().compareTo("balance")==0){
                    out.print("<h3>Your Balance : "+cookies[i].getValue()+"</h3>");
                    return;
                }
        }
        out.print("<h3>Unable to Fetch the balance!</h3>");
    %>
</body>
</html>