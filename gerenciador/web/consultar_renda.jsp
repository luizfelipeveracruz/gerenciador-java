<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
               <%
            String renda;
            Connection con;
            PreparedStatement st;
            ResultSet rs;
            
            //Recebe a renda do formulário con_renda.html
            renda = request.getParameter("renda");

            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoeventos","root","impossiveis");
               
               //Excutando o comando SELECT
               st = con.prepareStatement("SELECT * FROM CLIENTE WHERE RENDA=?");
               st.setString(1, renda);
               rs = st.executeQuery();
               
               //Se enconntrou o cliente
               if(rs.next()){
                    out.print("Nome: " + rs.getString("nome") + "<br>");
                    out.print("Local: " + rs.getString("local") + "<br>");
                    out.print("Cidade: " + rs.getString("cidade") + "<br>");
                    out.print("Estado: " + rs.getString("estado") + "<br>");
                    out.print("Eventos: " + rs.getString("evento") + "<br");
                    out.print("Telefone: " + rs.getString("telefone") + "<br>");
                    out.print("Cep: " + rs.getString("cep") + "<br>");
                    
               }else{ //se não encontrou
                    out.print("Este cliente não está cadastrado");
               }
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
                out.print ("Erro na consulta. Entre em contato com o administrador do site " + ex.getMessage());
            }
        %>
    </body>
</html>