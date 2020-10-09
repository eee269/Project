package member;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.swing.*;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

public class MailSend{
//전역변수 사용안함.

    //action
    public void MailSet(String user, int random){
        Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");
        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 호스트
        p.put("mail.smtp.auth","true");
        p.put("mail.smtp.port", "587");                 // gmail 포트

        Authenticator auth = new GoogleAuthentication();    //구글 계정 인증

        //session 생성 및  MimeMessage생성
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        String fromName = "YJ 홈페이지 관리자";
        String charSet = "UTF-8";

        try{
            // 편지보낸시간 설정
            msg.setSentDate(new Date());

            // 송신자 설정
            InternetAddress from = new InternetAddress() ;
            from = new InternetAddress(new String(fromName.getBytes(charSet), "8859_1") + "<skfkd3123@gmail.com>");
            msg.setFrom(from);

            // 수신자 설정
            InternetAddress to = new InternetAddress(user);
            msg.setRecipient(Message.RecipientType.TO, to);

            // 제목 설정
            msg.setSubject("회원가입을 위한 이메일 확인 바랍니다.", "UTF-8");

            msg.setText("가입하시기 위해 다음의 내용을 입력하세요.<br><h2>인증 문자: "+
                random + " </h2>", "UTF-8");  //내용 설정

            // 메일 송신
            Transport.send(msg);

            System.out.println("메일 발송을 완료하였습니다.");
        }catch (AddressException addr_e) {  //예외처리 주소를 입력하지 않을 경우
            JOptionPane.showMessageDialog(null, "메일을 입력해주세요", "메일주소입력", JOptionPane.ERROR_MESSAGE);
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) { //메시지에 이상이 있을 경우
            JOptionPane.showMessageDialog(null, "메일을 제대로 입력해주세요.", "오류발생", JOptionPane.ERROR_MESSAGE);
            msg_e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

