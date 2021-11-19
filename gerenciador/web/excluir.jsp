<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String codigo;
            Connection con;
            PreparedStatement st;
            
            //Recebe o código vindo do formulário exc_cli.html
            codigo = request.getParameter("codigo");
            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoeventos","root","impossiveis");
               //Excutando o comando DELETE que exclui os dados o Banco de dados
               st = con.prepareStatement("DELETE FROM CLIENTE WHERE codigo =?");
               st.setString(1, codigo);
               int retorno =st.executeUpdate();
               if (retorno==1){ //Se excluiu
               out.print("Dados excluido com sucesso");
                } else { //Se não excluiu
                 out.print("Este código não existe");
               }
               
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
          out.print("Erro ao tentar excluir " + ex.getMessage());
            }
        %>    
    </body>
</html>
