package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class BenefitDTO {
    private int benefitId;
    private int cardId;
    private int cardPerformance;
    private String benefitCode;;
    private String benefitIndustryCode;
    private String benefitStoreName;
    private float benefitAmount;
    private int benefitMax;
    private String benefitGroupCode;
}
