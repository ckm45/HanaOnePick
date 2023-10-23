package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CardDTO {
    private int cardId;
    private String cardName;
    private String cardSubTitle;
    private String cardTypeCode;
    private int annualFee;
}
