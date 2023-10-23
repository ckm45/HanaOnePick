package com.ckm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class MakeTransactionHistory {
    public static void main(String[] args) {
        // 데이터베이스 연결 객체 얻기
        Connection connection = ConnectJDBC.getConnection();

        int payCnt = 0;
        String payDate = "20221015"; // 초기 날짜 설정

        // 랜덤 객체 생성
        Random random = new Random();


        // 가중치를 고려하여 랜덤 검색어 선택
        List<String> shList = List.of("신세계백화점 철산점", "현대백화점 철산점", "롯데백화점 철산점", "GS슈퍼 철산점",
                "롯데슈퍼 철산점", "이케아 철산점");

        List<String> fdList = List.of("파리바게트 철산점", "뚜레쥬르 철산점", "서브웨이 철산점", "짬뽕시대 철산점", "초롱분식 철산점",
                "정겨운국수 철산점", "더맛있는족발보쌈 철산점", "팔각도 철산점", "리유라멘 철산점", "라라코스트 철산점", "철산감자탕 철산점",
                "백소정 철산점", "정통집 철산점", "맛찬들왕소금구이 철산점", "니뽕내뽕 철산점", "448돈까스 철산점");

        List<String> ceList = List.of("스타벅스 철산점", "커피빈 철산점", "이디야 철산점", "공차 철산점", "투썸플레이스 철산점",
                "파리바게뜨 철산점", "엔젤리너스 철산점", "공차 철산점", "카페베네 철산점");

        List<String> mtList = List.of("이마트 철산점", "롯데마트 철산점", "홈플러스 철산점");

        List<String> csList = List.of("GS25 철산점", "CU 철산점", "세븐일레븐 철산점");

        List<String> olList = List.of("현대오일뱅크 철산점", "SK에너지 철산점", "GS칼텍스 철산점", "S-OIL 철산점");

        List<String> apList =
                List.of("대한항공 ", "아시아나항공 ", "진에어 ", "에어부산 ", "에어서울 ", "제주항공 ", "티웨이 ", "이스타 ");

        List<String> ptList = List.of("버스 ", "지하철 ", "택시 ", "KTX ", "SRT ");

        List<String> ctList = List.of("CGV 철산점", "롯데시네마 철산점", "메가박스 철산점", "골프장 철산점", "골프연습장 철산점",
                "스크린골프 철산점", "스포츠센터 철산점", "수영장 철산점");

        List<String> trList = List.of("하나투어 ", "아고다 ", "익스피디아 ", "호텔스닷컴 ");

        List<String> mdList = List.of("하나병원 철산점", "하나약국 철산점");

        List<String> edList = List.of("하나수학학원 철산점", "하나영어학원 철산점", "하나어린이집 ", "하나유치원 ");


        // 가중치 리스트 초기화
        List<Map<String, Double>> weightList = new ArrayList<>();

        Map<String, Double> map1 = new HashMap<>();
        map1.put("CE", 13.00);
        weightList.add(map1);

        Map<String, Double> map2 = new HashMap<>();
        map2.put("CS", 16.99);
        weightList.add(map2);

        Map<String, Double> map3 = new HashMap<>();
        map3.put("FD", 22.28);
        weightList.add(map3);

        Map<String, Double> map4 = new HashMap<>();
        map4.put("MT", 8.69);
        weightList.add(map4);

        Map<String, Double> map5 = new HashMap<>();
        map5.put("OL", 4.72);
        weightList.add(map5);

        Map<String, Double> map6 = new HashMap<>();
        map6.put("SH", 11.00);
        weightList.add(map6);

        Map<String, Double> map7 = new HashMap<>();
        map7.put("AP", 0.07);
        weightList.add(map7);

        Map<String, Double> map8 = new HashMap<>();
        map8.put("PT", 6.55);
        weightList.add(map8);

        Map<String, Double> map9 = new HashMap<>();
        map9.put("CT", 3.97);
        weightList.add(map9);

        Map<String, Double> map10 = new HashMap<>();
        map10.put("TR", 0.29);
        weightList.add(map10);

        Map<String, Double> map11 = new HashMap<>();
        map11.put("MD", 5.66);
        weightList.add(map11);

        Map<String, Double> map12 = new HashMap<>();
        map12.put("ED", 3.78);
        weightList.add(map12);

        // 총 가중치 합 계산
        double totalWeight = 0;
        for (Map<String, Double> weightMap : weightList) {
            for (Double weight : weightMap.values()) {
                totalWeight += weight;
            }
        }

        // payCnt가 3이 될 때까지 반복
        while (payDate.compareTo("20231015") <= 0) { 
            // 가중치를 고려하여 랜덤 검색어 선택

            List<Integer> selectedPrices = new ArrayList<>();
            List<String> selectedKeywords = new ArrayList<>();
            List<String> selectedIndustryCodes = new ArrayList<>();

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
                selectedIndustryCode = "AP";
            } else if (selectedIndex == 7) {
                selectedIndustryCode = "PT";
            } else if (selectedIndex == 8) {
                selectedIndustryCode = "CT";
            } else if (selectedIndex == 9) {
                selectedIndustryCode = "TR";
            } else if (selectedIndex == 10) {
                selectedIndustryCode = "MD";
            } else if (selectedIndex == 11) {
                selectedIndustryCode = "ED";
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
                case "AP":
                    selectedKeyword = apList.get(random.nextInt(apList.size()));
                    break;
                case "PT":
                    selectedKeyword = ptList.get(random.nextInt(ptList.size()));
                    break;
                case "CT":
                    selectedKeyword = ctList.get(random.nextInt(apList.size()));
                    break;
                case "TR":
                    selectedKeyword = trList.get(random.nextInt(trList.size()));
                    break;
                case "MD":
                    selectedKeyword = mdList.get(random.nextInt(mdList.size()));
                    break;
                case "ED":
                    selectedKeyword = edList.get(random.nextInt(edList.size()));
                    break;
            }

            int price = 10000 + (random.nextInt(51) * 100);
            price = (price / 100) * 100;

            selectedPrices.add(price);
            selectedKeywords.add(selectedKeyword);
            selectedIndustryCodes.add(selectedIndustryCode);


            batchInsertSearchHistory(connection, selectedKeywords, selectedIndustryCodes,
                    selectedPrices, payDate);
            
            batchInsertSearchHistorySecond(connection, selectedKeywords, selectedIndustryCodes,
                    selectedPrices, payDate);

            // payCnt 증가
            payCnt++;

            // payCnt가 3이면 날짜를 하루 뒤로 설정하고 payCnt를 0으로 초기화
            if (payCnt >= 3) {
                payDate = incrementDate(payDate);
                payCnt = 0;
            }
        }

        // 데이터베이스 연결 해제
        try {
            connection.close();
            System.out.println("데이터베이스 연결 해제");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static String convertToDBDateFormat(String dateStr) {
        return dateStr.substring(0, 4) + "-" + dateStr.substring(4, 6) + "-" + dateStr.substring(6, 8);
    }

    public static String incrementDate(String dateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            Date date = dateFormat.parse(dateStr);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.DAY_OF_MONTH, 1);

            String incrementedDate = dateFormat.format(calendar.getTime());

            if (incrementedDate.endsWith("01")) {
                System.out.println("1일입니다.");
                System.out.println(incrementedDate);
                

                String dbFormatDate = convertToDBDateFormat(incrementedDate);
                 System.out.println("dbFormatDate : " + dbFormatDate);
                String updateQuery ="UPDATE membercard m\r\n"
                        + "SET m.last_month_total = (\r\n"
                        + "    SELECT SUM(th.transaction_amount)\r\n"
                        + "    FROM transactionhistory th\r\n"
                        + "    WHERE th.card_number = m.card_number\r\n"
                        + "    AND th.transaction_date BETWEEN ADD_MONTHS(TO_DATE(?, 'YYYY-MM-DD'), -1) AND TO_DATE(?, 'YYYY-MM-DD')\r\n"
                        + ")\r\n"
                        + "WHERE m.card_number IN (\r\n"
                        + "    SELECT DISTINCT card_number\r\n"
                        + "    FROM transactionhistory th\r\n"
                        + "    WHERE th.transaction_date BETWEEN ADD_MONTHS(TO_DATE(?, 'YYYY-MM-DD'), -1) AND TO_DATE(?, 'YYYY-MM-DD')\r\n"
                        + ")";

                try (Connection connection = ConnectJDBC.getConnection();
                        PreparedStatement preparedStatement =
                                connection.prepareStatement(updateQuery)) {

                    // 'dbFormatDate'를 두 번 바인딩
                    preparedStatement.setString(1, dbFormatDate);
                    preparedStatement.setString(2, dbFormatDate);
                    preparedStatement.setString(3, dbFormatDate);
                    preparedStatement.setString(4, dbFormatDate);

                    int rowsUpdated = preparedStatement.executeUpdate();

                    if (rowsUpdated > 0) {
                        System.out.println("쿼리 실행 성공");
                    } else {
                        System.out.println("쿼리 실행 실패");
                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            return incrementedDate;
        } catch (Exception e) {
            e.printStackTrace();
            return dateStr;
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
            List<String> searchIndustryCodes, List<Integer> selectedPrices, String payDate) {
        PreparedStatement preparedStatement = null;
        CallableStatement pickCardStmt = null;
        CallableStatement submitPaymentStmt = null;
        try {
            // 2. SP_PICK_CARD 프로시저 호출
            pickCardStmt = connection.prepareCall("{ call SP_PICK_CARD(?, ?, ?, ?, ?, ?) }");

            submitPaymentStmt =
                    connection.prepareCall("{ call SP_SUBMIT_PAYMENT(?, ?, ?, ?, ?, ?, ?) }");

            for (int i = 0; i < searchPlaces.size(); i++) {
                System.out.println("프로시저 호출 전 선택된 가게명: " + searchPlaces.get(i));
                System.out.println("프로시저 호출 전 선택된 업종명: " + searchIndustryCodes.get(i));
                System.out.println("프로시저 호출 전 가격: " + selectedPrices.get(i));
                // SP_PICK_CARD 프로시저 호출
                pickCardStmt.setString(1, payDate);
                pickCardStmt.setString(2, "user001");
                pickCardStmt.setString(3, searchPlaces.get(i));
                pickCardStmt.setInt(4, selectedPrices.get(i));
                pickCardStmt.setString(5, searchIndustryCodes.get(i));
                pickCardStmt.registerOutParameter(6, Types.VARCHAR);
                pickCardStmt.execute();
                String v_card_id = pickCardStmt.getString(6);
                System.out.println(v_card_id + " card_id 결과입니다.");
                System.out.println(payDate + " 결제 날짜입니다.");
                // SP_SUBMIT_PAYMENT 프로시저 호출
                submitPaymentStmt =
                        connection.prepareCall("{ call SP_SUBMIT_PAYMENT(?, ?, ?, ?, ?, ?, ?) }");
                submitPaymentStmt.setString(1, payDate);
                submitPaymentStmt.setString(2, "user001");
                submitPaymentStmt.setString(3, v_card_id);
                submitPaymentStmt.setString(4, searchPlaces.get(i));
                submitPaymentStmt.setInt(5, selectedPrices.get(i));
                submitPaymentStmt.setString(6, searchIndustryCodes.get(i));
                submitPaymentStmt.registerOutParameter(7, Types.VARCHAR); // OUT 매개변수 등록
                submitPaymentStmt.execute();
                String v_transaction_id = submitPaymentStmt.getString(7);
                System.out.println("Transaction ID: " + v_transaction_id);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (pickCardStmt != null) {
                    pickCardStmt.close();
                }
                if (submitPaymentStmt != null) {
                    submitPaymentStmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void batchInsertSearchHistorySecond(Connection connection, List<String> searchPlaces,
            List<String> searchIndustryCodes, List<Integer> selectedPrices, String payDate) {
        PreparedStatement preparedStatement = null;
        CallableStatement pickCardStmt = null;
        CallableStatement submitPaymentStmt = null;
        try {
            // 2. SP_PICK_CARD 프로시저 호출
            pickCardStmt = connection.prepareCall("{ call SP_PICK_CARD(?, ?, ?, ?, ?, ?) }");

            submitPaymentStmt =
                    connection.prepareCall("{ call SP_SUBMIT_PAYMENT(?, ?, ?, ?, ?, ?, ?) }");

            for (int i = 0; i < searchPlaces.size(); i++) {
                System.out.println("프로시저 호출 전 선택된 가게명: " + searchPlaces.get(i));
                System.out.println("프로시저 호출 전 선택된 업종명: " + searchIndustryCodes.get(i));
                System.out.println("프로시저 호출 전 가격: " + selectedPrices.get(i));
                // SP_PICK_CARD 프로시저 호출
                pickCardStmt.setString(1, payDate);
                pickCardStmt.setString(2, "user002");
                pickCardStmt.setString(3, searchPlaces.get(i));
                pickCardStmt.setInt(4, selectedPrices.get(i));
                pickCardStmt.setString(5, searchIndustryCodes.get(i));
                pickCardStmt.registerOutParameter(6, Types.VARCHAR);
                pickCardStmt.execute();
                String v_card_id = pickCardStmt.getString(6);
                System.out.println(v_card_id + " card_id 결과입니다.");
                System.out.println(payDate + " 결제 날짜입니다.");

                submitPaymentStmt =
                        connection.prepareCall("{ call SP_SUBMIT_PAYMENT(?, ?, ?, ?, ?, ?, ?) }");
                submitPaymentStmt.setString(1, payDate);
                submitPaymentStmt.setString(2, "user002");
                submitPaymentStmt.setString(3, v_card_id);
                submitPaymentStmt.setString(4, searchPlaces.get(i));
                submitPaymentStmt.setInt(5, selectedPrices.get(i));
                submitPaymentStmt.setString(6, searchIndustryCodes.get(i));
                submitPaymentStmt.registerOutParameter(7, Types.VARCHAR); 
                submitPaymentStmt.execute();
                String v_transaction_id = submitPaymentStmt.getString(7);
                System.out.println("Transaction ID: " + v_transaction_id);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (pickCardStmt != null) {
                    pickCardStmt.close();
                }
                
                if (submitPaymentStmt != null) {
                    submitPaymentStmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
