package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ToCompareBenefitDTO {
        private int cardId;
        private int smallerValue;
        private int largerValue;
}
