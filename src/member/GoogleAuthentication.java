package member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
    PasswordAuthentication passAuth;

    public GoogleAuthentication() {
        passAuth = new PasswordAuthentication("skfkd3123", "zjjnqlqefpycivic");
    }

    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
