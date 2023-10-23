package com.kopo.finalproject.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@Getter
@Setter
public class TransactionHistoryDTO {
    int transactionId;
    String transactionDate;
    int transactionAmount;
    String cardNumber;
    String memberId;
    String transactionIndustryCode;
    String transactionStoreName;
}
