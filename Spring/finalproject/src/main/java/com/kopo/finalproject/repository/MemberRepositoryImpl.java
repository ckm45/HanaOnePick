/*
package com.kopo.finalproject.repository;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import org.springframework.stereotype.Repository;
import com.kopo.finalproject.model.dto.MemberDTO;


public class MemberRepositoryImpl implements MemberRepository {
    private static MemberRepositoryImpl instance = null;


    public MemberRepositoryImpl() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static MemberRepositoryImpl getInstance() {
        if (instance == null) {
            synchronized (MemberRepositoryImpl.class) {
                if (instance == null) {
                    instance = new MemberRepositoryImpl();
                }
            }
        }
        return instance;
    }

    @Override
    public MemberDTO memberLoginCheck(String ckId, String ckPw) {
        boolean ck = false;
        System.out.println("일반 회원 login 체크");
        MemberDTO dto = null;
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM member WHERE member_id = '"
                     + ckId + "' AND member_status_code = '2'")) {

            while (rs.next()) {
                String memberId = rs.getString("member_id");
                String password = rs.getString("password");
                System.out.println("id: " + memberId + "|pw : " + password);
                if (ckId.equals(memberId) && ckPw.equals(password)) {
                    String name = rs.getString("name");
                    System.out.println("name: "+ name);
                    String personalIdNumber = rs.getString("personal_id");
                    System.out.println("personalIdNumber: "+ personalIdNumber);
                    String email = rs.getString("email");
                    System.out.println("email: "+ email);
                    Date regDate = rs.getDate("reg_date");
                    System.out.println("regDate: "+ regDate);
                    String gender = rs.getString("gender");
                    System.out.println("gender: "+ gender);
                    String phone = rs.getString("phone_number");
                    System.out.println("phone: "+ phone);
                    String zipcode = rs.getString("zipcode");
                    System.out.println("zipcode: "+ zipcode);
                    String address = rs.getString("address");
                    System.out.println("address: "+ address);
                    String detailAddress = rs.getString("detail_address");
                    System.out.println("detailAddress : "+ detailAddress );
                    int age = rs.getInt("age");
                    System.out.println("age : "+ age);
                    int memberStatus = Integer.parseInt(rs.getString("member_status_code"));
                    System.out.println("memberStatus : "+ memberStatus);
                    // SimpleDateFormat을 사용하여 Date를 문자열로 변환
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String regDateStr = sdf.format(regDate);
                    System.out.println("regDateStr: " + regDateStr);
                    ck = true;
                    dto = new MemberDTO(memberId, name, personalIdNumber, password, email, regDateStr,
                            gender, phone, zipcode, address,detailAddress, age, memberStatus);

                } else {
                    System.out.println("login fail");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(dto);
        return dto;

    }
}
*/
