<%@ page import="member.MemberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>emailChecked</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    int randomCheck = Integer.parseInt(request.getParameter("randomCheck"));

    MemberDAO memberDAO = new MemberDAO();
    int random = memberDAO.getUserEmailHash(id);

    if(random == randomCheck) {
        memberDAO.setUserEmailChecked(id);
        %>
<script type="text/javascript">
    alert("인증이 완료되었습니다.");
    location.href="../member/loginForm.jsp";
</script>
<%
    } else {
%>
<script type="text/javascript">
    alert("코드를 확인하세요.");
    history.back();
</script>
<%
    }
%>

</body>
</html>
