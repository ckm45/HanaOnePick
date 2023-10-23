package com.kopo.finalproject.model.dao;

import com.kopo.finalproject.model.dto.BenefitDTO;
import com.kopo.finalproject.model.dto.MyCardDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PayDAO {

    List<MyCardDTO> getMyCardList(String memberId);

    String getCardNumber(@Param("cardId") int cardId, @Param("memberId") String memberId);
    Integer checkBenefit(@Param("memberId") String memberId, @Param("storeName") String storeName,@Param("cardId") int cardId);
    BenefitDTO selectBenefit(Integer benefitId);
    Integer checkBenefitCount(@Param("benefitIndustryCode") String benefitIndustryCode, @Param("memberId") String memberId, @Param("cardPerformance") int cardPerformance);
    void insertTransaction(@Param("price") String price,@Param("cardNumber") String cardNumber, @Param("memberId") String memberId, @Param("storeCategoryCode") String storeCategoryCode, @Param("storeName") String storeName);
}
