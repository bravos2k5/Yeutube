package com.bravos.yeutube.utils;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Properties;

public class EmailUtils {

    private final String email;
    private final String password;
    private final String host;
    private final String port;
    private final Session session;

    private EmailUtils() {
        Properties properties = PropsUtils.getInstance().getResourceProperties();
        email = properties.getProperty("mail.email");
        password = properties.getProperty("mail.password");
        host = properties.getProperty("mail.host");
        port = properties.getProperty("mail.port");
        Properties props = getProps();
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        };
        session = Session.getInstance(props, authenticator);
    }

    private static class SingletonHelper {
        private static final EmailUtils INSTANCE = new EmailUtils();
    }

    public static EmailUtils getInstance() {
        return SingletonHelper.INSTANCE;
    }


    private Properties getProps() {
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.auth","true");
        return props;
    }

    public void sendEmail(String to, String subject, String text) {
        sendEmail(to,subject,text,null);
    }

    public void sendEmail(String to, String subject, String text, List<String> fileNames) {
        sendEmail(new String[]{to},subject,text,fileNames);
    }

    public void sendEmail(String[] to, String subject, String text) {
        sendEmail(to,subject,text,null);
    }

    public void sendEmail(String[] to, String subject, String text, List<String> fileNames) {
        MimeMessage msg = new MimeMessage(session);
        InternetAddress[] recipients = new InternetAddress[to.length];
        try {
            for (int i = 0; i < to.length; i++) {
                recipients[i] = new InternetAddress(to[i]);
            }
        } catch (AddressException e) {
            throw new RuntimeException(e);
        }
        try {
            msg.addHeader("Content-type","text/HTML; charset=UTF-8");
            msg.setFrom(email);
            msg.setSubject(subject);
            msg.setRecipients(Message.RecipientType.TO, recipients);
            msg.setSentDate(new Date());

            MimeBodyPart textBodyPart = new MimeBodyPart();
            textBodyPart.setText(text);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textBodyPart);

            if (fileNames != null) {
                for (String fileName : fileNames) {
                    MimeBodyPart attachmentBodyPart = new MimeBodyPart();
                    DataSource source = new FileDataSource(fileName);
                    attachmentBodyPart.setDataHandler(new DataHandler(source));
                    attachmentBodyPart.setFileName(new File(fileName).getName());
                    multipart.addBodyPart(attachmentBodyPart);
                }
            }

            msg.setContent(multipart);

            Transport.send(msg);

        } catch (MessagingException e) {
            if (e instanceof SendFailedException && e.getMessage().contains("550 5.1.1")) {
                System.err.println("Email address does not exist.");
            } else {
                System.err.println(e.getMessage());
            }
        }
    }

}
