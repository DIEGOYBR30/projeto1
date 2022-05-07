<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // 1) Receber o código vindo do formulário ExcluirProdutos.html
            int codigo;
            if (request.getParameter("codigo").equalsIgnoreCase("")){
                out.print("Você não informou o código");
                return;
            } else {
                codigo = Integer.parseInt(request.getParameter("codigo"));
            }
            try {
                // 2) Conectar com o Banco de dados

                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/bancoterca", "root", "2907");

                //3) Excluir os dados da tabela do banco de dados
                PreparedStatement st = conexao.prepareStatement("DELETE FROM produtos WHERE codigo = ?");
                st.setInt(1, codigo);
                int resultado = st.executeUpdate(); // executa o DELETE na tabela do BD
                if (resultado==1){ // Deletou (excluiu)
                   out.print("<p>Dados excluídos com sucesso</p>");
                } else{ //Não encontrou e não excluiu
                   out.print("<p>Este código não está cadastrado</p>"); 
                }
                // 4) Desconectar do banco de dados
                conexao.close();

            } catch (ClassNotFoundException x) {
                out.print("Você não colocou o driver JDBC no projeto " + x.getMessage());
            } catch (SQLException x) {
                    out.println("Erro número:" + x.getErrorCode());
                    out.println("Entre em contato com o administrador do sistema");
            }
        %>       
    </body>
</html>
