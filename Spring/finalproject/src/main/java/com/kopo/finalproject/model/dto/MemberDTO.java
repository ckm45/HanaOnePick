package com.kopo.finalproject.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class MemberDTO {
    private String memberId;
    private String name;
    private String personalIdNumber;
    private String password;
    private String email;
    private String regDate;
    private String gender;
    private String phone;
    private String zipcode;
    private String address;
    private String detailAddress;
    private int age;
    private int memberStatus;

    public MemberDTO(){

    }

}
