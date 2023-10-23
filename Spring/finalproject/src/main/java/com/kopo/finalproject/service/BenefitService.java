package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dto.BenefitResultDTO;
import com.kopo.finalproject.model.dto.CommonDTO;
import com.kopo.finalproject.model.dto.SearchHistoryDTO;

import java.util.List;
import java.util.Map;

public interface BenefitService {
    List<BenefitResultDTO> getMatchingBenefitsByMap(Map<String, String> jsonData);
    int getCardID(String cardName);
    List<SearchHistoryDTO> getSearchHistoryList(String memberId);
    List<List<CommonDTO>>  getMatchingBenefitsBySearch(List<Map<String, Object>> searchDataList, String memberId, String searchHistory);

    void updateSearchStatus(int searchHistoryId);
    List<String>selectSearchRank();

    void checkNearByBenefit(Map<String, String> jsonData);

    int getThisMonthTotal(int cardId,String memberId);
    List<Map<Integer,Integer>> getBenefitCount(List<Map<String, Object>> searchDataList, String memberId);

}
