<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*,java.text.*" %>
<%
    String receiver = request.getParameter("receiver");
    int amount = Integer.valueOf(request.getParameter("amount"));

    String sender = "";
    int sender_balance = 0;

    Cookie cookies[] = request.getCookies();
    for(int i=0;i<cookies.length;i++){
        if(cookies[i].getName().compareTo("name")==0){
            sender = cookies[i].getValue();
        }
        if(cookies[i].getName().compareTo("balance")==0){
            sender_balance = Integer.valueOf(cookies[i].getValue());
        }
    }
    if(sender.length()==0){
        out.print("Please Login!");
        return;
    }
    if(sender_balance < amount){
        out.print("Insufficient Balance!");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase","admin","admin");

    //check if receiver is present
    PreparedStatement ps = con.prepareStatement("select * from users where name=?");
    ps.setString(1, receiver);
    ResultSet rs = ps.executeQuery();
    int receiver_balance = 0;
    if(rs.next()){
        receiver_balance = rs.getInt(4);
    }else{
        out.print("Receiver doesn't exist!");
        con.close();
        return;
    }

    
    Statement st = con.createStatement();
    // Add amount to receiver
    String toBeAdded = String.valueOf(receiver_balance + amount);
    st.executeUpdate("update users set balance = '"+toBeAdded+"' where users.name = '"+receiver+"' ");
    
    // Subtract amount from sender
    String toBeSubtracted = String.valueOf(sender_balance - amount);
    st.executeUpdate("update users set balance = '"+toBeSubtracted+"' where users.name = '"+sender+"' ");

    // Add this transaction to transactions table
    String rawDate = request.getParameter("date");
    SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
    java.util.Date javaDate = format.parse(rawDate);
    java.sql.Date sqlDate = new java.sql.Date(javaDate.getTime());

    st.executeUpdate("insert into transactions values ('"+sender+"','"+receiver+"','"+sqlDate+"','"+String.valueOf(amount)+"')");
    
    con.close();

    out.print("<h3>Transfer Successfull!</h3>");
%>