package com.kopo.finalproject.model.dto;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.List;

@Data
@Component
public class PerformanceResponse {
    private Integer thisMonthTotal;
    private List<Integer> distinctPerformanceValue;
}
