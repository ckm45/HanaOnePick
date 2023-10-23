package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dto.*;

import java.util.List;
import java.util.Map;


public interface MemberService {
    //일반 로그인
    MemberDTO memberLoginCheck(String ckId, String ckPw);

    List<MyCardDTO> getCardList(String memberId);

    List<Integer> getDistinctPerformanceValue(int cardId);

    List<TransactionHistoryDTO> getTransactionHistoryList(String cardNumber, String selectedDate);

    List<BenefitDTO> getBenefitListByCardNumber(String cardNumber);
    Integer getThisMonthTotal(int cardId,String memberId);

    Map<Integer,List<BenefitDTO>> comparingBenefit(ToCompareBenefitDTO toCompareBenefitDTO);

    List<TransactionChartDTO> getTransactionChartList(String cardNumber, String selectedDate);
    List<TransactionChartDTO> getTotalChartList(String memberId);

    Map<Integer,List<Integer>> getBenefitSumGroupByCardId(String memberId);
    List<Integer> getBenefitSum(String cardNumber, String memberId);
    CardDTO getCardInfo(String memberId);
    CardDTO getCardInfoByCardId(Integer cardId);
    TransactionDetailDTO getTransactionDetail(String memberId, String transactionDate, String cardNumber, String transactionIndustryName, String transactionStoreName, int transactionAmount);

}
