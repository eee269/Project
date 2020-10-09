<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Yejin</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>

<%--Banner...!--%>
<img src="../images/ponyo040.jpg" alt="banner" class="banner">

<section>
    <%--Info--%>
    <article class="left_notice">
        <h1>Yejin's Home..</h1><br><br>
        <p>
            잠겨 죽어도 좋으니 <br>
            너는 <br>
            물처럼 내게 밀려오라 <br>
            이정하, 낮은 곳으로</p>
    </article>
    <article style="position: absolute; left: 500px;">
        <h1>Board</h1>
        <br>
        <table class="mini_list">
            <tr class="mini_list_menu">
                <th>No.</th>
                <th>Title</th>
            </tr>
            <%
                int pageSize = 5, startRow = 1;
                BoardDAO boardDAO = new BoardDAO();
                List boardList = boardDAO.getBoardList(startRow, pageSize);

                for(int i=0; i<boardList.size(); i++) {
                    BoardBean boardBean = (BoardBean) boardList.get(i);
            %>
            <tr class="list_menu" onclick="location.href='../board/contents.jsp?num=<%=boardBean.getNum()%>'">
                <td><%=boardBean.getNum()%></td>
                <td><%=boardBean.getTitle()%></td>
            </tr>
            <%
                }
            %>
        </table>
    </article>
</section>


<jsp:include page="../inc/footer.jsp"/>
</body>
</html>