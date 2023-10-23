package com.kopo.finalproject.model.dto;

import lombok.Data;

@Data
public class NotBenefitResultDTO {
    private int lastMonthTotal;
    private int cardPerformance;
    private int cardId;
    private String cardName;
    private String cardSubtitle;
}
