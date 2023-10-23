package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter

public class SearchResultDTO {
    private int cardId;
    private String cardName;
    private String benefitCode;
    private float benefitAmount;
    private int benefitMax;
    private String cardSubtitle;
}
