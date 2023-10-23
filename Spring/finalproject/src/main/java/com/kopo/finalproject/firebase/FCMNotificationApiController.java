package com.kopo.finalproject.firebase;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@Slf4j
public class FCMNotificationApiController {



    @PostMapping("/storeToken")
    @ResponseBody
    public ResponseEntity<?> storeToken(@RequestBody Map<String, String> payload, HttpSession session) {
        String token = payload.get("token");
        if(token != null && !token.isEmpty()) {
            session.setAttribute("firebaseToken", token);
            System.out.println("token : " + token);
            return ResponseEntity.ok(Map.of("message", "Token stored successfully"));
        }
        return ResponseEntity.badRequest().body(Map.of("error", "Invalid token"));
    }



    @PostMapping("/fcm")
    public ResponseEntity<?> reqFcm(
            @RequestParam(required = true) String title,
            @RequestParam(required = true) String body,
            @RequestParam(required = true) String token
    ) {

        log.info("** title : {}", title);
        log.info("** body : {}", body);

        try {
            FCMNotificationService.sendCommonMessage(title, body, token);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("Error sending FCM notification:", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok("success");
    }

}
