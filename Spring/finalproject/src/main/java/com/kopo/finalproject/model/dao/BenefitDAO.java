package com.kopo.finalproject.model.dao;

import com.kopo.finalproject.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface BenefitDAO {

    void insertSearchHistory(@Param("memberId") String memberId, @Param("searchHistory") String searchHistory,@Param("searchIndustryCode") String searchIndustryCode);
    List<BenefitResultDTO> getMatchingBenefitsByMap(Map<String, String> jsonData);
    int getCardID(String cardName);
    List<BenefitResultDTO> getMatchingBenefitsByMap2(Map<String, String> jsonData);
    List<CommonDTO> getMatchingBenefitsBySearch(@Param("memberId") String memberId, @Param("searchData") Map<String, Object> searchData);
    List<CommonDTO> getMatchingBenefitsBySearch2(@Param("memberId") String memberId, @Param("searchData") Map<String, Object> searchData);
    List<SearchHistoryDTO> getSearchHistoryList(String memberId);
    void updateSearchStatus(int searchHistoryId);
    List<String> selectSearchRank();
    List<Integer> getMemberCardIdList(String memberId);
    CommonDTO getNotBenefitList(@Param("memberId") String memberId,@Param("cardId") int cardId);
    int getBenefitId(@Param("memberId") String memberId,@Param("searchData") Map<String,Object> searchData,@Param("cardId") int cardId);
    BenefitDTO getBenefitDTO(int benefitId);
    int getBenefitCount(@Param("memberId") String memberId,@Param("benefitId") int benefitId,@Param("benefitIndustryCode") String benefitIndustryCode);
    List<Integer> getBenefitAmountList(@Param("memberId") String memberId,@Param("storeName") String storeName);

}
