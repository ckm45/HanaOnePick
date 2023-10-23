package com.kopo.finalproject.firebase;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Scanner;

@Slf4j
@Service
public class FCMNotificationService {
    private static final String PROJECT_ID = "hanaonepick";
    private static final String BASE_URL = "https://fcm.googleapis.com";
    private static final String FCM_SEND_ENDPOINT = "/v1/projects/" + PROJECT_ID + "/messages:send";
    private static final String MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
    private static final String[] SCOPES = {MESSAGING_SCOPE};
    public static final String MESSAGE_KEY = "message";

    private static HttpURLConnection getConnection() throws IOException {
        URL url = new URL(BASE_URL + FCM_SEND_ENDPOINT);
        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
        httpURLConnection.setRequestProperty("Authorization", "Bearer " + getAccessToken());
        httpURLConnection.setRequestProperty("Content-Type", "application/json; charset=UTF-8"); // charset 추가
        return httpURLConnection;
    }

    private static final String CREDENTIALS_PATH = "C:\\Users\\user\\Downloads\\finalproject\\finalproject\\src\\main\\resources\\hanaonepick-firebase-adminsdk.json";

    private static String getAccessToken() throws IOException {
        String firebaseConfigPath = "/hanaonepick-firebase-adminsdk.json";
        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(new ClassPathResource(firebaseConfigPath).getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));
        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }

    private static String inputstreamToString(InputStream inputStream) throws IOException {
        StringBuilder stringBuilder = new StringBuilder();
        Scanner scanner = new Scanner(inputStream);
        while (scanner.hasNext()) {
            stringBuilder.append(scanner.nextLine());
        }
        return stringBuilder.toString();
    }


    public static void sendMessage(JsonObject FCMNotificationRequestDto) throws IOException {
        HttpURLConnection connection = getConnection();
        System.out.println("connection : " + connection);
        System.out.println("FCMNotificationRequestDto : " + FCMNotificationRequestDto);
        connection.setDoOutput(true);
        DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream());
        outputStream.write(FCMNotificationRequestDto.toString().getBytes("UTF-8")); // 수정된 부분

        outputStream.flush();
        outputStream.close();

        int responseCode = connection.getResponseCode();
        if (responseCode == 200) {
            String response = inputstreamToString(connection.getInputStream());
            System.out.println("Message sent to Firebase for delivery, response:");
            System.out.println(response);
        } else {
            System.out.println("Unable to send message to Firebase:");
            String response = inputstreamToString(connection.getErrorStream());
            System.out.println(response);
        }
    }
    private static JsonObject buildNotificationMessage(String title, String body, String token, String imageUrl) {
        JsonObject jNotification = new JsonObject();
        jNotification.addProperty("title", title);
        jNotification.addProperty("body", body);

        JsonObject jData = new JsonObject();
        jData.addProperty("icon", imageUrl);  // 이미지 URL을 data 필드에 추가

        JsonObject jMessage = new JsonObject();
        jMessage.add("notification", jNotification);
        jMessage.add("data", jData);  // data를 여기에 추가합니다.
        jMessage.addProperty("token", token);

        JsonObject jFcm = new JsonObject();
        jFcm.add(MESSAGE_KEY, jMessage);

        return jFcm;
    }

//    private static JsonObject buildNotificationMessage(String title, String body, String token, String imageUrl) {
//        JsonObject jNotification = new JsonObject();
//        jNotification.addProperty("title", title);
//        jNotification.addProperty("body", body);
//        jNotification.addProperty("icon", imageUrl);  // 이미지 URL 추가
//
//        JsonObject jMessage = new JsonObject();
//        jMessage.add("notification", jNotification);
//        jMessage.addProperty("token", token);  // token을 여기에 추가합니다.
//
//        JsonObject jFcm = new JsonObject();
//        jFcm.add(MESSAGE_KEY, jMessage);
//
//        return jFcm;
//    }

    public static void sendCommonMessage(String title, String body, String token) throws IOException {
//        String imageUrl = "http://localhost:8080/img2.png";
        String imageUrl = "https://hanaonepick.o-r.kr:8443/img2.png";
        JsonObject notificationMessage = buildNotificationMessage(title, body, token, imageUrl);
        System.out.println("FCM request body for message using common notification object:");
        prettyPrint(notificationMessage);
        sendMessage(notificationMessage);
    }

    private static void prettyPrint(JsonObject jsonObject) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        System.out.println(gson.toJson(jsonObject) + "\n");
    }

}
