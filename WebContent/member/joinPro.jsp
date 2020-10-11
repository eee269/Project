<%@ page import="java.sql.Timestamp" %>
<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.Random" %>
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
        for (int i = 0; i < pass1.length(); i++) {
            char ch = pass1.charAt(i);
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z')) {
                %>
<script type="text/javascript">
    alert("비밀번호는 영문 대소문자, 숫자만 사용 가능합니다.");
    history.back();
</script>
<%
            }
        }
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