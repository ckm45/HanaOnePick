package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dao.AdminDAO;
import com.kopo.finalproject.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService{
    @Autowired
    AdminDAO adminDAO;
    public List<MemberDTO> getMemberList(){
        return adminDAO.getMemberList();
    }

    @Override
    public List<searchChartDTO> getSearchChart(){
        return adminDAO.getSearchChart();
    }

    @Override
    public List<List<searchChartDTO>> getSearchChartByMonth(){
        List<List<searchChartDTO>> result = new java.util.ArrayList<>(List.of());

        for(int i=0;i<=2;i++){
            result.add(adminDAO.getSearchChartByMonth(i));
            System.out.println("result : "+ result);
        }

        return result;
    }

    @Override
    public List<Map<String,Integer>> getSearchRank(List<List<searchChartDTO>> searchMonthList){
        List<Map<String,Integer>> result = new java.util.ArrayList<>(List.of());
        List<searchChartDTO> month8 = searchMonthList.get(1);
        List<searchChartDTO> month9 = searchMonthList.get(0);
        //8월 9월 업종별 검색량 변화 추이
        //8월 리스트안의 DTO가 9월 리스트안에 있는지 확인
        //있으면 9월 DTO의 검색량 - 8월 DTO의 검색량 9월 DTO의 searchCount - 8월 DTO의 searchCount
        //없으면 9월 DTO의 검색량
        //Map에 해당 searchIndustryCode와 9월 DTO의 검색량 - 8월 DTO의 검색량 를 넣어서 반환
        //result에 Map을 넣어서 반환
        for (searchChartDTO searchChartDTO : month8) {
            for (searchChartDTO searchChartDTO1 : month9) {
                if(searchChartDTO.getSearchIndustryCode().equals(searchChartDTO1.getSearchIndustryCode())){
                    Map<String,Integer> map = new java.util.HashMap<>();
                    map.put(searchChartDTO.getSearchIndustryCode(),searchChartDTO1.getSearchCount()-searchChartDTO.getSearchCount());
                    result.add(map);
                }
            }
        }
        //리스트를 Map의 value값으로 정렬
        result.sort((o1, o2) -> {
            int v1 = o1.values().iterator().next();
            int v2 = o2.values().iterator().next();
            return v2 - v1;
        });
        for(Map<String,Integer> map : result){
            System.out.println("map : "+ map);
        }
        return result;
    }

    @Override
    public List<CardDTO> getCardList(){
        return adminDAO.getCardList();
    }

    @Override
    public List<BenefitDTO> getBenefit(int cardId){
        List<BenefitDTO> result = adminDAO.getBenefit(cardId);
        if(result.size()>0){
            return result;
        }else{
            result=adminDAO.getBenefit2(cardId);
            return result;
        }
    }
    @Override
    public CardDTO getCardByCardId(int cardId){
        return adminDAO.getCardByCardId(cardId);
    }
    @Override
    public int getMemberCardCount(){
        return adminDAO.getMemberCardCount();
    }
    @Override
    public int getPayAmount(){
        return adminDAO.getPayAmount();
    }

    @Override
    public List<TransactionChartDTO> getTransactionChart(){
        return adminDAO.getTransactionChart();
    }

}
