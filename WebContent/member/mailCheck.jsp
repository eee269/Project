<%@ page import="member.MemberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
<%
    request.setCharacterEncoding("utf-8");
    String id = (String) session.getAttribute("id");
    if (id == null)        id = request.getParameter("id");
    MemberDAO memberDAO = new MemberDAO();
    boolean emailChecked = memberDAO.getUserEmailChecked(id);
%>

</head>
<body>
<jsp:include page="../inc/nav.jsp"/>

<%
    if(emailChecked == false) {
%>
<fieldset style="padding: 200px 400px; text-align: center; border: none">
    <h1>인증번호를 입력하세요.</h1>
    <p>인증 메일 재전송을 원하시면 버튼을 눌러주세요.</p>
    <input type="button" value="재전송" class="button" onclick="location.href='../member/mailSend.jsp?id=<%=id%>'"><br>
    <form action="emailChecked.jsp" method="post" name="checkform">
        <input type="hidden" name="id" value="<%=id%>">
        <br>
        <input type="text" name="randomCheck" placeholder="인증번호를 입력하세요." class="text" required>
        <br><br>
        <input type="submit" value="입력 완료" class="button">
    </form>
</fieldset>
<%
    } else {
%>
<script type="text/javascript">
    alert("메일 인증이 완료되었습니다.\n로그인 해 주세요.");
    location.href="../member/loginForm.jsp";
</script>
<%
    }
%>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
