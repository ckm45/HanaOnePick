package com.ckm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class MakeSearchHistory {
    public static void main(String[] args) {
        
        Connection connection = ConnectJDBC.getConnection();


        Random random = new Random();

        List<String> ceList = List.of("스타벅스", "엔제리너스커피", "엔제리너스", "이디야", "엔제리너스커피할인쿠폰", "투썸플레이스",
                "파리바게뜨", "엔젤리너스", "투썸", "이디야멤버스", "공차", "카페베네");
        List<String> csList = List.of("gs", "GS", "CU 편의점", "cu", "GS25편의점");
        List<String> fdList = List.of("버거킹", "롯데리아", "KFC", "버거킹할인쿠폰", "롯데리아할인쿠폰", "kfc", "맥도날드",
                "크리스피크림도넛", "베스킨라빈스31", "맘스터치", "배스킨라빈스", "KFC할인쿠폰", "베스킨라빈스31쿠폰", "베스킨라빈스", "아웃백",
                "크리스피", "송추가마골", "한촌설렁탕", "피자헛", "송추가마골 와우 카드", "던킨도너츠", "아디다스", "설빙", "파파이스", "던킨",
                "맥도널드", "한촌설렁탕 쿠폰");
        List<String> mtList = List.of("이마트", "이마트포인트카드");
        List<String> olList = List.of("현대오일뱅크");
        List<String> shList = List.of("모다아울렛", "마인드브릿지", "모다", "전자랜드프라이스킹멤버십", "CJONE", "전자랜드",
                "신세계", "올리브영", "홈플러스", "아티제", "모이몰른", "신세계포인트", "스타일난다", "갤러리아 멤버십카드", "다이소",
                "에이스침대", "모다 보너스 포인트", "신세계아울렛", "삼성전자", "모다아울렛 구리남양주");
        List<String> unList = List.of("삼성전자멤버십", "T멤버십", "해피포인트카드", "해피포인트", "삼성전자 멤버십 OK캐쉬백 제휴카드",
                "OK캐쉬백", "쑥쑥포인트멤버십", "T멤버쉽", "SKT멤버쉽", "L.POINT", "GS&POINT", "엘포인트", "롯데멤버십카드",
                "오케이캐쉬백", "해피포인트 멤버십", "kt멤버십");

        List<Map<String, Double>> weightList = new ArrayList<>();

        Map<String, Double> map1 = new HashMap<>();
        map1.put("CE", 4.42);
        weightList.add(map1);

        Map<String, Double> map2 = new HashMap<>();
        map2.put("CS", 5.57);
        weightList.add(map2);

        Map<String, Double> map3 = new HashMap<>();
        map3.put("FD", 10.77);
        weightList.add(map3);

        Map<String, Double> map4 = new HashMap<>();
        map4.put("MT", 0.93);
        weightList.add(map4);

        Map<String, Double> map5 = new HashMap<>();
        map5.put("OL", 0.1);
        weightList.add(map5);

        Map<String, Double> map6 = new HashMap<>();
        map6.put("SH", 9.99);
        weightList.add(map6);

        Map<String, Double> map7 = new HashMap<>();
        map7.put("UNKNOWN", 3.17);
        weightList.add(map7);

        double totalWeight = 0;
        for (Map<String, Double> weightMap : weightList) {
            for (Double weight : weightMap.values()) {
                totalWeight += weight;
            }
        }


        int batchSize = 2500; 
        LocalDate startDate = LocalDate.of(2023, 8, 1); 
        LocalDate endDate = LocalDate.of(2023, 8, 31); 

        while (!startDate.isAfter(endDate)) {
            List<String> selectedKeywords = new ArrayList<>();
            List<String> selectedIndustryCodes = new ArrayList<>();
            
            
            for (int j = 0; j < batchSize; j++) {
                int selectedIndex = selectRandomIndex(weightList, random);
                String selectedIndustryCode = "";

                if (selectedIndex == 0) {
                    selectedIndustryCode = "CE";
                } else if (selectedIndex == 1) {
                    selectedIndustryCode = "CS";
                } else if (selectedIndex == 2) {
                    selectedIndustryCode = "FD";
                } else if (selectedIndex == 3) {
                    selectedIndustryCode = "MT";
                } else if (selectedIndex == 4) {
                    selectedIndustryCode = "OL";
                } else if (selectedIndex == 5) {
                    selectedIndustryCode = "SH";
                } else if (selectedIndex == 6) {
                    selectedIndustryCode = "UNKNOWN";
                }

                String selectedKeyword = "";

                switch (selectedIndustryCode) {
                    case "CE":
                        selectedKeyword = ceList.get(random.nextInt(ceList.size()));
                        break;
                    case "CS":
                        selectedKeyword = csList.get(random.nextInt(csList.size()));
                        break;
                    case "FD":
                        selectedKeyword = fdList.get(random.nextInt(fdList.size()));
                        break;
                    case "MT":
                        selectedKeyword = mtList.get(random.nextInt(mtList.size()));
                        break;
                    case "OL":
                        selectedKeyword = olList.get(random.nextInt(olList.size()));
                        break;
                    case "SH":
                        selectedKeyword = shList.get(random.nextInt(shList.size()));
                        break;
                    case "UNKNOWN":
                        selectedKeyword = unList.get(random.nextInt(unList.size()));
                        break;
                }

                selectedKeywords.add(selectedKeyword);
                selectedIndustryCodes.add(selectedIndustryCode);
            }

            batchInsertSearchHistory(connection, selectedKeywords, selectedIndustryCodes, startDate);

            System.out.println(startDate + "의 데이터 삽입 완료");

            startDate = startDate.plusDays(1); 
        }

 
        try {
            connection.close();
            System.out.println("데이터베이스 연결 해제");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static int selectRandomIndex(List<Map<String, Double>> weightList, Random random) {
        double totalWeight = 0.0;
        for (Map<String, Double> weightMap : weightList) {
            for (Double weight : weightMap.values()) {
                totalWeight += weight;
            }
        }

        double randomValue = random.nextDouble() * totalWeight;

        for (int i = 0; i < weightList.size(); i++) {
            Map<String, Double> weightMap = weightList.get(i);
            for (Double weight : weightMap.values()) {
                randomValue -= weight;
                if (randomValue <= 0) {
                    return i;
                }
            }
        }

        return -1; 
    }


    public static void batchInsertSearchHistory(Connection connection, List<String> searchPlaces,
            List<String> searchIndustryCodes, LocalDate searchDate) {
        PreparedStatement preparedStatement = null;
        try {

            String sql =
                    "INSERT INTO search_history (search_place, search_date, search_industry_code, search_status_code, member_id) VALUES (?,?, ?, 'F','user003')";


            preparedStatement = connection.prepareStatement(sql);

 
            for (int i = 0; i < searchPlaces.size(); i++) {
                preparedStatement.setString(1, searchPlaces.get(i));
                preparedStatement.setDate(2, java.sql.Date.valueOf(searchDate)); 
                preparedStatement.setString(3, searchIndustryCodes.get(i));
                preparedStatement.addBatch();
            }

            preparedStatement.executeBatch();

            preparedStatement.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}