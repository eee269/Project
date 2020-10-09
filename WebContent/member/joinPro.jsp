<%@ page import="java.sql.Timestamp" %>
<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.Random" %>
<%@ page import="member.MailSend" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPro.jsp</title>
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
    Timestamp date = new Timestamp(System.currentTimeMillis());
    String phone = request.getParameter("phone");
    int age = request.getParameter("age").isEmpty()? 0: Integer.parseInt(request.getParameter("age"));
    Random random = new Random();

    MemberBean mb = new MemberBean();

    if(pass1.length() >= 8 && pass1.length() <= 12) {
        if(pass1.equals(pass2)) {
            mb.setPass(pass1);

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
            mb.setEmailHash(random.nextInt(999999));
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
    MemberDAO mdao = new MemberDAO();
    mdao.joinMember(mb);

//    request.getSession().setAttribute("id", id);
//    response.sendRedirect("/mailSend");
//
//    MailSend mailSend = new MailSend();
//    mailSend.MailSet(mb.getEmail(), mb.getEmailHash());
%>

<form action="../member/mailSend.jsp" method="post" id="fm">
    <input type="hidden" name="id" value="<%=mb.getId()%>">
    <input type="hidden" name="email" value="<%=mb.getEmail()%>">
</form>
<script type="text/javascript">
    document.getElementById("fm").submit();
</script>
</body>
</html>