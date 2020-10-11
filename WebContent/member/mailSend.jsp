<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Properties" %>
<%@ page import="member.GoogleAuthentication" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.*" %>
<%@ page import="member.MemberBean" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-10-09
  Time: 오후 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>mailSend</title>
</head>
<body>
<%
    MemberDAO memberDAO = new MemberDAO();

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    int random = memberDAO.getUserEmailHash(id);

    MemberBean memberBean = memberDAO.getMember(id);

    String sender = "skfkd3123@gmail.com";
    String receiver = memberBean.getEmail();
    String subject = "회원가입을 위한 이메일 확인 바랍니다.";
    String content = "가입하시기 위해 다음의 내용을 입력하세요.<br><h2>인증 문자: "+
            random + " </h2>";
    response.setContentType("text/html;charset=UTF-8");

    try {
        Properties properties = System.getProperties();
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "587");
        Authenticator auth = new GoogleAuthentication();
        Session s = Session.getDefaultInstance(properties, auth);
        Message message = new MimeMessage(s);
        Address sender_address = new InternetAddress(sender);
        Address receiver_address = new InternetAddress(receiver);
        message.setHeader("content-type", "text/html;charset=UTF-8");
        message.setFrom(sender_address);
        message.addRecipient(Message.RecipientType.TO, receiver_address);
        message.setSubject(subject);
        message.setContent(content, "text/html;charset=UTF-8");
        message.setSentDate(new java.util.Date());
        Transport.send(message);

        %>
<script type="text/javascript">
    alert("메일이 전송되었습니다.\n인증번호를 확인하세요.");
    location.href = "../member/mailCheck.jsp?id='<%=id%>'";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
