<%@ page import="member.MemberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <title>ID dupCheck</title>
    <script type="text/javascript">
        function idok() {
            window.close();
        }
    </script>
</head>
<body style="align-items: center">
<br>
<%
    String wid = request.getParameter("id");
    MemberDAO memberDAO = new MemberDAO();
    int check = memberDAO.dupCheck(wid);

    switch (check) {
        case 1:
            out.print("<h2>아이디 중복</h2>");
            %>
<br>
<form action="dupCheck.jsp" method="post" name="wfr">
    <strong>아이디를 다시 입력하세요.</strong><br><br>
    <input type="text" name="wid" value="<%=wid%>" class="text">
    <input type="submit" value="아이디 중복 체크" class="button">
</form>
<%
            break;
        case 0:
            out.print("<h2>사용 가능</h2><br><br>");
            %>
<input type="button" value="아이디 사용" onclick="idok()" class="button">
<%
            break;
    }
%>

</body>
</html>
