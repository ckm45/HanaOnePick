package com.kopo.finalproject.service;

import com.kopo.finalproject.model.dao.BenefitDAO;
import com.kopo.finalproject.model.dto.BenefitDTO;
import com.kopo.finalproject.model.dto.BenefitResultDTO;
import com.kopo.finalproject.model.dto.CommonDTO;
import com.kopo.finalproject.model.dto.SearchHistoryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class BenefitServiceImpl implements BenefitService {

    private BenefitDAO benefitDAO;

    @Autowired
    public BenefitServiceImpl(BenefitDAO benefitDAO) {
        this.benefitDAO = benefitDAO;
    }

    @Autowired
    com.kopo.finalproject.model.dao.MemberDAO MemberDAO;

    @Override
    public List<BenefitResultDTO> getMatchingBenefitsByMap(Map<String, String> jsonData) {
        System.out.println("지도에서 혜택 찾기 서비스까지 온 데이터 값(jsonData) : " + jsonData);
        System.out.println(benefitDAO.getMatchingBenefitsByMap(jsonData) + " -> dao 결과");
        if (benefitDAO.getMatchingBenefitsByMap(jsonData).isEmpty()) {
            System.out.println("프렌차이즈 아니어도 혜택 나오게 찾기");
            switch (jsonData.get("groupCode")) {
                case "MT1":
                    jsonData.put("groupCode", "MT");
                    break;
                case "CS2":
                    jsonData.put("groupCode", "CS");
                    break;
                case "PS3":
                case "AC5":
                    jsonData.put("groupCode", "ED");
                    break;
                case "OL7":
                    jsonData.put("groupCode", "OL");
                    break;
                case "CT1":
                    jsonData.put("groupCode", "CT");
                    break;
                case "FD6":
                    jsonData.put("groupCode", "FD");
                    break;
                case "CE7":
                    jsonData.put("groupCode", "CE");
                    break;
                case "HP8":
                case "PM9":
                    jsonData.put("groupCode", "MD");
                    break;
                default:
                    String[] parts = jsonData.get("categoryName").split(" > ");
                    String lastWord = parts[parts.length - 1];
                    if (lastWord.contains("백화점") || lastWord.contains("슈퍼")) {
                        jsonData.put("groupCode", "SH");
                    } else {
                        jsonData.put("groupCode", "AL");
                    }
                    break;
            }
            if (jsonData.get("groupCode").equals("FD")) {
                System.out.println("getMatchingBenefitsByMap2" + benefitDAO.getMatchingBenefitsByMap2(jsonData));
                return benefitDAO.getMatchingBenefitsByMap2(jsonData);
            } else {
                return null;
            }
        } else {
            return benefitDAO.getMatchingBenefitsByMap(jsonData);
        }
    }

    @Override
    public int getCardID(String cardName) {
        return benefitDAO.getCardID(cardName);
    }

    public List<List<CommonDTO>> getMatchingBenefitsBySearch(List<Map<String, Object>> searchDataList, String memberId, String searchHistory) {
        try {

            //memberID로 회원이 가진 보유 카드의 카드ID 리스트 가져오기
            List<Integer> memberCardIdList = benefitDAO.getMemberCardIdList(memberId);
            System.out.println("서비스에서 멤버카드아이디 확인: " + memberCardIdList);

            System.out.println("서비스에서 멤버아이디 확인: " + memberId);
            System.out.println("서비스에서 searchHistroy 확인" + searchHistory);
            System.out.println("서비스에서 검색어 리스트 확인: " + searchDataList);
            List<List<CommonDTO>> resultList = new ArrayList<>();
            String searchIndustryCode = "";
            int mtCode = 0;
            int csCode = 0;
            int edCode = 0;
            int olCode = 0;
            int ctCode = 0;
            int shCode = 0;
            int fdCode = 0;
            int ceCode = 0;
            int mdCode = 0;
            int unknownCode = 0;
            for (Map<String, Object> searchData : searchDataList) {
                String categoryGroupCode = (String) searchData.get("category_group_code");
                String categoryName = (String) searchData.get("category_name");
                System.out.println("서비스 " + categoryGroupCode);
                switch (categoryGroupCode) {
                    case "MT1":
                        mtCode++;
                        break;
                    case "CS2":
                        csCode++;
                        break;
                    case "PS3":
                    case "AC5":
                        edCode++;
                        break;
                    case "OL7":
                        olCode++;
                        break;
                    case "CT1":
                        ctCode++;
                        break;
                    case "FD6":
                        fdCode++;
                        break;
                    case "CE7":
                        ceCode++;
                        break;
                    case "HP8":
                    case "PM9":
                        mdCode++;
                        break;
                    default:
                        String[] parts = categoryName.split(" > ");
                        String lastWord = parts[parts.length - 1];
                        if (lastWord.contains("백화점") || lastWord.contains("슈퍼")) {
                            shCode++;
                        } else {
                            unknownCode++;
                        }
                        break;
                }

                List<CommonDTO> result = benefitDAO.getMatchingBenefitsBySearch(memberId, searchData);
                System.out.println("서비스에서 result 확인: " + result);
                //이 실적을 따진 혜택에 대해 몇번 썼고 몇번 남았는지 체크하기
                for (CommonDTO dto : result) {
                    System.out.println("1");
                    System.out.println(dto.getCardId());
                    int benefit_id = benefitDAO.getBenefitId(memberId, searchData, dto.getCardId());
                    System.out.println(benefit_id);
                    //혜택번호를 통해 혜택DTO 가져오기
                    BenefitDTO benefitDTO = benefitDAO.getBenefitDTO(benefit_id);
                    System.out.println("사용하려는 혜택 정보: " + benefitDTO);
                    //거래내역에서 이 혜택을 얼마나 썼는지 체크해서 count에 저장
                    int count = benefitDAO.getBenefitCount(memberId, benefit_id, benefitDTO.getBenefitIndustryCode());
                    System.out.println("이번달 이 혜택 사용 횟수 : " + count);

                    //count횟수가 혜택 사용한도보다 작아야함 -> 작으면 사용가능
                    if (benefitDTO.getBenefitCode().substring(3, 4).equals("C")) {
                        if (count < benefitDTO.getBenefitMax()) {
                            System.out.println("사용가능");
                        } else {
                            System.out.println("사용불가");
                            result.remove(dto);
                            System.out.println("remove한 뒤의 result 확인: " + result);
                            if (result.isEmpty()) {
                                break;
                            }
                        }
                    }
                }
                //만약 가게명으로 혜택 확인 시에 없더라면
                //업종 코드로 혜택 찾기
                if (result.isEmpty()) {
                    System.out.println("가게명으로 혜택 찾기 실패");
                    System.out.println("업종 코드로 혜택 찾기");
                    result = benefitDAO.getMatchingBenefitsBySearch2(memberId, searchData);
                    System.out.println("업종 코드로 혜택 찾기 결과: " + result);
                }
                if (!result.isEmpty()) {
                    for (CommonDTO serachResultDTO : result) {
                        //searchResultDTO 안에 있는 카드ID가 memberCardIdList에 있는지 확인하고 있다면 memberCardIdList에서 그 카드ID를 제거한다.
                        if (memberCardIdList.contains(serachResultDTO.getCardId())) {
                            memberCardIdList.remove(Integer.valueOf(serachResultDTO.getCardId()));
                        }
                    }
                }
                //memberCardIdList에 남아있는 카드ID들을 확인한다.
                System.out.println("서비스에서 남은 memberCardIdList 확인: " + memberCardIdList);

                for (int cardId : memberCardIdList) {
                    System.out.println("남은 memberCardId: " + cardId);
                    result.add(benefitDAO.getNotBenefitList(memberId, cardId));
                }
                resultList.add(result);
            }


            int maxCode = Math.max(mtCode, Math.max(csCode, Math.max(edCode, Math.max(olCode, Math.max(ctCode, Math.max(shCode, Math.max(fdCode, Math.max(ceCode, Math.max(mdCode, unknownCode)))))))));
            if (maxCode == mtCode) {
                searchIndustryCode = "MT";
            } else if (maxCode == csCode) {
                searchIndustryCode = "CS";
            } else if (maxCode == edCode) {
                searchIndustryCode = "ED";
            } else if (maxCode == olCode) {
                searchIndustryCode = "OL";
            } else if (maxCode == ctCode) {
                searchIndustryCode = "CT";
            } else if (maxCode == shCode) {
                searchIndustryCode = "SH";
            } else if (maxCode == fdCode) {
                searchIndustryCode = "FD";
            } else if (maxCode == ceCode) {
                searchIndustryCode = "CE";
            } else if (maxCode == mdCode) {
                searchIndustryCode = "MD";
            } else {
                searchIndustryCode = "AL";
            }


            benefitDAO.insertSearchHistory(memberId, searchHistory, searchIndustryCode);

            System.out.println("서비스 결과: " + resultList);
            return resultList;
        } catch (Exception e) {
            // 예외 메시지와 스택 트레이스를 출력하여 디버깅에 도움을 줍니다.
            e.printStackTrace();
            throw new RuntimeException("서비스에서 오류 발생: " + e.getMessage());
        }
    }

    @Override
    public List<Map<Integer, Integer>> getBenefitCount(List<Map<String, Object>> searchDataList, String memberId) {
        //memberID로 회원이 가진 보유 카드의 카드ID 리스트 가져오기
        List<Integer> memberCardIdList = benefitDAO.getMemberCardIdList(memberId);
        List<Map<Integer, Integer>> benefitCounts = new ArrayList<>();
        String searchIndustryCode = "";
        int mtCode = 0;
        int csCode = 0;
        int edCode = 0;
        int olCode = 0;
        int ctCode = 0;
        int shCode = 0;
        int fdCode = 0;
        int ceCode = 0;
        int mdCode = 0;
        int unknownCode = 0;
        for (Map<String, Object> searchData : searchDataList) {
            String storeName = (String) searchData.get("place_name");
            String categoryGroupCode = (String) searchData.get("category_group_code");
            String categoryName = (String) searchData.get("category_name");
            System.out.println("서비스 " + categoryGroupCode);
            switch (categoryGroupCode) {
                case "MT1":
                    mtCode++;
                    break;
                case "CS2":
                    csCode++;
                    break;
                case "PS3":
                case "AC5":
                    edCode++;
                    break;
                case "OL7":
                    olCode++;
                    break;
                case "CT1":
                    ctCode++;
                    break;
                case "FD6":
                    fdCode++;
                    break;
                case "CE7":
                    ceCode++;
                    break;
                case "HP8":
                case "PM9":
                    mdCode++;
                    break;
                default:
                    String[] parts = categoryName.split(" > ");
                    String lastWord = parts[parts.length - 1];
                    if (lastWord.contains("백화점") || lastWord.contains("슈퍼")) {
                        shCode++;
                    } else {
                        unknownCode++;
                    }
                    break;
            }


            List<CommonDTO> result = benefitDAO.getMatchingBenefitsBySearch(memberId, searchData);
            System.out.println("서비스에서 result 확인: " + result);
            //이 실적을 따진 혜택에 대해 몇번 썼고 몇번 남았는지 체크하기
            for (CommonDTO dto : result) {
                System.out.println(dto.getCardId());
                int benefit_id = benefitDAO.getBenefitId(memberId, searchData, dto.getCardId());
                System.out.println(benefit_id);
                //혜택번호를 통해 혜택DTO 가져오기
                BenefitDTO benefitDTO = benefitDAO.getBenefitDTO(benefit_id);
                System.out.println("사용하려는 혜택 정보: " + benefitDTO);
                //거래내역에서 이 혜택을 얼마나 썼는지 체크해서 count에 저장
                if (benefitDTO.getBenefitCode().substring(3, 4).equals("C")) {
                    int count = benefitDAO.getBenefitCount(memberId, benefit_id, benefitDTO.getBenefitIndustryCode());
                    System.out.println("이번달 이 혜택 사용 횟수 : " + count);
                    benefitCounts.add(Map.of(benefitDTO.getCardId(), count));
                } else {
                    System.out.println("한도 금액에 대한 혜택");
                    List<Integer> amountList = benefitDAO.getBenefitAmountList(memberId, storeName);
                    System.out.println("한도 금액 리스트: " + amountList);
                    if (amountList.isEmpty()) {
                        benefitCounts.add(Map.of(benefitDTO.getCardId(), 0));
                    } else {
                        int benefitAmount = 0;
                        for (Integer price : amountList) {
                            System.out.println("한도 따지기 위한 price: " + price);
                            int originPrice = 0;
                            if (benefitDTO.getBenefitCode().substring(2, 3).equals("V")) {
                                benefitAmount += (int) (benefitDTO.getBenefitAmount());
                            } else if (benefitDTO.getBenefitCode().substring(2, 3).equals("P")) {
                                originPrice = (int) (price / (1 - benefitDTO.getBenefitAmount() / 100));
                                benefitAmount += (int) ((originPrice - price));
                            }
                        }
                        benefitCounts.add(Map.of(benefitDTO.getCardId(), benefitAmount));
                    }
//                int count = benefitDAO.getBenefitCount(memberId, benefit_id, benefitDTO.getBenefitIndustryCode());
//                System.out.println("이번달 이 혜택 사용 횟수 : " + count);
//
//                benefitCounts.add(Map.of(benefitDTO.getCardId(), count));

                }
            }
        }
        //benefitCounts map을 전체 출력
        for (Map<Integer, Integer> benefitCount : benefitCounts) {
            for (Integer key : benefitCount.keySet()) {
                System.out.println("서비스에서 benefitCount 확인: " + key + " " + benefitCount.get(key));
            }
        }
        return benefitCounts;
    }

    @Override
    public List<SearchHistoryDTO> getSearchHistoryList(String memberId) {
        return benefitDAO.getSearchHistoryList(memberId);
    }

    @Override
    public void updateSearchStatus(int searchHistoryId) {
        System.out.println("서비스에서 searchHistoryId 확인: " + searchHistoryId);
        benefitDAO.updateSearchStatus(searchHistoryId);
    }

    @Override
    public List<String> selectSearchRank() {
        return benefitDAO.selectSearchRank();
    }

    @Override
    public void checkNearByBenefit(Map<String, String> jsonData) {
        System.out.println("지도에서 혜택 찾기 서비스까지 온 데이터 값(jsonData) : " + jsonData);
        System.out.println(benefitDAO.getMatchingBenefitsByMap(jsonData) + " -> dao 결과");
        if (benefitDAO.getMatchingBenefitsByMap(jsonData).isEmpty()) {
            System.out.println("프렌차이즈 아니어도 혜택 나오게 찾기");
            //찾기 위해 카카오의 그룹코드를 내 카테고리 그룹코드로 변경
            switch (jsonData.get("groupCode")) {
                case "MT1":
                    jsonData.put("groupCode", "MT");
                    break;
                case "CS2":
                    jsonData.put("groupCode", "CS");
                    break;
                case "PS3":
                case "AC5":
                    jsonData.put("groupCode", "ED");
                    break;
                case "OL7":
                    jsonData.put("groupCode", "OL");
                    break;
                case "CT1":
                    jsonData.put("groupCode", "CT");
                    break;
                case "FD6":
                    jsonData.put("groupCode", "FD");
                    break;
                case "CE7":
                    jsonData.put("groupCode", "CE");
                    break;
                case "HP8":
                case "PM9":
                    jsonData.put("groupCode", "MD");
                    break;
                default:
                    String[] parts = jsonData.get("categoryName").split(" > ");
                    String lastWord = parts[parts.length - 1];
                    if (lastWord.contains("백화점") || lastWord.contains("슈퍼")) {
                        jsonData.put("groupCode", "SH");
                    } else {
                        jsonData.put("groupCode", "AL");
                    }
                    break;
            }

            System.out.println("getMatchingBenefitsByMap2" + benefitDAO.getMatchingBenefitsByMap2(jsonData));
            //return benefitDAO.getMatchingBenefitsByMap2(jsonData);
        } else {
            //return benefitDAO.getMatchingBenefitsByMap(jsonData);
        }
    }

    @Override
    public int getThisMonthTotal(int cardId, String memberId) {
        return MemberDAO.getThisMonthTotal(cardId, memberId);
    }


}
