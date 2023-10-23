package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class MyCardDTO {
    private String cardNumber;
    private String cardPassword;
    private String validationPeriod;
    private int cvcNumber;
    private String cardRegDate;
    private int lastMonthTotal;
    private String cardStatus;
    private int cardId;
    private String memberId;
    private String cardName;

}
