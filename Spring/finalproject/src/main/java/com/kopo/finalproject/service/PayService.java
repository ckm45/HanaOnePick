package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dto.BenefitDTO;
import com.kopo.finalproject.model.dto.MyCardDTO;

import java.util.List;
import java.util.Map;

public interface PayService {
    List<MyCardDTO> getMyCardList(String memberId);
    Map<Integer,BenefitDTO> submitPayment(int cardId, String memberId, String storeName, String price, String storeCategoryCode);

}
