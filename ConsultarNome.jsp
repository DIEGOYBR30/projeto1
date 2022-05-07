<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Consultar produtos por nome</title>
        <link rel="stylesheet" href="formata_tabela.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Amatic+SC&family=Rajdhani:wght@300&family=Shadows+Into+Light&display=swap" rel="stylesheet">
    </head>
    <body>
        <%
            //1) Receber o nome do produto
            String nome;
            nome = request.getParameter("nome");
            try {
                //2) Conectar no Banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/bancoterca", "root", "2907");

                //3) Buscar o nome do produto na tabela
                PreparedStatement st = conexao.prepareStatement("SELECT * FROM produtos WHERE nome LIKE ?");
                st.setString(1, "%" + nome + "%");

                ResultSet resultado = st.executeQuery();

                //4) Se o produto for encontrado, exibir os dados
                //   Senão, exibir uma mensagem avisando que o produto não foi encontrado
                out.print("<table>");
                out.print("<tr><th>Código</th><th>Nome</th><th>Marca</th><th>Preço</th><th>Exclusão</th>"
                + "<th>Alteração</th></tr>");
                while (resultado.next()) { //Faça enquanto tiver produtos na variável resultado
                    out.print("<tr><td>" + resultado.getString("codigo") + "</td><td>" + resultado.getString("nome") + "</td><td>" + resultado.getString("marca") + "</td><td>" + resultado.getString("preco") + "</td><td><a href='ExcluirProdutos.jsp?codigo=" + resultado.getString("codigo") + "'>Excluir</a></td><td><a href='BuscarProdutos.jsp?codigo=" + resultado.getString("codigo") + "'>Alterar</a></td></tr>");
            }
                out.print("</table>");

                //5) Fechar a conexão com o banco de dados
                conexao.close();
            } catch (ClassNotFoundException x) {
                out.print("Você não colocou o driver JDBC no projeto " + x.getMessage());
            } catch (SQLException x) {
                out.println("Erro de SQL. Entre em contato com o administrador do sistema " + x.getMessage());
            }
        %>
    </body>
</html>
