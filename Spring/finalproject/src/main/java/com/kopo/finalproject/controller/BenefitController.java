package com.kopo.finalproject.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kopo.finalproject.model.dto.BenefitResultDTO;
import com.kopo.finalproject.model.dto.CommonDTO;
import com.kopo.finalproject.model.dto.MemberDTO;
import com.kopo.finalproject.model.dto.SearchHistoryDTO;
import com.kopo.finalproject.service.BenefitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class BenefitController {
    private BenefitService benefitService;

    @Autowired
    public BenefitController(BenefitService benefitService) {
        this.benefitService = benefitService;
    }


    @GetMapping("/map")
    public String findMap() {
        return "findMap";
    }

    @GetMapping("/recResult")
    public String rec() {
        return "recResult";
    }

    @PostMapping("/showBenefit")
    public ResponseEntity<List<BenefitResultDTO>> showBenefit(@RequestBody Map<String, String> jsonData) {
        try {
            List<BenefitResultDTO> result = benefitService.getMatchingBenefitsByMap(jsonData);
            System.out.println("컨트롤러에서 result 확인: " + result);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/getCardID")
    @ResponseBody
    public int getCardID(@RequestParam("cardName") String cardName) {
        int cardId = benefitService.getCardID(cardName);
        return cardId;
    }

    @GetMapping("/search")
    public ModelAndView search(HttpSession session) {
        ModelAndView mav = new ModelAndView("searchBenefit");
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto");
        String memberId= memberDTO.getMemberId();
        List<SearchHistoryDTO> searchHistoryList = benefitService.getSearchHistoryList(memberId);
        List<String> searchRankList = benefitService.selectSearchRank();
        mav.addObject("searchHistoryList", searchHistoryList);
        mav.addObject("searchRankList", searchRankList);
        return mav;
    }



    @PostMapping("/searchResult")
    public ModelAndView searchResult(@RequestParam(name = "benefitData") String benefitData,@RequestParam(name = "searchHistory") String searchHistory, HttpSession session) throws JsonProcessingException {

        System.out.println("searchHistory: " + searchHistory);
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto");
        ObjectMapper objectMapper = new ObjectMapper();

        List<Map<String, Object>> searchDataList = objectMapper.readValue(benefitData, new TypeReference<List<Map<String, Object>>>() {});

        for (Map<String, Object> searchData : searchDataList) {
            System.out.println("컨트롤러: " + searchData.get("place_name"));
        }
        System.out.println(memberDTO.getMemberId());


        List<List<CommonDTO>> benefitList = benefitService.getMatchingBenefitsBySearch(searchDataList, memberDTO.getMemberId(),searchHistory);
        List<Map<Integer,Integer>> benefitCountList = benefitService.getBenefitCount(searchDataList, memberDTO.getMemberId());

        // ModelAndView에 데이터 저장

        ModelAndView modelAndView = new ModelAndView("recResult");
        modelAndView.addObject("benefitList", benefitList);
        modelAndView.addObject("searchDataList", searchDataList);
        modelAndView.addObject("searchStore", searchHistory);
        modelAndView.addObject("benefitCountList", benefitCountList);
        return modelAndView;
    }
    @PostMapping("/updateSearchStatus")
    @ResponseBody
    public String updateSearchStatus(@RequestParam("searchHistoryId") int searchHistoryId) {
        System.out.println("컨트롤러: " + searchHistoryId);
        benefitService.updateSearchStatus(searchHistoryId);
        return "success";
    }

//    @PostMapping("/notifyBenefit")
//    public ResponseEntity<String> notifyBenefit(@RequestBody Map<String, String> jsonData) {
//
//        System.out.println("Received JSON data: " + jsonData);
//        benefitService.checkNearByBenefit(jsonData);
//        // 응답 반환
//        return ResponseEntity.ok("Success");
//    }
}





