package com.kopo.finalproject.mail.service;

import com.kopo.finalproject.model.dto.GroupedBenefit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.text.NumberFormat;
import java.util.List;
import java.util.Map;
@Service
public class MailService {

    @Autowired
    JavaMailSender emailsender; // Bean 등록해둔 MailConfig 를 emailsender 라는 이름으로 autowired

    private String ePw; // 인증번호

    // 메일 내용 작성
    public MimeMessage createMessage(String to, String author, String content, String fileName, String cardName, String cardSubTitle, int annualFee, Map<String, GroupedBenefit> benefitIndustryMap) throws MessagingException, IOException {
        MimeMessage message = emailsender.createMimeMessage();

        message.addRecipients(RecipientType.TO, to);
        message.setSubject(author + "의 이달의 카드");

        StringBuilder msgg = new StringBuilder();
        msgg.append((content == null) ? "" : content);
        // The general message header
        msgg.append("<div style='margin:100px; padding: 20px; border:1px solid #E0E0E0; font-family: Arial, sans-serif;'>");
        msgg.append("<h1 style='color: #333; border-bottom: 2px solid #E0E0E0; padding-bottom: 10px;'>HanaOnePick의 이달의 카드</h1>");
        msgg.append("<img src='cid:image' style='width:300px; height:auto; margin:20px 0;'/>");  // Image positioned under the title
        msgg.append("<p style='color: #555; font-size: 30px'>").append(cardName).append("</p>");
        msgg.append("<p style='color: #777; font-size: 20px'>").append(cardSubTitle).append("</p>");
        msgg.append("<p style='color: #888; margin-bottom: 20px; font-size: 15px'>연회비: ").append(NumberFormat.getInstance().format(annualFee)).append(" 원</p>");
        msgg.append("<hr style='border-color: #E0E0E0; margin-bottom: 20px;'>");
        msgg.append("<h2 style='color: #444;'>카드 혜택</h2>");

        // The benefits section
        for (Map.Entry<String, GroupedBenefit> entry : benefitIndustryMap.entrySet()) {
            String key = entry.getKey();
            GroupedBenefit benefit = entry.getValue();
            msgg.append("<div style='padding: 5px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); font-size: 15px; width:500px;'>");
            msgg.append("<strong>혜택업종 : </strong>");

            switch (key) {
                case "AL":
                    msgg.append("국내 가맹점");
                    break;
                case "SH":
                    msgg.append("쇼핑");
                    break;
                case "FD":
                    msgg.append("국내 음식점");
                    break;
                case "CT":
                    msgg.append("문화시설");
                    break;
                case "CS":
                    msgg.append("편의점");
                    break;
                case "CE":
                    msgg.append("카페");
                    break;
                case "PT":
                    msgg.append("대중교통");
                    break;
                case "ED":
                    msgg.append("교육");
                    break;
                case "MT":
                    msgg.append("마트");
                    break;
                case "MD":
                    msgg.append("의료");
                    break;
                case "OL":
                    msgg.append("주유");
                    break;
                default:
                    break;
            }

            msgg.append("<br>");
            msgg.append("<strong>혜택가맹점 : </strong>");

            List<String> storeNames = benefit.getStoreNames();
            for (int i = 0; i < storeNames.size(); i++) {
                msgg.append(storeNames.get(i));
                if (i != storeNames.size() - 1) {
                    msgg.append(", ");
                }
            }

            msgg.append("<br>");

            switch (benefit.getBenefitCode().trim()) {
                case "DCVC":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f 원 할인 월 최대 %d회", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "DCPC":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f %% 할인 월 최대 %d회", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "DCVA":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f 원 할인 월 최대 %d원", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "DCPA":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f %% 할인 월 최대 %d원", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "ACPC":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f %% 적립 월 최대 %d회", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "ACVC":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f 원 적립 월 최대 %d회", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "ACPA":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f %% 적립 월 최대 %d원", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "ACVA":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f 원 적립 월 최대 %d원", benefit.getBenefitAmount(), benefit.getBenefitMax()));
                    break;
                case "ACPN":
                    msgg.append(String.format("<strong>혜택내용 : </strong> %,.0f %% 적립 월 한도 없음", benefit.getBenefitAmount()));
                    break;
                default:
                    break;
            }
            msgg.append("<br>");
            msgg.append("</div>");
            msgg.append("<br>");
        }

        msgg.append("</div>"); // Closing the main div

        // Create a MimeBodyPart for the HTML content
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(msgg.toString(), "text/html; charset=utf-8");

        MimeBodyPart imagePart = new MimeBodyPart();
//        String filePath = "C:\\Users\\user\\Downloads\\finalproject\\finalproject\\src\\main\\webapp\\resources\\img\\" + fileName;

//        DataSource source = new FileDataSource(filePath);
//        imagePart.setDataHandler(new DataHandler(source));
//        imagePart.setHeader("Content-ID", "<image>");

        String filePath = "https://hanaonepick.o-r.kr:8443/resources/img/" + fileName;

        URL imageUrl = new URL(filePath);
        URLConnection connection = imageUrl.openConnection();
        InputStream is = connection.getInputStream();
        DataSource source = new ByteArrayDataSource(is, "image/jpeg"); // MIME 타입은 실제 이미지에 따라 조정될 수 있습니다.

        imagePart.setDataHandler(new DataHandler(source));
        imagePart.setHeader("Content-ID", "<image>");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(htmlPart);
        multipart.addBodyPart(imagePart);

        message.setContent(multipart);
        message.setFrom(new InternetAddress("ckm45@naver.com", "최경민"));

        return message;
    }


    // 메일 발송
    // sendSimpleMessage 의 매개변수로 들어온 to 는 곧 이메일 주소가 되고,
    // MimeMessage 객체 안에 내가 전송할 메일의 내용을 담는다.
    // 그리고 bean 으로 등록해둔 javaMail 객체를 사용해서 이메일 send!!
    public String sendSimpleMessage(String to, String author, String content, String fileName, String cardName, String cardSubTitle, int annualFee, Map<String, GroupedBenefit> benefitIndustryMap) throws Exception {
        // TODO Auto-generated method stub
        MimeMessage message = createMessage(to,author,content,fileName,cardName,cardSubTitle,annualFee,benefitIndustryMap); // 메일 발송
        try {// 예외처리
            sslTrustAllCerts();
            emailsender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }


        return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
    }

    public void sslTrustAllCerts(){
        TrustManager[] trustAllCerts = new TrustManager[] {
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) { }
                    public void checkServerTrusted(X509Certificate[] certs, String authType) { }
                }
        };

        SSLContext sc;

        try {
            sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}