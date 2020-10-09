package member;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

@WebServlet("/mailSend")
public class MailSendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MailSendServlet() {}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        MemberDAO memberDAO = new MemberDAO();
//
//        request.setCharacterEncoding("utf-8");
//        String id = request.getParameter("id");
//        int random = memberDAO.getUserEmailHash(id);
//        String sender = "skfkd3123@gmail.com";
//        String receiver = request.getParameter("email");
//        String subject = "회원가입을 위한 이메일 확인 바랍니다.";
//        String content = "가입하시기 위해 다음의 내용을 입력하세요.<br><h2>인증 문자: "+
//                random + " </h2>";
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        try {
//            Properties properties = System.getProperties();
////            properties.setProperty("mail.stmp.host", "localhost");
//            properties.put("mail.stmp.starttls.enable", "true");
//            properties.put("mail.stmp.host", "smtp.gmail.com");
//            properties.put("mail.stmp.auth", "true");
//            properties.put("mail.stmp.port", "465");
//            Authenticator auth = new GoogleAuthentication();
//            Session s = Session.getDefaultInstance(properties, auth);
//            Message message = new MimeMessage(s);
//            Address sender_address = new InternetAddress(sender);
//            Address receiver_address = new InternetAddress(receiver);
//            message.setHeader("content-type", "text/html;charset=UTF-8");
//            message.setFrom(sender_address);
//            message.addRecipient(Message.RecipientType.TO, receiver_address);
//            message.setSubject(subject);
//            message.setContent(content, "text/html;charset=UTF-8");
//            message.setSentDate(new java.util.Date());
//            Transport.send(message);
//
//            out.print("<h3>메일이 정상적으로 정송되었습니다.</h3>");
//            RequestDispatcher rd =
//                    request.getRequestDispatcher("../member/mailCheck.jsp?id=" + id);
//            rd.forward(request, response);
//        } catch (Exception e) {
//            out.print("STMP 서버가 잘못 설정되었거나, 서비스에 문제가 있습니다.");
//            e.printStackTrace();
//        }
    }

}
