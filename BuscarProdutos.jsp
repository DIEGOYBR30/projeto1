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
        <title>Ateração de Produtos</title>
    </head>
    <body>
        <%
            //1) Receber o código do produto
            int codigo;
            codigo = Integer.parseInt(request.getParameter("codigo"));
            try {
                //2) Conectar no Banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/bancoterca", "root", "2907");

                //3) Buscar o codigo do produto na tabela
                PreparedStatement st = conexao.prepareStatement("SELECT * FROM produtos WHERE codigo = ?");
                st.setInt(1, codigo);

                ResultSet resultado = st.executeQuery();

                //4) Se o produto for encontrado, exibir os dados
                //   Senão, exibir uma mensagem avisando que o produto não foi encontrado
                if (resultado.next()) {
        %>
        <form method="post" action="SalvarAlterados.jsp">
            <p>
                <label for="codigo">Codigo:</label>
                <input type="number" id="codigo" name="codigo" value="<%= resultado.getInt("codigo")%>">
            </p> 


            <p>
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= resultado.getString("nome")%>">
            </p>

            <p>
                <label for="marca">Marca:</label>
                <input type="text" id="marca" name="marca" value="<%= resultado.getString("marca")%>">
            </p>
            <input type="text" name="preco" id="preco" pattern="[0-9]{1,9}\,[0-9]{1,2}$" value="<%= resultado.getString("preco").replace(".", ",")%>">                

            <input type="submit" value="Salvar alterações">                
            </p>
        </form>

        <%
                } else {
                    out.print("<b> Produto não localizado");
                }
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
