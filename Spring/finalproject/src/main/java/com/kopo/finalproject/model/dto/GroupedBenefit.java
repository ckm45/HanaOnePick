package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
@Data
@Getter
@Setter
public class GroupedBenefit {
    private List<String> storeNames;
    private Float benefitAmount;
    private String benefitCode;
    private int benefitMax;
}