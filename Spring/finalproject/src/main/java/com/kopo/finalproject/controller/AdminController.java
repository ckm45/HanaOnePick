package com.kopo.finalproject.controller;

import com.kopo.finalproject.model.dto.*;
import com.kopo.finalproject.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {

    @Autowired
    AdminService AdminService;

    @GetMapping("/admin")
    ModelAndView getAdminPage(){
        ModelAndView mav = new ModelAndView("admin");
        List<MemberDTO> memberList = AdminService.getMemberList();
        List<searchChartDTO> searchChartList = AdminService.getSearchChart();

        for (searchChartDTO searchChartDTO : searchChartList) {
            System.out.println("searchChartDTO : "+searchChartDTO);
        }
        int memberCount = memberList.size();
        int searchCount = 0;
        for (searchChartDTO searchChartDTO : searchChartList) {
            searchCount += searchChartDTO.getSearchCount();
        }

        //업종별 소비내역 보기.
        List<TransactionChartDTO> transactionChartList = AdminService.getTransactionChart();
        mav.addObject("transactionChartList",transactionChartList);

        int cardCount = AdminService.getMemberCardCount();
        int payAmount = AdminService.getPayAmount();
        List<List<searchChartDTO>> searchMonthList = AdminService.getSearchChartByMonth();
        List<Map<String,Integer>> searchRankList = AdminService.getSearchRank(searchMonthList);
        mav.addObject("searchRankList",searchRankList);
        mav.addObject("payAmount",payAmount);
        mav.addObject("cardCount",cardCount);
        mav.addObject("searchCount",searchCount);
        mav.addObject("memberCount",memberCount);
        mav.addObject("memberList",memberList);
        mav.addObject("searchChartList",searchChartList);
        return mav;
    }

    @GetMapping("/adminData")
    ModelAndView getAdminDataPage(){
        ModelAndView mav = new ModelAndView("adminData");
        List<MemberDTO> memberList = AdminService.getMemberList();
        List<List<searchChartDTO>> searchMonthList = AdminService.getSearchChartByMonth();
        //업종별 8월 9월 업종 변화 추이 확인
        List<Map<String,Integer>> searchRankList = AdminService.getSearchRank(searchMonthList);
        List<CardDTO> cardDTOList = AdminService.getCardList();
        mav.addObject("searchRankList",searchRankList);
        mav.addObject("memberList",memberList);
        mav.addObject("searchChartList",searchMonthList);
        mav.addObject("cardDTOList",cardDTOList);
        return mav;
    }

    @GetMapping("/sendMail")
    ModelAndView sendMail(@RequestParam("cardId") int cardId){
        System.out.println("cardId : "+cardId);
        ModelAndView mav = new ModelAndView("adminMail");
        List<MemberDTO> memberList = AdminService.getMemberList();
        mav.addObject("memberList",memberList);
        List<BenefitDTO> benefitList = AdminService.getBenefit(cardId);
        Map<String, GroupedBenefit> benefitIndustryMap = new HashMap<>();

        for (BenefitDTO benefit : benefitList) {
            System.out.println("benefit : "+benefit);
            if (!benefitIndustryMap.containsKey(benefit.getBenefitIndustryCode())) {
                GroupedBenefit groupedBenefit = new GroupedBenefit();
                groupedBenefit.setBenefitAmount(benefit.getBenefitAmount());
                groupedBenefit.setBenefitCode(benefit.getBenefitCode());
                groupedBenefit.setBenefitMax(benefit.getBenefitMax());
                groupedBenefit.setStoreNames(new ArrayList<>());

                benefitIndustryMap.put(benefit.getBenefitIndustryCode(), groupedBenefit);
            }
            benefitIndustryMap.get(benefit.getBenefitIndustryCode()).getStoreNames().add(benefit.getBenefitStoreName());
        }
        mav.addObject("benefitIndustryMap",benefitIndustryMap);
        CardDTO cardDTO = AdminService.getCardByCardId(cardId);
        mav.addObject("cardDTO",cardDTO);
        return mav;
    }
}
