package com.kopo.finalproject.controller;

import com.kopo.finalproject.model.dto.*;
import com.kopo.finalproject.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    PerformanceResponse response;
    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public String login(@RequestParam("id") String id,
                        @RequestParam("pw") String pw, HttpSession session) {
//        ModelAndView mav = new ModelAndView("index");
        MemberDTO memberDTO = memberService.memberLoginCheck(id, pw);
//        mav.addObject("dto", memberDTO);

        session.setAttribute("dto", memberDTO);
        System.out.println("로그인");
        return "redirect:/";
    }

    @GetMapping("/card")
    public ModelAndView myCard(HttpSession session) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto"); // 세션에서 memberDTO 가져옴
        System.out.println("컨트롤러: " + memberDTO);
        String memberId = memberDTO.getMemberId(); // memberDTO에서 customerId 가져옴
        System.out.println(memberId);
        ModelAndView mav = new ModelAndView("myCard");
        List<MyCardDTO> myCardList = memberService.getCardList(memberId);
        mav.addObject("myCardList", myCardList);
        return mav;
    }

    @PostMapping("/getPerformanceLevel")
    @ResponseBody
    public ResponseEntity<PerformanceResponse> updateProgress(@RequestParam(name = "cardId") int cardId, HttpSession session) {
        System.out.println("컨트롤러: " + cardId);
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto");
        String memberId = memberDTO.getMemberId();
        List<Integer> distinctPerformanceValue = memberService.getDistinctPerformanceValue(cardId);
        Integer thisMonthTotal = memberService.getThisMonthTotal(cardId, memberId);
        System.out.println("이번달 누적금액: " + thisMonthTotal);
        //이번달 누적금액 세션 만들기
        session.setAttribute("thisMonthTotal" + cardId, thisMonthTotal);
        System.out.println("결과: " + distinctPerformanceValue);

        response.setThisMonthTotal(thisMonthTotal);
        response.setDistinctPerformanceValue(distinctPerformanceValue);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    @PostMapping("/getTransactionList")
    @ResponseBody
    public List<TransactionHistoryDTO> getTransactionHistoryListByCardNumber(@RequestParam String cardNumber, @RequestParam String selectedDate) {
        System.out.println("컨트롤러: " + cardNumber);
        System.out.println("컨트롤러: " + selectedDate);

        List<TransactionHistoryDTO> transactionHistoryDTOList = memberService.getTransactionHistoryList(cardNumber, selectedDate);
        //System.out.println("결과: " + transactionHistoryDTOList);
        return transactionHistoryDTOList;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/getBenefitList")
    @ResponseBody
    public List<BenefitDTO> getBenefitListByCardNumber(@RequestParam String cardNumber) {
        System.out.println("컨트롤러: " + cardNumber);
        List<BenefitDTO> benefitDTOList = memberService.getBenefitListByCardNumber(cardNumber);
        System.out.println("결과: " + benefitDTOList);
        return benefitDTOList;
    }

    @GetMapping("/getPayList")
    public ModelAndView getPayList(HttpSession session) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto"); // 세션에서 memberDTO 가져옴
        System.out.println("컨트롤러: " + memberDTO);
        String memberId = memberDTO.getMemberId(); // memberDTO에서 customerId 가져옴
        System.out.println(memberId);
        ModelAndView mav = new ModelAndView("payList");
        List<MyCardDTO> myCardList = memberService.getCardList(memberId);
        mav.addObject("myCardList", myCardList);
        return mav;
    }

    @GetMapping("/getPayReport")
    public ModelAndView getPayReport(HttpSession session) {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto"); // 세션에서 memberDTO 가져옴
        String memberId = memberDTO.getMemberId(); // memberDTO에서 customerId 가져옴
        List<TransactionChartDTO> totalChart = memberService.getTotalChartList(memberId);
        for (TransactionChartDTO transactionChartDTO : totalChart) {
            System.out.println("컨트롤러 payReport 결과: " + transactionChartDTO);
        }
        ModelAndView mav = new ModelAndView("payReport");
        mav.addObject("totalChart", totalChart);
        return mav;
    }

    @PostMapping("/compareBenefit")
    @ResponseBody
    public Map<Integer, List<BenefitDTO>> comparingBenefit(@RequestBody ToCompareBenefitDTO toCompareBenefitDTO) {
        System.out.println("컨트롤러 toCompareBenefitDTO : " + toCompareBenefitDTO);
        Map<Integer, List<BenefitDTO>> benefitListMap = memberService.comparingBenefit(toCompareBenefitDTO);
        System.out.println("결과: " + benefitListMap);

        return benefitListMap;
    }

    @PostMapping("/getTransactionChart")
    @ResponseBody
    public ResponseEntity<List<TransactionChartDTO>> drawTransactionChart(@RequestParam String cardNumber, @RequestParam String selectedDate) {

        List<TransactionChartDTO> myChart = memberService.getTransactionChartList(cardNumber, selectedDate);

        if (!myChart.isEmpty()) {
            return ResponseEntity.ok(myChart);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/getBenefitSum")
    @ResponseBody
    public List<RecCardDTO> getBenefitSum(HttpSession session) {
        List<RecCardDTO> beforeRec = new ArrayList<>();

        System.out.println("getBenefitSum 컨트롤러");
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("dto"); // 세션에서 memberDTO 가져옴
        String memberId = memberDTO.getMemberId(); // memberDTO에서 customerId 가져옴
        //카드별 혜택 현황 파악 위한 Map
        Map<Integer, List<Integer>> benefitSumMap = memberService.getBenefitSumGroupByCardId(memberId);
        for (Integer key : benefitSumMap.keySet()) {
            System.out.println("key: " + key + " / value: " + benefitSumMap.get(key));
            CardDTO cardDTO = memberService.getCardInfoByCardId(key);
            RecCardDTO recCardDTO = new RecCardDTO();
            recCardDTO.setCardId(cardDTO.getCardId());
            recCardDTO.setCardName(cardDTO.getCardName());
            recCardDTO.setCardSubTitle(cardDTO.getCardSubTitle());
            recCardDTO.setCardTypeCode(cardDTO.getCardTypeCode());
            recCardDTO.setAnnualFee(cardDTO.getAnnualFee());
            recCardDTO.setDiscountAmount(benefitSumMap.get(key).get(0));
            recCardDTO.setDiscountAmount(benefitSumMap.get(key).get(0));
            recCardDTO.setAccumulatedAmount(benefitSumMap.get(key).get(1));
            beforeRec.add(recCardDTO);
        }
        //List<Integer> benefitSum = memberService.getBenefitSum(memberId);
        //System.out.println("컨트롤러 getBenefitSum 결과: " + benefitSum);
        return beforeRec;
    }

    @GetMapping("/getRecCard")
    @ResponseBody
    public RecCardDTO getRecCard(HttpSession session) {
        System.out.println("getRecCard 컨트롤러");
        MyCardDTO myCardDTO = memberService.getCardList("user002").get(0);
        System.out.println("myCardDTO: " + myCardDTO);
        List<Integer> recCardList = memberService.getBenefitSum(myCardDTO.getCardNumber(), "user002");
        CardDTO cardDTO = memberService.getCardInfo("user002");
        RecCardDTO recCardDTO = new RecCardDTO();
        recCardDTO.setCardId(cardDTO.getCardId());
        recCardDTO.setCardName(cardDTO.getCardName());
        recCardDTO.setCardSubTitle(cardDTO.getCardSubTitle());
        recCardDTO.setCardTypeCode(cardDTO.getCardTypeCode());
        recCardDTO.setAnnualFee(cardDTO.getAnnualFee());
        recCardDTO.setDiscountAmount(recCardList.get(0));
        recCardDTO.setAccumulatedAmount(recCardList.get(1));

        System.out.println("컨트롤러 getRecCard 결과: " + recCardDTO);
        return recCardDTO;
    }

    @PostMapping("/getTransactionDetail")
    @ResponseBody
    public TransactionDetailDTO getTransactionDetail(@RequestParam("transactionDate") String transactionDate, @RequestParam("cardNumber") String cardNumber, @RequestParam("transactionIndustryName") String transactionIndustryName
            , @RequestParam("transactionStoreName") String transactionStoreName, @RequestParam("transactionAmount") int transactionAmount, HttpSession session) {
        MemberDTO memberDTO = (MemberDTO)session.getAttribute("dto");
        String memberId = memberDTO.getMemberId();
        TransactionDetailDTO transactionDeatilDTO = memberService.getTransactionDetail(memberId,transactionDate, cardNumber, transactionIndustryName, transactionStoreName, transactionAmount);
        return transactionDeatilDTO;
    }


}
