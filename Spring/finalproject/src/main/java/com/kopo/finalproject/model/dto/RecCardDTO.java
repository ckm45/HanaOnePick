package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class RecCardDTO {
    private int cardId;
    private String cardName;
    private String cardSubTitle;
    private String cardTypeCode;
    private int annualFee;
    private int discountAmount;
    private int accumulatedAmount;
}
