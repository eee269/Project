<%@ page import="board.BoardBean" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    String pass2 = request.getParameter("pass2");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    Timestamp date = new Timestamp(System.currentTimeMillis());
    int readcount = 0;

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass2);

    BoardDAO bdao = new BoardDAO();
    BoardBean bb = new BoardBean();

    bb.setId(id);
    bb.setPass(pass2);
    bb.setTitle(title);
    bb.setContent(content);
    bb.setDate(date);
    bb.setReadcount(readcount);

    switch (check) {
        case 1:
            bdao.insertBoard(bb);
            %>
            <script type="text/javascript">
                alert("게시글이 작성되었습니다.");
                location.href="boardMain.jsp"
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