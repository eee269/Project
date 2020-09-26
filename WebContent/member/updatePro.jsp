<%@ page import="java.sql.Timestamp" %>
<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>updatePro.jsp</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String pass1 = request.getParameter("pass1");
    String pass2 = request.getParameter("pass2");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String postcode = request.getParameter("postcode");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    Timestamp date = Timestamp.valueOf(request.getParameter("date"));
    String phone = request.getParameter("phone");
    int age = Integer.parseInt(request.getParameter("age"));

    MemberBean mb = new MemberBean();

    if(pass1.length() >= 8 && pass1.length() <= 12) {
        if(pass1.equals(pass2)) {
            mb.setPass(pass1);
        } else {
%>
<script type="text/javascript">
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
</script>
<%
    }
} else {
%>
<script type="text/javascript">
    alert("비밀번호는 8글자 이상 12글자 이하를 만족해야 합니다.");
    history.back();
</script>
<%
    }
    mb.setId(id);
    mb.setName(name);
    mb.setPostcode(postcode);
    mb.setAddress1(address1);
    mb.setAddress2(address2);
    mb.setEmail(email);
    mb.setDate(date);
    mb.setAge(age);
    mb.setPhone(phone);
    mb.setGender(gender);

    MemberDAO mdao = new MemberDAO();
    mdao.updateMember(mb);
%>
<script type="text/javascript">
    alert("회원가입을 축하합니다!");
    location.href="main.jsp";
</script>

</body>
</html>