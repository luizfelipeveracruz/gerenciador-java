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
            ResultSet rs;
            
            //Recebe o código do formulário con_cli.html
            codigo = request.getParameter("codigo");

            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoeventos","root","impossiveis");
               
               //Excutando o comando SELECT
               st = con.prepareStatement("SELECT * FROM CLIENTE WHERE CODIGO=?");
               st.setString(1, codigo);
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
                    out.print("Renda: " + rs.getString("renda")  + "<br>");
               }else{ //se não encontrou
                    out.print("Este cliente não está cadastrado");
               }
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
                out.print ("Erro na consulta. Entre em contato com o administrador do site " + ex.getMessage());
            }
                rs = st.executeQuery();
            if (rs.next()) { //se encontrou o cliente
                Nome.setText(rs.getString("nome"));
                Local.setText(rs.getString("endereco"));
                txtCidade.setText(rs.getString("cidade"));
                Estado.setText(rs.getString("estado"));
                Evento.setText(rs.getString("evento"));
                Telefone.setText(rs.getString("telefone"));
                Cep.setText(rs.getString("cep"));
                Renda.setDouble(rs.getDouble("renda"));
                btnAlterar.setEnabled(true);
                Codigo.setEditable(false);
            } else {
                JOptionPane.showMessageDialog(null, "Cliente não encontrado");
                limpar();
            }
        } catch (ClassNotFoundException ex) {
            JOptionPane.showMessageDialog(null, "Driver de conexão não encontrado" + ex.getMessage());
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Erro na consulta ao Banco de dados" + ex.getMessage());
        }
        %> 
    </body>
</html>
