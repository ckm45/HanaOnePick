package com.kopo.finalproject.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TransactionDetailDTO {
    int transactionId;
    String transactionDate;
    int transactionAmount;
    String cardNumber;
    String memberId;
    String transactionIndustryCode;
    String transactionStoreName;
    int AccumulationSum;
    int discountAmount;
}
