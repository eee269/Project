<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Properties" %>
<%@ page import="member.GoogleAuthentication" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.*" %><%--
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
    String sender = "skfkd3123@gmail.com";
    String receiver = request.getParameter("email");
    String subject = "회원가입을 위한 이메일 확인 바랍니다.";
    String content = "가입하시기 위해 다음의 내용을 입력하세요.<br><h2>인증 문자: "+
            random + " </h2>";
    response.setContentType("text/html;charset=UTF-8");

    try {
        Properties properties = System.getProperties();
        properties.put("mail.stmp.starttls.enable", "true");
        properties.put("mail.stmp.host", "smtp.gmail.com");
        properties.put("mail.stmp.auth", "true");
        properties.put("mail.stmp.port", "587");
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

        out.print("<h3>메일이 정상적으로 정송되었습니다.</h3>");
        RequestDispatcher rd =
                request.getRequestDispatcher("../member/mailCheck.jsp?id=" + id + "&email=" + receiver);
        rd.forward(request, response);
    } catch (Exception e) {
        response.sendRedirect("mailCheck.jsp");
        e.printStackTrace();
    }
%>


</body>
</html>
