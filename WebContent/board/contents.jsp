<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Board_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    bdao.updateReadcount(num);
    BoardBean bb = bdao.getBoard(num);
%>

<section>
    <div class="write">
        <fieldset>
            <h2><%=bb.getTitle()%></h2>
            <p><span><%=bb.getId()%></span> &nbsp; <%=bb.getDate()%></p>
            <hr>
                <pre class="content"><%=bb.getContent()%></pre>
                <hr>
<%--                댓글자리--%>
            <input type="button" value="List" onclick="location.href='boardMain.jsp'"
                   class="button" style="float: right">
            <input type="submit" value="Delete"  onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'"
                   class="button" style="float: right">
            <input type="submit" value="Update"  onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'"
                   class="button" style="float: right">
        </fieldset>
    </div>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
