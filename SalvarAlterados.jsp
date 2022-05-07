<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salvar Alterados</title>
    </head>
    <body>
        <%
            // 1) Receber os dados vindos do formulário Alterar Produtos.html
            int codigo;
            String nome, marca;
            double preco;
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco").replace(",", "."));  //12.5

            try {
                // 2) Conectar com o Banco de dados

                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/bancoterca", "root", "2907");

                //3) Enviar os dados para a tabela do banco de dados
 

                PreparedStatement st = conexao.prepareStatement("UPDATE produtos SET nome= ?, marca= ?, preco= ? WHERE codigo = ?");
                st.setString(1, nome);
                st.setString(2, marca);
                st.setDouble(3, preco);
                st.setInt(4, codigo);

                st.executeUpdate(); // executa o INSERT na tabela do BD
                out.print("<p>Dados salvos com sucesso</p>");

                // 4) Desconectar do banco de dados
                conexao.close();

            } catch (ClassNotFoundException x) {
                out.print("Você não colocou o driver JDBC no projeto " + x.getMessage());
            } catch (SQLException x) {
                if (x.getErrorCode() == 1062) { //Tentativa de duplicação de chave primária (código)
                    out.print("Este código de produto já está cadastrado");
                } else {
                    out.println("Erro número:" + x.getErrorCode());
                    out.println("Entre em contato com o administrador do sistema");
                }
            }
        %>
    </body>    
</html>

