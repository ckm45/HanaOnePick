package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dao.PayDAO;
import com.kopo.finalproject.model.dto.BenefitDTO;
import com.kopo.finalproject.model.dto.MyCardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PayServiceImpl implements PayService {

    @Autowired
    PayDAO PayDAO;

    @Override
    public List<MyCardDTO> getMyCardList(String memberId) {
        return PayDAO.getMyCardList(memberId);
    }

    @Override
    @Transactional
    public Map<Integer,BenefitDTO> submitPayment(int cardId, String memberId, String storeName, String price, String storeCategoryCode) {
        Map<Integer, BenefitDTO> resultMap = new HashMap<>();


        String cleanPrice = price.replaceAll("[^\\d]", "");

        int intValue = Integer.parseInt(cleanPrice);
        System.out.println("intValue : " + intValue);


        String cardNumber = PayDAO.getCardNumber(cardId, memberId);
        System.out.println("서비스 cardNumber : " + cardNumber);


        Integer benefitId = PayDAO.checkBenefit(memberId, storeName, cardId);
        BenefitDTO benefitDTO = null;
        Integer benefitCount = null;
        if (benefitId == null) {
            System.out.println("혜택이 없습니다.");
            //혜택이 없으면 그냥 insert
            price = String.valueOf(intValue);
            PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
        } else {
            System.out.println("benefitId : " + benefitId);

            //결제할 카드에 해당된 혜택 id의 혜택정보를 가져온다
            benefitDTO = PayDAO.selectBenefit(benefitId);
            System.out.println(benefitDTO);

            //거래내역에서 내가 가져온 혜택정보의 업종코드, 카드Id, 카드 실적과 똑같은 거래내역의 갯수를 가져온다
            //그럴라면 우선 거래내역에서 내가 거래한 내역들이 어떤 혜택ID로 결제했는데 혜택 DTO List를 가져와야한다.
            String benefitIndustryCode = benefitDTO.getBenefitIndustryCode();
            System.out.println("benefitIndustryCode는 " + benefitIndustryCode);
            int cardPerformance = benefitDTO.getCardPerformance();
            benefitCount = PayDAO.checkBenefitCount(benefitIndustryCode, memberId, cardPerformance);
            System.out.println("거래내역에서 내가 결제할거와 같은 혜택을 사용한 횟수 : " + benefitCount);

            //내가 결제할 거래의 혜택정보의 benefitCode의 마지막 값이 C라면 그 혜택의 benefitMax값과 benefitCount를 비교한다.
            //만약 benefitCount값이 benefitMax값을 넘지 않았다면 혜택적용해서 insert
            //만약 benefitCount값이 benefitMax값과 같다면 혜택적용하지 않고 insert
            System.out.println(benefitDTO.getBenefitCode());
            String benefitCode = benefitDTO.getBenefitCode();
            String benefitType = benefitCode.substring(0, 2);
            String benefitAmountType = benefitCode.substring(2, 3);
            if (benefitType.equals("DC")) {
                System.out.println("할인");
                if (benefitCode.charAt(3) == 'C') {
                    if (benefitCount < benefitDTO.getBenefitMax()) {
                        System.out.println("횟수 다안찼음. 혜택적용해서 insert");
                        if (benefitAmountType.equals("V")) {
                            System.out.println("혜택을 금액으로 줌");
                            price = String.valueOf(intValue - benefitDTO.getBenefitAmount());
                            System.out.println("price 변환 값: " + price);
                        } else if (benefitAmountType.equals("P")) {
                            System.out.println("혜택을 퍼센티지로 줌");
                            price = String.valueOf(intValue - (intValue * benefitDTO.getBenefitAmount() / 100));
                            System.out.println("price 변환 값: " + price);
                        }
                        PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                    } else {
                        System.out.println("횟수 다 찼음. 혜택적용하지 않고 insert");
                        price = String.valueOf(intValue);
                        PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                    }
                } else if (benefitCode.charAt(3) == 'A') {
                    //한도가 횟수가 아닌 금액일 때
                    System.out.println("한도가 횟수가 아닌 금액일 때");
                    if (benefitAmountType.equals("P")) {
                        System.out.println("혜택을 퍼센티지로 줌");
                        if ((intValue * benefitDTO.getBenefitAmount() / 100) < benefitDTO.getBenefitMax()) {
                            System.out.println("혜택 최대 금액을 넘지 않았을 때");
                            price = String.valueOf(intValue - (intValue * benefitDTO.getBenefitAmount() / 100));
                            System.out.println("price 변환 값: " + price);
                            PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                        } else {
                            System.out.println("혜택 최대 금액을 넘었을 때");
                            price = String.valueOf(intValue - (intValue * benefitDTO.getBenefitMax() / 100));
                            PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                        }
                    } else if (benefitAmountType.equals("V")) {
                        System.out.println("혜택을 금액으로 줌");
                        if (benefitDTO.getBenefitAmount() < benefitDTO.getBenefitMax()) {
                            System.out.println("혜택 최대 금액을 넘지 않았을 때");
                            price = String.valueOf(intValue - benefitDTO.getBenefitAmount());
                            System.out.println("price 변환 값: " + price);
                            PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                        } else {
                            System.out.println("혜택 최대 금액을 넘었을 때");
                            price = String.valueOf(intValue - benefitDTO.getBenefitMax());
                            PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                        }
                    }
                }
            } else if (benefitType.equals("AC")) {
                System.out.println("적립");
                price = String.valueOf(intValue);
                PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                //적립일 경우
/*                if (benefitAmountType.equals("V")) {
                    price = String.valueOf(intValue);
                    System.out.println("적립 받는 값: " + benefitDTO.getBenefitAmount());
                    PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);

                } else if (benefitAmountType.equals("P")) {
                    price = String.valueOf(intValue);
                    System.out.println("적립 받는 값: " + (intValue * benefitDTO.getBenefitAmount() / 100));
                    PayDAO.insertTransaction(price, cardNumber, memberId, storeCategoryCode, storeName);
                }*/
            }

        }
        resultMap.put(benefitCount, benefitDTO);

        return resultMap;
    }
}
