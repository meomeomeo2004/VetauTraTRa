package controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.UUID;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class resetService {

    private final int LIMIT_MINUS = 10;
    private final String from = "kientrungnguyen001@gmail.com";
    private final String password = "lhqg gbki rhjg gork";

    public String generateToken() {
        return UUID.randomUUID().toString();
    }

    public String generateOTP() {
        return String.valueOf(100000 + (int) (Math.random() * 900000));
    }

    public LocalDateTime expireDateTime() {
        return LocalDateTime.now().plusMinutes(LIMIT_MINUS);
    }

    public boolean isExpireTime(LocalDateTime time) {
        return LocalDateTime.now().isAfter(time);
    }

    public boolean sendEmail(String to, String link, String name) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Reset Password", "UTF-8");
            String content = "<h1>Hello " + name + "</h1>" + "<p>Click the link to reset password "
                    + "<a href='" + link + "'>Click here</a></p>";
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("Send successfully");
            return true;
        } catch (Exception e) {
            System.out.println("Send error");
            e.printStackTrace();
            return false;
        }
    }

    public void sendRefundSuccess(String to, String userName, int ticketId, String bankAccount, String bankName, Long price) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Refund Money", "UTF-8");
            String content = "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
                    + "<h1 style='color: #4CAF50;'>Xin chào " + userName + ",</h1>"
                    + "<p>Yêu cầu hoàn tiền của bạn đã được xử lý thành công!</p>"
                    + "<table style='border-collapse: collapse; width: 100%;'>"
                    + "  <tr style='background-color: #f2f2f2;'>"
                    + "    <th style='padding: 8px; border: 1px solid #ddd;'>Mã vé</th>"
                    + "    <th style='padding: 8px; border: 1px solid #ddd;'>Số tài khoản</th>"
                    + "    <th style='padding: 8px; border: 1px solid #ddd;'>Ngân hàng</th>"
                    + "    <th style='padding: 8px; border: 1px solid #ddd;'>Số tiền hoàn trả</th>"
                    + "  </tr>"
                    + "  <tr>"
                    + "    <td style='padding: 8px; border: 1px solid #ddd;'>" + ticketId + "</td>"
                    + "    <td style='padding: 8px; border: 1px solid #ddd;'>" + bankAccount + "</td>"
                    + "    <td style='padding: 8px; border: 1px solid #ddd;'>" + bankName + "</td>"
                    + "    <td style='padding: 8px; border: 1px solid #ddd;'>" + String.format("%,d", price) + " VND</td>"
                    + "  </tr>"
                    + "</table>"
                    + "<p style='margin-top: 20px;'>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>"
                    + "</div>";
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("Send successfully");

        } catch (Exception e) {
            System.out.println("Send error");
            e.printStackTrace();

        }
    }

    public boolean sendOTPEmail(String to, String otp, String name) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Verify Your Email", "UTF-8");
            String content = "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
                    + "<h2 style='color: #3498db;'>Xin chào " + name + ",</h2>"
                    + "<p>Bạn đã yêu cầu mã OTP để xác minh địa chỉ email của mình.</p>"
                    + "<div style='padding: 20px; background-color: #f2f2f2; border-radius: 5px; text-align: center;'>"
                    + "  <h3 style='color: #e74c3c;'>Mã OTP của bạn là:</h3>"
                    + "  <p style='font-size: 24px; font-weight: bold;'>" + otp + "</p>"
                    + "</div>"
                    + "<p>Mã OTP này có hiệu lực trong vòng <strong>10 phút</strong>.</p>"
                    + "<p>Nếu bạn không yêu cầu, vui lòng bỏ qua email này.</p>"
                    + "<p>Trân trọng,</p>"
                    + "<p>Đội ngũ hỗ trợ TraTra</p>"
                    + "</div>";

            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("OTP email sent successfully");
            return true;
        } catch (Exception e) {
            System.out.println("OTP email send error");
            e.printStackTrace();
            return false;
        }
    }
}
