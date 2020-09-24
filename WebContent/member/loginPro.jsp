<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginPro.jsp</title>
</head>
<body>
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass1");

MemberDAO mdao = new MemberDAO();
int check = mdao.userCheck(id, pass);

switch (check) {
	case 1:
		session.setAttribute("id", id);
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