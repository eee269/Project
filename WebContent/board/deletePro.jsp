<%@ page import="member.MemberDAO" %>
<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-09-24
  Time: 오전 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>YEJIN_Board_Delete</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String id = (String) session.getAttribute("id");
    String pass = request.getParameter("pass2");

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass);

    switch (check) {
        case 1:
            BoardDAO boardDAO = new BoardDAO();
            boardDAO.deleteBoard(num, id);
%>
<script type="text/javascript">
    alert("게시물이 삭제되었습니다.");
    location.href = "boardMain.jsp";
</script>
<%
            break;
        case 0:
%>
<script type="text/javascript">
    alert("비밀번호를 확인하세요");
    history.back();
</script>
<%
        break;
    case -1:
%>
<script type="text/javascript">
    alert("아이디를 확인하세요");
    history.back();
</script>
<%
    }
%>


</body>
</html>
