<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MailSend" %>
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
    MemberBean memberBean = memberDAO.getMember(id);
    int randomCheck = memberDAO.getUserEmailHash(id);
    boolean emailChecked = memberBean.isEmailChecked();
%>
    <script>
        function emailChecked() {
            var randomCheckValue = document.checkform.randomCheck.value;
            if(randomCheckValue != <%=randomCheck%>) {
                alert("다시 입력하세요.");
                document.checkform.action="../member/mailCheck.jsp";
                document.checkform.submit();
            } else {
                <%
                memberDAO.setUserEmailChecked(id);
                %>
                alert("인증이 완료되었습니다!");
                location.href="loginForm.jsp";
            }
        }
    </script>
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>

<%
    if(!emailChecked) {
%>
<fieldset style="padding: 200px 400px; text-align: center; border: none">
    <h1>인증번호를 입력하세요.</h1>
    <form action="../member/mailSend.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="email" value="<%=memberBean.getEmail()%>">
        <p>인증 메일 재전송을 원하시면 버튼을 눌러주세요.</p>
        <input type="submit" value="재전송" class="button"><br>
    </form>
    <form method="post" name="checkform">
        <br>
        <input type="text" name="randomCheck" placeholder="인증번호를 입력하세요." class="text" required>
        <br><br>
        <input type="submit" value="입력 완료" onclick="emailChecked()" class="button">
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
