package com.ezen.FSB.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;

@Service
public class NaverLoginMapper {
	@Autowired
	private SqlSession sqlSession;
	
	// 네이버 회원가입
	public int insertNaverMember(MemberDTO dto) {
		int res = sqlSession.insert("insertNaverMember", dto);
		// 프로필 삽입
		String[] CHO = { "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ",
				"ㅎ" };
		String[] JOONG = { "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
				"ㅡ", "ㅢ", "ㅣ" };
		String[] JONG = { "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ",
				"ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" };

		String nickname = dto.getMem_nickname();
		String nickname_separated = "";

		for (int i = 0; i < nickname.length(); i++) {
			char uniVal = nickname.charAt(i);

			// 한글일 경우만 시작해야 하기 때문에 0xAC00부터 아래의 로직을 실행한다
			if (uniVal >= 0xAC00) {
				uniVal = (char) (uniVal - 0xAC00);

				char cho = (char) (uniVal / 28 / 21);
				char joong = (char) ((uniVal) / 28 % 21);
				char jong = (char) (uniVal % 28);

				nickname_separated += CHO[cho];
				nickname_separated += JOONG[joong];
				nickname_separated += JONG[jong];
			} else {
				nickname_separated += uniVal;
			}
		}
		ProfileDTO dto2 = new ProfileDTO();
		dto2.setMem_num(dto.getMem_num());
		dto2.setProf_nickname_separated(nickname_separated);

		int res2 = sqlSession.insert("insertDefaultProfile", dto2);
		if (res > 0 && res2 > 0) {
			return 1;
		} else {
			return -1;
		}
	}
	
	// 네이버 회원가입 멤버 넘버
	public int naverMemNum() {
		return sqlSession.selectOne("naverMemNum");
	}
}
