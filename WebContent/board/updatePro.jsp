<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.BoardBean" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-09-24
  Time: 오전 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String id = request.getParameter("id");
    String pass2 = request.getParameter("pass2");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    Timestamp date = new Timestamp(System.currentTimeMillis());

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass2);

    BoardDAO bdao = new BoardDAO();
    BoardBean bb = new BoardBean();

    bb.setNum(num);
    bb.setId(id);
    bb.setPass(pass2);
    bb.setTitle(title);
    bb.setContent(content);
    bb.setDate(date);

    switch (check) {
        case 1:
            bdao.updateBoard(bb);
%>
<script type="text/javascript">
    alert("게시글이 수정되었습니다.");
    location.href="contents.jsp?num=<%=num%>"
</script>
<%
        break;
    case 0:
%>
<script type="text/javascript">
    alert("비밀번호를 확인하세요.");
    history.back();
</script>
<%
        break;
    case -1:
%>
<script type="text/javascript">
    alert("잘못된 접근입니다. 다시 로그인 하세요.");
    location.href="../member/loginForm.jsp"
</script>
<%
    }
%>

</body>
</html>
