package com.kopo.finalproject.repository;

import com.kopo.finalproject.model.dto.MemberDTO;

public interface MemberRepository {
    // 일반 로그인
    public MemberDTO memberLoginCheck(String ckId, String ckPw);
}
