<%@ page import="board.BoardReplyDAO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-09-27
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>replyUpdate.jsp</title>
</head>
<body>
<%
    int reno = Integer.parseInt(request.getParameter("reno"));
    String rewriter = (String) session.getAttribute("id");

    BoardReplyDAO brdao = new BoardReplyDAO();
%>
</body>
</html>
