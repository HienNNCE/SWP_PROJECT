package EmailSender;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.util.Random;

public class EmailSender {

    public static void sendEmail(String to, String subject, String content) throws MessagingException {
        final String from = "todentsukanai@gmail.com"; // your email
        final String password = "cvpv pefu nngl qxlc"; // app password (not regular email password)

        // SMTP server configuration
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Compose message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(
            Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);

        // Send message
        Transport.send(message);
    }
    
    public static String generateFiveRandomNumbersString() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 5; i++) {
            int number = random.nextInt(10); // generates number from 0 to 9
            sb.append(number);

            if (i < 4) {
                sb.append("");
            }
        }

        return sb.toString();
    }
}
