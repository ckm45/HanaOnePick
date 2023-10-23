package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dao.MemberDAO;
import com.kopo.finalproject.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberDAO MemberDAO;

    @Override
    public MemberDTO memberLoginCheck(String ckId, String ckPw) {

        return MemberDAO.memberLoginCheck(ckId, ckPw);

    }

    @Override
    public List<MyCardDTO> getCardList(String memberId) {
        System.out.println(memberId);
        return MemberDAO.getCardList(memberId);
    }

    @Override
    public List<Integer> getDistinctPerformanceValue(int cardId) {
        return MemberDAO.getDistinctPerformanceValue(cardId);
    }

    @Override
    public List<TransactionHistoryDTO> getTransactionHistoryList(String cardNumber, String selectedDate) {
        System.out.println("cardNumber 서비스: " + cardNumber);
        //문자열을 ,로 구분하여 리스트에 넣기해줘
        List<String> cardNumberList = Arrays.asList(cardNumber.split(", "));
        for (String s : cardNumberList) {
            System.out.println("cardNumberList: " + s);
        }
        System.out.println("selectedDate: " + selectedDate);
        if (selectedDate == null) {
            System.out.println("selectedDate null");
        } else {
            System.out.println("selectedDate not null");
        }
        int selectedDateInt = 0;

        switch (selectedDate) {
            case "2주":
                selectedDateInt = 14;
                break;
            case "1개월":
                selectedDateInt = 30;
                break;
            case "3개월":
                selectedDateInt = 90;
                break;
            case "이번 달":
                selectedDateInt = 1;
                break;
            default:
                break;
        }

        if (selectedDateInt == 0) {
            if (selectedDate.length() == 16) {
                System.out.println("selectedDate.length() == 8");
                String firstDate = selectedDate.substring(0, 8);
                String secondDate = selectedDate.substring(8);
                return MemberDAO.getSelectedDateTransanctionHistroyListByCardNumber(cardNumberList, firstDate, secondDate);
            } else {
                return MemberDAO.getAllTransactionHistoryListByCardNumber(cardNumberList);
            }
        } else if (selectedDateInt == 1) {
            return MemberDAO.getThisMonthTransactionHistoryListByCardNumber(cardNumberList);
        }
        return MemberDAO.getTransactionHistoryListByCardNumber(cardNumberList, selectedDateInt);
    }

    @Override
    public List<BenefitDTO> getBenefitListByCardNumber(String cardNumber) {
        return MemberDAO.getBenefitListByCardNumber(cardNumber);
    }

    @Override
    public Integer getThisMonthTotal(int cardId, String memberId) {
        return MemberDAO.getThisMonthTotal(cardId, memberId);
    }

    @Override
    public Map<Integer, List<BenefitDTO>> comparingBenefit(ToCompareBenefitDTO toCompareBenefitDTO) {
        Map<Integer, List<BenefitDTO>> benefitListMap = new java.util.HashMap<>();
        int cardId = toCompareBenefitDTO.getCardId();
        int smallerValue = toCompareBenefitDTO.getSmallerValue();
        int largerValue = toCompareBenefitDTO.getLargerValue();
        System.out.println("cardId: " + cardId);
        System.out.println("smallerValue: " + smallerValue);
        System.out.println("largerValue: " + largerValue);
        if (smallerValue != 0) {
            List<BenefitDTO> benefitList = MemberDAO.comparingBenefit(cardId, smallerValue);
            benefitListMap.put(smallerValue, benefitList);
        }
        if (largerValue != 0) {
            List<BenefitDTO> benefitDTOList = MemberDAO.comparingBenefit(cardId, largerValue);
            benefitListMap.put(largerValue, benefitDTOList);
        }
        return benefitListMap;
    }

    @Override
    public List<TransactionChartDTO> getTransactionChartList(String cardNumber, String selectedDate) {

        //문자열을 ,로 구분하여 리스트에 넣기해줘
        List<String> cardNumberList = Arrays.asList(cardNumber.split(", "));

        int selectedDateInt = 0;

        switch (selectedDate) {
            case "2주":
                selectedDateInt = 14;
                break;
            case "1개월":
                selectedDateInt = 31;
                break;
            case "3개월":
                selectedDateInt = 92;
                break;
            case "이번 달":
                selectedDateInt = 1;
                break;
            default:
                break;
        }
        if (selectedDateInt == 0) {
            if (selectedDate.length() == 16) {
                String firstDate = selectedDate.substring(0, 8);
                String secondDate = selectedDate.substring(8);
                return MemberDAO.drawSelectedDateTransactionHistoryChartByCardNumber(cardNumberList, firstDate, secondDate);
            }else {
                return MemberDAO.drawAllTransactionHistoryChartByCardNumber(cardNumberList);
            }
        } else if (selectedDateInt == 1) {
            return MemberDAO.drawThisMonthTransactionHistoryChartByCardNumber(cardNumberList);
        }
        return MemberDAO.drawTransactionHistoryChartByCardNumber(cardNumberList, selectedDateInt);
    }

    //회원 정보만 가지고 전체 차트 가져오기
    @Override
    public List<TransactionChartDTO> getTotalChartList(String memberId) {
        List<MyCardDTO> memberCardList = MemberDAO.getCardList(memberId);
        List<String> cardNumberList = new ArrayList<>();
        for (MyCardDTO myCardDTO : memberCardList) {
            cardNumberList.add(myCardDTO.getCardNumber());
            System.out.println("cardNumberList: " + cardNumberList);
        }

        return MemberDAO.drawAllTransactionHistoryChartByCardNumber(cardNumberList);
    }

    @Override
    public Map<Integer, List<Integer>> getBenefitSumGroupByCardId(String memberId) {
        Map<Integer, List<Integer>> benefitSumMap = new HashMap<>();
        List<MyCardDTO> cardList = MemberDAO.getCardList(memberId);
        for (MyCardDTO myCardDTO : cardList) {
            List<Integer> benefitSum = getBenefitSum(myCardDTO.getCardNumber(), memberId);
            //key는 myCardDTO 의 cardId value는 benefitSum
            benefitSumMap.put(myCardDTO.getCardId(), benefitSum);
        }
        System.out.println("컨트롤러 getBenefitSumGroupByCardId 결과: " + benefitSumMap);
        return benefitSumMap;
    }

    @Override
    public List<Integer> getBenefitSum(String cardNumber, String memberId) {
        int discountSum = 0;
        int AccumulationSum = 0;
        for (int i = 0; i <= 12; i++) {
            System.out.println("첫번째 for문시작");
            //회원ID로 이번달 거래내역 가져오기
            List<TransactionHistoryDTO> thisMonthTransaction = MemberDAO.getThisMonthTransactionHistory(memberId, i, cardNumber);
            System.out.println("첫번째 쿼리 그 후");

            //이번달 거래내역이 있다면
            if (!thisMonthTransaction.isEmpty()) {
                //첫번째 거래내역 가져오기 id 가져오기
                Integer firstTransactionId = thisMonthTransaction.get(0).getTransactionId();
                System.out.println("이달의 첫번째 거래내역: " + firstTransactionId);
                System.out.println("thisMonthTransaction 비었나 체크: " + thisMonthTransaction);
                System.out.println("thisMonthTransaction: " + thisMonthTransaction);
                for (TransactionHistoryDTO transactionHistoryDTO : thisMonthTransaction) {
                    System.out.println("thisMonthTransaction: " + transactionHistoryDTO);
                    int transactionId = transactionHistoryDTO.getTransactionId();
                    System.out.println("transactionId: " + transactionId);
                    //각 거래마다 혜택을 받았는지 체크 할 것
                    //우선 그 거래에서 쓴 카드의 지난달 거래한 금액을 알아야함(혜택을 받기위한 실적을 위해)
                    Integer lastMonthTotal = MemberDAO.getLastMonthTotal(transactionId, memberId);
                    System.out.println("해당 거래의 전월누적금액 : " + lastMonthTotal);
                    //전월 누적금액이 0원이면 혜택이 없다
                    if (lastMonthTotal != null) {
                        //그 거래에서 사용된 카드가 어떤 상품인지
                        int cardId = MemberDAO.getCardIdByTransaction(transactionId);
                        //그 거래에서 쓴 카드가 혜택을 받았는지 체크
                        BenefitDTO benefitCheckDto = MemberDAO.getBenefitAmountByTransaction(transactionId, lastMonthTotal, cardId, memberId);
                        System.out.println("혜택을 받았는지 체크: " + benefitCheckDto);
                        //혜택을 받았다면 혜택을 받은 금액을 가져와서 합산해줘야함
                        //우선 혜택이 한도를 벗어났나 체크
                        //if benefitCheckDto가 null이 아니라면 출력
                        if (benefitCheckDto != null) {
                            //혜택 한도가 횟수 제한이라면
                            if (benefitCheckDto.getBenefitCode().substring(3, 4).equals("C")) {
                                //거래한 해당 달의 1일부터 그날까지 중 이 혜택이 있는 지 체크
                                //있다면 그 횟수를 가져와서 혜택한도와 비교
                                //체크를 그 해당 거래내역의 카드번호와 그 달의 첫번째 거래내역ID(기간설정을 위해), 그리고 거래업종가지고 하게 됨
                                int benefitCount = MemberDAO.getBenefitCountFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());
                                System.out.println("이번달에 그전에 이 혜택을 몇번 썼는지의 횟수 : " + benefitCount);
                                //그 횟수가 혜택한도보다 작다면 혜택을 받은 금액을 합산해줘야함
                                int benefitMax = benefitCheckDto.getBenefitMax();
                                if (benefitCount <= benefitMax) {
                                    //혜택 한도보다 덜 썼다면 혜택을 받은 금액을 합산해줘야함
                                    //혜택이 적립인지 할인인지를 따진다
                                    if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                                        //할인이라면
                                        if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                            System.out.println("benefitCheckDto.getBenefitCode().substring(2,3): " + benefitCheckDto.getBenefitCode().substring(2, 3));
                                            discountSum += benefitCheckDto.getBenefitAmount();
                                        } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                            int discountAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                            discountSum += discountAmount;
                                        }
                                    } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                                        System.out.println("benefitCheckDto.getBenefitCode().substring(0,2): " + benefitCheckDto.getBenefitCode().substring(0, 2));
                                        //적립이라면
                                        if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                            System.out.println("benefitCheckDto.getBenefitCode().substring(2,3): " + benefitCheckDto.getBenefitCode().substring(2, 3));
                                            AccumulationSum += benefitCheckDto.getBenefitAmount();
                                        } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                            int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                            AccumulationSum += AccumulationAmount;
                                        }
                                    }
                                }
                            }
                            //혜택 한도가 금액 제한이라면 (일단 제한 생각안함)
                            else if (benefitCheckDto.getBenefitCode().substring(3, 4).equals("A")) {
                                //이 혜택과 같은 거래를 한 거래내역들의 금액 가져옴
                                List<Integer> transactionAmountList = MemberDAO.getTransactionAmountListFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());

                                // 초기 혜택 월 최대 한도 값 저장
                                int benefitMax = benefitCheckDto.getBenefitMax();
                                //이달의 같은 거래에 대한 거래금액 리스트가지고 이번달 혜택 한도 값 비교
                                if (!transactionAmountList.isEmpty()) {
                                    if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                                        for (Integer price : transactionAmountList) {
                                            //결제하려던 원래 금액
                                            int originPrice = 0;
                                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                                benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                                originPrice = (int) (price / (1 - benefitCheckDto.getBenefitAmount() / 100));
                                                benefitMax = (int) (benefitMax - (originPrice - price));
                                            }
                                        }
                                    } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                                        for (Integer price : transactionAmountList) {
                                            //결제하려던 원래 금액
                                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                                benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                                benefitMax = (int) (benefitMax - (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100));
                                            }
                                        }
                                    }
                                }
                                //이번달 그 혜택 한도가 아직 남았을 때
                                if (benefitMax > 0) {
                                    //이번 거래내역 이전의 이번달 거래내역들 중에서 그 혜택으로 얼마를 혜택 받았는 지 체크
                                    if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                                        if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                            if (benefitMax > benefitCheckDto.getBenefitAmount()) {
                                                discountSum += benefitCheckDto.getBenefitAmount();
                                            } else {
                                                discountSum += benefitMax;
                                            }
                                        } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                            if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100)) {
                                                int discountAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                                discountSum += discountAmount;
                                            } else {
                                                discountSum += benefitMax;
                                            }
                                        }
                                    } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                                        if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                            if (benefitMax > benefitCheckDto.getBenefitAmount()) {
                                                AccumulationSum += benefitCheckDto.getBenefitAmount();
                                            } else {
                                                AccumulationSum += benefitMax;
                                            }
                                        } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                            if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100)) {
                                                int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                                AccumulationSum += AccumulationAmount;
                                            } else {
                                                AccumulationSum += benefitMax;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //가게명으로 찾았을 때 혜택이 없다면 업종으로 한번더 찾기
                        else {
                            System.out.println("혜택이 없다면 업종으로 한번 더 찾기 시작");
                            if (cardId == 7 && transactionHistoryDTO.getTransactionIndustryCode().equals("FD") && lastMonthTotal >= 300000) {
                                System.out.println("if문 들어옴");
                                BenefitDTO benefitCheckDto2 = MemberDAO.getBenefitAmountByTransaction2();
                                System.out.println("benefitCheckDto2: " + benefitCheckDto2);
                                List<Integer> transactionAmountList = MemberDAO.getTransactionAmountListFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());
                                // 초기 혜택 월 최대 한도 값 저장
                                System.out.println("transactionAmountList: " + transactionAmountList);
                                int benefitMax = benefitCheckDto2.getBenefitMax();
                                if (!transactionAmountList.isEmpty()) {
                                    System.out.println("transactionAmountList 비어있지 않음");
                                    System.out.println("benefitCheckDto2.getBenefitCode().substring(0,2): " + benefitCheckDto2.getBenefitCode().substring(0, 2));
                                    if (benefitCheckDto2.getBenefitCode().substring(0, 2).equals("DC")) {
                                        for (Integer price : transactionAmountList) {
                                            //결제하려던 원래 금액
                                            int originPrice = 0;
                                            if (benefitCheckDto2.getBenefitCode().substring(2, 3).equals("V")) {
                                                benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                            } else if (benefitCheckDto2.getBenefitCode().substring(2, 3).equals("P")) {
                                                originPrice = (int) (price / (1 - benefitCheckDto.getBenefitAmount() / 100));
                                                benefitMax = (int) (benefitMax - (originPrice - price));
                                            }
                                        }
                                    } else if (benefitCheckDto2.getBenefitCode().substring(0, 2).equals("AC")) {
                                        System.out.println("AC로 들어옴");
                                        for (Integer price : transactionAmountList) {
                                            //결제하려던 원래 금액
                                            if (benefitCheckDto2.getBenefitCode().substring(2, 3).equals("V")) {
                                                benefitMax = (int) (benefitMax - benefitCheckDto2.getBenefitAmount());
                                            } else if (benefitCheckDto2.getBenefitCode().substring(2, 3).equals("P")) {
                                                benefitMax = (int) (benefitMax - (price * benefitCheckDto2.getBenefitAmount() / 100));
                                            }
                                        }
                                    }
                                }
                                System.out.println("transactionAmountList 비었나 체크: " + transactionAmountList);
                                System.out.println("benefitMax: " + benefitMax);

                                if (benefitMax > 0) {
                                    if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto2.getBenefitAmount() / 100)) {
                                        int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto2.getBenefitAmount() / 100);
                                        AccumulationSum += AccumulationAmount;
                                    } else {
                                        AccumulationSum += benefitMax;
                                    }
                                }
                            } else {
                                System.out.println("예외 발생");
                            }
                        }
                    }
                }
            }
        }
        System.out.println("이번달 할인받은 금액: " + discountSum);
        System.out.println("이번달 적립받은 금액: " + AccumulationSum);
        List<Integer> result = Arrays.asList(discountSum, AccumulationSum);
        return result;
    }

    @Override
    public CardDTO getCardInfo(String memberId) {
        return MemberDAO.getCardInfo(memberId);
    }

    @Override
    public CardDTO getCardInfoByCardId(Integer cardId) {
        return MemberDAO.getCardInfoByCardId(cardId);
    }

    @Override
    public TransactionDetailDTO getTransactionDetail(String memberId, String transactionDate, String cardNumber, String transactionIndustryName, String transactionStoreName, int transactionAmount) {
        String transactionIndustryCode = "";
        //세부 거래내역 보기
        //우선 이 거래가 혜택을 받았는지 체크
        //우선 그 거래에서 쓴 카드의 지난달 거래한 금액을 알아야함(혜택을 받기위한 실적을 위해)
        //transactionID 가져오기

        //거래내역의 해당 달의 첫 번째 거래내역 Id 가져오기
        //해당 달의 1일을 변수에 지정
        if (transactionIndustryName.equals("편의점")) {
            transactionIndustryCode = "CS";
        } else if (transactionIndustryName.equals("대형마트")) {
            transactionIndustryCode = "MT";
        } else if (transactionIndustryName.equals("카페")) {
            transactionIndustryCode = "CE";
        } else if (transactionIndustryName.equals("대중교통")) {
            transactionIndustryCode = "PT";
        } else if (transactionIndustryName.equals("쇼핑")) {
            transactionIndustryCode = "SH";
        } else if (transactionIndustryName.equals("주유")) {
            transactionIndustryCode = "OL";
        } else if (transactionIndustryName.equals("요식")) {
            transactionIndustryCode = "FD";
        } else if (transactionIndustryName.equals("문화시설")) {
            transactionIndustryCode = "CT";
        } else if (transactionIndustryName.equals("교육")) {
            transactionIndustryCode = "ED";
        } else if (transactionIndustryName.equals("의료")) {
            transactionIndustryCode = "MD";
        } else if (transactionIndustryName.equals("항공")) {
            transactionIndustryCode = "AP";
        } else if (transactionIndustryName.equals("여행")) {
            transactionIndustryCode = "TR";
        } else if (transactionIndustryName.equals("기타 국내가맹점")) {
            transactionIndustryCode = "AL";
        }

        String firstTransactionDate = transactionDate.substring(0, transactionDate.length() - 2) + "01";
        System.out.println("오류 전");
        System.out.println("memberId: " + memberId + " transactionDate: " + transactionDate + " cardNumber: " + cardNumber + " transactionIndustryCode: " + transactionIndustryCode + " transactionStoreName: " + transactionStoreName + " transactionAmount: " + transactionAmount);
        int transactionId = MemberDAO.getTransactionId(memberId, transactionDate, cardNumber, transactionIndustryCode, transactionStoreName, transactionAmount);
        Integer lastMonthTotal = MemberDAO.getLastMonthTotal(transactionId, memberId);
        int firstTransactionId = MemberDAO.getFirstTransactionId(memberId, firstTransactionDate);

        TransactionHistoryDTO transactionHistoryDTO = new TransactionHistoryDTO(transactionId, transactionDate, transactionAmount, cardNumber, memberId, transactionIndustryCode, transactionStoreName);

        int discountSum = 0;
        int AccumulationSum = 0;

        if (lastMonthTotal != null) {
            //그 거래에서 사용된 카드가 어떤 상품인지
            int cardId = MemberDAO.getCardIdByTransaction(transactionId);
            //그 거래에서 쓴 카드가 혜택을 받았는지 체크
            BenefitDTO benefitCheckDto = MemberDAO.getBenefitAmountByTransaction(transactionId, lastMonthTotal, cardId, memberId);
            System.out.println("혜택을 받았는지 체크: " + benefitCheckDto);
            //혜택을 받았다면 혜택을 받은 금액을 가져와서 합산해줘야함
            //우선 혜택이 한도를 벗어났나 체크
            //if benefitCheckDto가 null이 아니라면 출력
            if (benefitCheckDto != null) {
                //혜택 한도가 횟수 제한이라면
                if (benefitCheckDto.getBenefitCode().substring(3, 4).equals("C")) {
                    //거래한 해당 달의 1일부터 그날까지 중 이 혜택이 있는 지 체크
                    //있다면 그 횟수를 가져와서 혜택한도와 비교
                    //체크를 그 해당 거래내역의 카드번호와 그 달의 첫번째 거래내역ID(기간설정을 위해), 그리고 거래업종가지고 하게 됨
                    int benefitCount = MemberDAO.getBenefitCountFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());
                    System.out.println("이번달에 그전에 이 혜택을 몇번 썼는지의 횟수 : " + benefitCount);
                    //그 횟수가 혜택한도보다 작다면 혜택을 받은 금액을 합산해줘야함
                    int benefitMax = benefitCheckDto.getBenefitMax();
                    if (benefitCount <= benefitMax) {
                        //혜택 한도보다 덜 썼다면 혜택을 받은 금액을 합산해줘야함
                        //혜택이 적립인지 할인인지를 따진다
                        if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                            //할인이라면
                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                System.out.println("benefitCheckDto.getBenefitCode().substring(2,3): " + benefitCheckDto.getBenefitCode().substring(2, 3));
                                discountSum += benefitCheckDto.getBenefitAmount();
                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                int discountAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                discountSum += discountAmount;
                            }
                        } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                            System.out.println("benefitCheckDto.getBenefitCode().substring(0,2): " + benefitCheckDto.getBenefitCode().substring(0, 2));
                            //적립이라면
                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                System.out.println("benefitCheckDto.getBenefitCode().substring(2,3): " + benefitCheckDto.getBenefitCode().substring(2, 3));
                                AccumulationSum += benefitCheckDto.getBenefitAmount();
                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                AccumulationSum += AccumulationAmount;
                            }
                        }
                    }
                }
                //혜택 한도가 금액 제한이라면 (일단 제한 생각안함)
                else if (benefitCheckDto.getBenefitCode().substring(3, 4).equals("A")) {
                    //이 혜택과 같은 거래를 한 거래내역들의 금액 가져옴
                    List<Integer> transactionAmountList = MemberDAO.getTransactionAmountListFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());

                    // 초기 혜택 월 최대 한도 값 저장
                    int benefitMax = benefitCheckDto.getBenefitMax();
                    //이달의 같은 거래에 대한 거래금액 리스트가지고 이번달 혜택 한도 값 비교
                    if (!transactionAmountList.isEmpty()) {
                        if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                            for (Integer price : transactionAmountList) {
                                //결제하려던 원래 금액
                                int originPrice = 0;
                                if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                    benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                    originPrice = (int) (price / (1 - benefitCheckDto.getBenefitAmount() / 100));
                                    benefitMax = (int) (benefitMax - (originPrice - price));
                                }
                            }
                        } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                            for (Integer price : transactionAmountList) {
                                //결제하려던 원래 금액
                                if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                    benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                    benefitMax = (int) (benefitMax - (price * benefitCheckDto.getBenefitAmount() / 100));
                                }
                            }
                        }
                    }
                    //이번달 그 혜택 한도가 아직 남았을 때
                    if (benefitMax > 0) {
                        //이번 거래내역 이전의 이번달 거래내역들 중에서 그 혜택으로 얼마를 혜택 받았는 지 체크
                        if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                if (benefitMax > benefitCheckDto.getBenefitAmount()) {
                                    discountSum += benefitCheckDto.getBenefitAmount();
                                } else {
                                    discountSum += benefitMax;
                                }
                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100)) {
                                    int discountAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                    discountSum += discountAmount;
                                } else {
                                    discountSum += benefitMax;
                                }
                            }
                        } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                            if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                if (benefitMax > benefitCheckDto.getBenefitAmount()) {
                                    AccumulationSum += benefitCheckDto.getBenefitAmount();
                                } else {
                                    AccumulationSum += benefitMax;
                                }
                            } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100)) {
                                    int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100);
                                    AccumulationSum += AccumulationAmount;
                                } else {
                                    AccumulationSum += benefitMax;
                                }
                            }
                        }
                    }
                }
            }
            //가게명으로 찾았을 때 혜택이 없다면 업종으로 한번더 찾기
            else {
                if (cardId == 7 && transactionHistoryDTO.getTransactionIndustryCode().equals("FD") && lastMonthTotal >= 300000) {
                    BenefitDTO benefitCheckDto2 = MemberDAO.getBenefitAmountByTransaction2();
                    List<Integer> transactionAmountList = MemberDAO.getTransactionAmountListFromTransactionHistory(firstTransactionId, transactionId, transactionHistoryDTO.getTransactionIndustryCode(), transactionHistoryDTO.getCardNumber());
                    // 초기 혜택 월 최대 한도 값 저장
                    int benefitMax = benefitCheckDto2.getBenefitMax();
                    if (!transactionAmountList.isEmpty()) {
                        if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("DC")) {
                            for (Integer price : transactionAmountList) {
                                //결제하려던 원래 금액
                                int originPrice = 0;
                                if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                    benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                    originPrice = (int) (price / (1 - benefitCheckDto.getBenefitAmount() / 100));
                                    benefitMax = (int) (benefitMax - (originPrice - price));
                                }
                            }
                        } else if (benefitCheckDto.getBenefitCode().substring(0, 2).equals("AC")) {
                            for (Integer price : transactionAmountList) {
                                //결제하려던 원래 금액
                                if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("V")) {
                                    benefitMax = (int) (benefitMax - benefitCheckDto.getBenefitAmount());
                                } else if (benefitCheckDto.getBenefitCode().substring(2, 3).equals("P")) {
                                    benefitMax = (int) (benefitMax - (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto.getBenefitAmount() / 100));
                                }
                            }
                        }
                    }
                    System.out.println("transactionAmountList 비었나 체크: " + transactionAmountList);
                    System.out.println("benefitMax: " + benefitMax);

                    if (benefitMax > 0) {
                        if (benefitMax > (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto2.getBenefitAmount() / 100)) {
                            int AccumulationAmount = (int) (transactionHistoryDTO.getTransactionAmount() * benefitCheckDto2.getBenefitAmount() / 100);
                            AccumulationSum += AccumulationAmount;
                        } else {
                            AccumulationSum += benefitMax;
                        }
                    }
                } else {
                    System.out.println("예외 발생");
                }
            }
        }
        ;
        int discountAmount;
        TransactionDetailDTO transactionDetailDTO = new TransactionDetailDTO(transactionId, transactionDate, transactionAmount, cardNumber, memberId, transactionIndustryName, transactionStoreName, AccumulationSum, discountSum);
        return transactionDetailDTO;
    }
}
