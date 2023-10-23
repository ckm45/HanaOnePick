package com.kopo.finalproject.mail.controller;

import com.kopo.finalproject.mail.model.dto.MailDataDTO;
import com.kopo.finalproject.mail.service.MailService;
import com.kopo.finalproject.model.dto.GroupedBenefit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;

@Controller
public class MailController {

    @Autowired
    MailService mailService;

    @PostMapping("/mailConfirm")
    public ResponseEntity<?> mailConfirm(@RequestBody MailDataDTO mailData) {
        try {
            System.out.println(mailData);
            List<String> emails = mailData.getEmail();
            String author = mailData.getAuthor();
            String content = mailData.getContent();
            String fileName = mailData.getFileName();
            String cardName = mailData.getCardName();
            String cardSubTitle = mailData.getCardSubTitle();
            int annualFee = mailData.getAnnualFee();

            Map<String, GroupedBenefit> benefitIndustryMap = mailData.getBenefitIndustryMap();
            for (String email : emails) {
                System.out.println("email : " + email);
                String code = mailService.sendSimpleMessage(email, author, content, fileName, cardName, cardSubTitle, annualFee, benefitIndustryMap);
                // System.out.println("인증코드 : " + code);
            }

            return ResponseEntity.ok().body("메일 전송 성공!");
        } catch (
                Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("서버 오류 발생!");
        }
    }
}
