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
            Cookie cookies[] = request.getCookies();
            for(int i=0;i<cookies.length;i++){
                cookies[i].setMaxAge(0);
                response.addCookie(cookies[i]);
            }
        }catch(Exception e){
            out.print(e);
        }
    %>
    <h3>User Logged Out Succesfully !</h3>
</body>
</html>