package com.kopo.finalproject.mail.model.dto;

import com.kopo.finalproject.model.dto.GroupedBenefit;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

@Data
@Getter
@Setter
public class MailDataDTO {
    private List<String> email;
    private String author;
    private String content;
    private String fileName;
    private String cardName;
    private String cardSubTitle;
    private int annualFee;
    private Map<String, GroupedBenefit> benefitIndustryMap;

}
