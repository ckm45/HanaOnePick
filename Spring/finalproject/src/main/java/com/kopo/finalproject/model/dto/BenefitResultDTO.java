package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BenefitResultDTO {
    private String cardName;
    private String benefitCode;
    private float benefitAmount;
    private int benefitMax;
}
