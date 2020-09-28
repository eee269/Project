<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-09-23
  Time: 오후 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String id = (String) session.getAttribute("id");
    String pass = request.getParameter("pass");

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass);

    switch (check) {
    case 1:
        mdao.deleteMember(id, pass);

        session.invalidate();
        response.sendRedirect("main.jsp");
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
