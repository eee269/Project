<%@ page import="board.BoardReplyDAO" %>
<%@ page import="board.BoardReplyBean" %>
<%@ page import="java.sql.Timestamp" %><%--
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
    request.setCharacterEncoding("utf-8");
    int brdno = Integer.parseInt(request.getParameter("brdno"));
    int reno = Integer.parseInt(request.getParameter("reno"));
    String rewriter = (String) session.getAttribute("id");
    String rememo = request.getParameter("rememo"+reno);
    Timestamp date = new Timestamp(System.currentTimeMillis());

    BoardReplyDAO boardReplyDAO = new BoardReplyDAO();
    BoardReplyBean boardReplyBean = new BoardReplyBean();
    boardReplyBean.setBrdno(brdno);
    boardReplyBean.setReno(reno);
    boardReplyBean.setRewriter(rewriter);
    boardReplyBean.setRememo(rememo);
    boardReplyBean.setRedate(date);
    boardReplyDAO.updateBoardReply(boardReplyBean);

%>
<script type="text/javascript">
    alert("수정되었습니다.");
    location.href = "../contents.jsp?num=<%=boardReplyBean.getBrdno()%>";
</script>
</body>
</html>
