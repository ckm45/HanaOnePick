package com.kopo.finalproject.naverSMS;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kopo.finalproject.naverSMS.Request;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController
@RequiredArgsConstructor
public class SmsController {

    private final SmsService smsService;

    @PostMapping("/user/sms")
    public ResponseEntity<SmsResponse> test(@RequestBody Request request, HttpSession session) throws NoSuchAlgorithmException, URISyntaxException, UnsupportedEncodingException, InvalidKeyException, JsonProcessingException {
        System.out.println("sms 컨틀롤러 들어옴");
        System.out.println(request.getRandomNumber());
        int randomNumber = request.getRandomNumber();
        session.setAttribute("randomNumber", randomNumber);
        SmsResponse data = smsService.sendSms(request.getRecipientPhoneNumber(), request.getContent());
        return ResponseEntity.ok().body(data);
    }
    @PostMapping("/user/auth")
    public String processAuthNumber(@RequestBody String json,HttpSession session) {
        try {
            // JSON 데이터 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(json);

            // JSON 데이터에서 인증번호 추출
            String inputNumber = rootNode.path("authNumber").asText();
            System.out.println("인증번호 입력: " + inputNumber);
            // 여기서 필요한 작업을 수행합니다.
            int authNumber = (int)session.getAttribute("randomNumber");
            //authNumber를 string으로 변환
            String authNumberString = Integer.toString(authNumber);
            System.out.println("인증번호: " + authNumber);
            if(inputNumber.equals(authNumberString)) {
                session.removeAttribute("randomNumber");
                return "Success";
            }else {
                return "Fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error"; // 에러 응답
        }
    }
}