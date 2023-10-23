package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dto.*;

import java.util.List;
import java.util.Map;

public interface AdminService {
    List<MemberDTO> getMemberList();
    List<searchChartDTO> getSearchChart();
    List<List<searchChartDTO>> getSearchChartByMonth();
    List<Map<String,Integer>> getSearchRank(List<List<searchChartDTO>> searchMonthList);
    List<CardDTO> getCardList();
    List<BenefitDTO> getBenefit(int cardId);
    CardDTO getCardByCardId(int cardId);
    int getMemberCardCount();
    int getPayAmount();
    List<TransactionChartDTO> getTransactionChart();

}
