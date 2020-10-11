<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.BoardReplyBean" %>
<%@ page import="board.BoardReplyDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>replySubmit</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    BoardReplyBean brb = new BoardReplyBean();
    BoardReplyDAO brdao = new BoardReplyDAO();

    int reno = 0;
    if(request.getParameter("reno") != "")  reno = Integer.parseInt(request.getParameter("reno"));
    int brdno = Integer.parseInt(request.getParameter("brdno"));
    String rewriter = (String)session.getAttribute("id");
    String rememo = request.getParameter("rememo");
    Timestamp redate = new Timestamp(System.currentTimeMillis());

    brb.setBrdno(brdno);
    brb.setReno(reno);
    brb.setRewriter(rewriter);
    brb.setRememo(rememo);
    brb.setRedate(redate);

    if(reno == 0) {
        brdao.insertBoardReply(brb);
%>
<script>
    location.replace("../contents.jsp?num=<%=brdno%>");
</script>
<%
    }
%>

</body>
</html>
