package com.ezen.FSB.service;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.ezen.FSB.dto.DontgoDTO;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;

@Service
public class MemberMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
	 public int agreeUpdate(MemberDTO dto) { //동의서 
		    return sqlSession.update("agreeUpdate", dto);
	 }
	 
	 //일반회원가입 
	 public int insertMember2(MemberDTO dto) {//오토커밋됨 스프링 이용하면 
		 // f_member_seq.nextval 를 한 mem_num 을 가져오기
		 int mem_num = sqlSession.selectOne("basicMemberNextNum");
		 // MemberDTO insert
		 dto.setMem_num(mem_num);
		 int res2 = sqlSession.insert("insertMember2", dto); // 루트에 세션등록해놨으니까 . sql문도 안쓰고 클로즈~ 뭐 어쩌구도 안씀
		 
		 // 프로필 생성 (피드를 위한)
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
			dto2.setMem_num(mem_num);
			dto2.setProf_nickname_separated(nickname_separated);

			
			int res3 = sqlSession.insert("insertDefaultProfile", dto2);
			
			// 포인트 
			String point_type = "+";
			String point_content = "신규가입";
			int point_amount = 3000;
			int point_total = 3000;
			ShopPointHistoryDTO dto3 = new ShopPointHistoryDTO();
			dto3.setMem_num(mem_num);
			dto3.setPoint_type(point_type);
			dto3.setPoint_content(point_content);
			dto3.setPoint_amount(point_amount);
			dto3.setPoint_total(point_total);
			int res4 = sqlSession.insert("memberPoint",dto3);
			if(res4>0) {
				System.out.println("포인트 신규 등록 성공");
			}else {
				System.out.println("포인트 신규 등록 실패");			
			}
			
			if(res2>0 && res3>0 && res4>0) {
				return 1;
			}else {
				return -1;
			}
		}
	 
	 //카카오 회원가입
	 public int insertKakaoMember(MemberDTO dto) {//오토커밋됨 스프링 이용하면
			int res =  sqlSession.insert("insertKakaoMember", dto); // 루트에 세션등록해놨으니까 . sql문도 안쓰고 클로즈~ 뭐 어쩌구도 안씀
			
		// 프로필 생성 (피드를 위한)
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

		if (res2 > 0 && res > 0) {
			return 1;
		} else {
			return -1;
		}
	}
	 
	 // 카카오 멤버 넘버
	 public int kakaoMemNum() {
		 return sqlSession.selectOne("kakaoMemNum");
	 }
	 
	// 닉네임 변경 0719 추가
	 public int updateNicknameProfile(ProfileDTO dto) {
		return sqlSession.update("updateNicknameProfile", dto);
	}
			 
	//회원탈퇴 이유 인서트
	 public int reason(DontgoDTO dto) {//오토커밋됨 스프링 이용하면
		return sqlSession.insert("reason", dto); // 루트에 세션등록해놨으니까 . sql문도 안쓰고 클로즈~ 뭐 어쩌구도 안씀
	}
			 
	 public int deleteMem(String id) { //탈퇴시 회원 삭제 
		return sqlSession.delete("deleteMem", id);
	}
			 
			 
}
