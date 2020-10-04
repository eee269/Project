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
    <title>replyDelete.jsp</title>
</head>
<body>
<%
    int reno = Integer.parseInt(request.getParameter("reno"));
    String rewriter = (String) session.getAttribute("id");

    BoardReplyDAO brdao = new BoardReplyDAO();
    brdao.deleteBoardReply(reno, rewriter);
%>
<script>
    alert("삭제되었습니다.");
    location.href="../contents.jsp";
</script>
</body>
</html>
