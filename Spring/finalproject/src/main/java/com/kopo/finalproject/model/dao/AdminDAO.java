package com.kopo.finalproject.model.dao;

import com.kopo.finalproject.model.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminDAO {
    List<MemberDTO> getMemberList();
    List<searchChartDTO> getSearchChart();
    List<searchChartDTO> getSearchChartByMonth(int month);
    List<CardDTO> getCardList();
    List<BenefitDTO> getBenefit(int cardId);
    List<BenefitDTO> getBenefit2(int cardId);
    CardDTO getCardByCardId(int cardId);
    int getMemberCardCount();
    int getPayAmount();
    List<TransactionChartDTO> getTransactionChart();
}
