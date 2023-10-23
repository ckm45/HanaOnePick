package com.kopo.finalproject.model.dao;

import com.kopo.finalproject.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberDAO {
    MemberDTO memberLoginCheck(@Param("ckId") String ckId, @Param("ckPw") String ckPw);
    List<MyCardDTO> getCardList(String memberId);
    List<Integer> getDistinctPerformanceValue(int cardId);
    List<TransactionHistoryDTO> getTransactionHistoryListByCardNumber(@Param("cardNumberList") List<String> cardNumberList,@Param("selectedDateInt") int selectedDateInt);
    List<TransactionHistoryDTO> getAllTransactionHistoryListByCardNumber(@Param("cardNumberList") List<String> cardNumberList);
    List<TransactionHistoryDTO> getThisMonthTransactionHistoryListByCardNumber(@Param("cardNumberList") List<String> cardNumberList);
    List<BenefitDTO> getBenefitListByCardNumber(String cardNumber);
    Integer getThisMonthTotal(@Param("cardId") int cardId,@Param("memberId") String memberId);
    List<BenefitDTO> comparingBenefit(@Param("cardId") int cardId,@Param("cardPerformance") int cardPerformance);
    List<TransactionChartDTO> drawTransactionHistoryChartByCardNumber(@Param("cardNumberList") List<String> cardNumberList,@Param("selectedDate") int selectedDate);
    List<TransactionChartDTO> drawThisMonthTransactionHistoryChartByCardNumber(@Param("cardNumberList") List<String> cardNumberList);
    List<TransactionChartDTO> drawAllTransactionHistoryChartByCardNumber(@Param("cardNumberList") List<String> cardNumberList);
    List<TransactionHistoryDTO> getThisMonthTransactionHistory(@Param("memberId") String memberId, @Param("selectedDate") int selectedDate, @Param("cardNumber") String cardNumber);
    Integer getLastMonthTotal(@Param("transactionId") int transactionId, @Param("memberId") String memberId);
    int getCardIdByTransaction(int transactionId);
    BenefitDTO getBenefitAmountByTransaction(@Param("transactionId") int transactionId, @Param("lastMonthTotal") int lastMonthTotal, @Param("cardId") int cardId, @Param("memberId") String memberId);
    BenefitDTO getBenefitAmountByTransaction2();
    int getBenefitCountFromTransactionHistory(@Param("firstTransactionId") int firstTransactionId, @Param("transactionId") int transactionId, @Param("transactionIndustryCode") String transactionIndustryCode, @Param("cardNumber") String cardNumber);
    List<Integer> getTransactionAmountListFromTransactionHistory(@Param("firstTransactionId") int firstTransactionId, @Param("transactionId") int transactionId, @Param("transactionIndustryCode") String transactionIndustryCode, @Param("cardNumber") String cardNumber);
    Integer getTransactionAmountByTransactionId(int transactionId);
    CardDTO getCardInfo(@Param("memberId")String memberId);
    CardDTO getCardInfoByCardId(Integer cardId);
    int getTransactionId(@Param("memberId") String memberId,@Param("transactionDate") String transactionDate,@Param("cardNumber") String cardNumber,@Param("transactionIndustryCode") String transactionIndustryCode,@Param("transactionStoreName") String transactionStoreName, @Param("transactionAmount") int transactionAmount);
    int getFirstTransactionId(@Param("memberId") String memberId, @Param("firstTransactionDate") String firstTransactionDate);
    List<TransactionHistoryDTO> getSelectedDateTransanctionHistroyListByCardNumber(@Param("cardNumberList") List<String> cardNumberList,@Param("firstDate") String firstDate, @Param("secondDate") String secondDate);
    List<TransactionChartDTO> drawSelectedDateTransactionHistoryChartByCardNumber(@Param("cardNumberList") List<String> cardNumberList,@Param("firstDate") String firstDate,@Param("secondDate") String secondDate);
}