package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.DontgoDTO;
import com.ezen.FSB.dto.Feed_themeDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;

@Service
public class AdminMemberMapper { // 회원

	@Autowired
	private SqlSession sqlSession;
	
	// 일반 회원 목록
	public List<MemberDTO> listMember() {
		return sqlSession.selectList("adminListMember");
	}

	// 회원 등록
	public int insertMember(MemberDTO dto) {
		// 키 받기
		int mem_num = sqlSession.selectOne("adminNextMemNum");
		// 멤버 삽입
		dto.setMem_num(mem_num);
		int res = sqlSession.insert("adminInsertMember", dto);
		if (res <= 0)
			return -1;

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
		dto2.setMem_num(mem_num);
		dto2.setProf_nickname_separated(nickname_separated);

		
		res = sqlSession.insert("insertDefaultProfile", dto2);
		
		// 비즈니스 회원인 경우, 비즈니스 프로필 생성
		if(dto.getMem_mode().equals("사업자")) {
			int res5 = sqlSession.insert("adminInsertBProfile", mem_num);
			if(res5>0) {
				//tem.out.println("비즈니스프로필 생성 성공");
			}else {
				//tem.out.println("비즈니스프로필 생성 실패");
			}
		}
		// 포인트 
		String point_type = "+";
		String point_content = "신규가입";
		int point_amount = 3000;
		int point_total = 3000;
		ShopPointHistoryDTO dto3 = new ShopPointHistoryDTO();
		dto3.setMem_num(dto.getMem_num());
		dto3.setPoint_type(point_type);
		dto3.setPoint_content(point_content);
		dto3.setPoint_amount(point_amount);
		dto3.setPoint_total(point_total);
		int res3 = sqlSession.insert("memberPoint",dto3);
		if(res3>0) {
			//tem.out.println("포인트 신규 등록 성공");
		}else {
			//tem.out.println("포인트 신규 등록 실패");			
		}
		return res; // 멤버등록 실패시 -1, 프로필만 실패시 0, 둘 다 성공시 1 반환
	}

	// 일반 회원 상세보기
	public MemberDTO getMember(int mem_num) {
		return sqlSession.selectOne("adminGetMember", mem_num);
	}

	// 일반 회원 찾기
	public List<MemberDTO> findMember(java.util.Map<String, String> params) {
		return sqlSession.selectList("adminFindMember", params);
	}

	// 일반 회원 삭제
	public int deleteMember(int mem_num) {
		return sqlSession.delete("adminDeleteMember", mem_num);
	}

	// 일반 회원 수정
	public int updateMemberPasswd(int mem_num) {
		return sqlSession.update("adminUpdateMemberPasswd", mem_num);
	}

	public int updateMemberNickname(MemberDTO dto) {
		return sqlSession.update("adminUpdateMemberNickname", dto);
	}

	public int updateMemberImg(int mem_num) {
		return sqlSession.update("adminUpdateMemberImg", mem_num);
	}

	public int updateMemberReport(int mem_num) {
		return sqlSession.update("adminUpdateMemberReport", mem_num);
	}

	public int updateMemberMsg(int mem_num) {
		return sqlSession.update("adminUpdateMemberMsg", mem_num);
	}
	
	// 사업자 회원 목록
	public List<MemberDTO> listMemberB(){
		return sqlSession.selectList("adminListMemberB");
	}
	// 사업자 회원 찾기
	public List<MemberDTO> findMemberB(java.util.Map<String, String> params){
		return sqlSession.selectList("adminFindMemberB", params);
	}
	// 사업자 가입신청 내역
	public List<MemberDTO> joinListMember(){
		return sqlSession.selectList("adminJoinListMember");
	}
	// 사업자 가입신청 승인
	public int joinOkMember(int mem_num) {
		return sqlSession.update("adminJoinOkMember", mem_num);
	}
	// 사업자 가입 승인과 동시에, 비즈니스프로필 생성
	public int insertBProfile(int mem_num) {
		return sqlSession.insert("adminInsertBProfile", mem_num);
	}
	// 비즈니스 프로필 꺼내기
	public BusinessProfileDTO getBProfile(int mem_num) {
		return sqlSession.selectOne("adminGetBProfile", mem_num);
	}
	// 비즈니스 프로필 수정
	public int updateBp(String mode, int bp_num) {
		int res = 0;
		if(mode.equals("info")) {
			res = sqlSession.update("adminUpdateBPInfo", bp_num);
		}else if(mode.equals("location")) {
			res = sqlSession.update("adminUpdateBPLocation", bp_num);
		}else if(mode.equals("store")) {
			res = sqlSession.update("adminUpdateBPStore", bp_num);
		}else {
			res = sqlSession.update("adminUpdateBPTel", bp_num);
		}
		return res;
	}
	// 비즈니스 프로필 삭제
	public int deleteBp(int mem_num) {
		return sqlSession.delete("adminDeleteBp", mem_num);
	}
	// 회원 신고 내역
	public List<ReportDTO> listReportMember(String mode){
		if(mode.equals("all")) { // 전체
			return sqlSession.selectList("adminListReportMember");
		}else { // 미처리 신고 내역
			return sqlSession.selectList("adminSortReportMember");
		}
	}
	// 회원 신고 내역 삭제
	public int delReportMember(ReportDTO dto) {
		return sqlSession.delete("adminDelReportMember", dto);
	}
	// 회원 신고 횟수 차감
	public int minusReportMember(int mem_num) {
		return sqlSession.update("adminMinusReportMember", mem_num);
	}
	// 회원 신고 처리 여부 0 ->1
	public int checkReportMember(int report_target) {
		return sqlSession.update("adminCheckReportMember", report_target);
	}
	// 해당 회원의 신고 내역
	public List<ReportDTO> getMemberReportList(int report_target){
		return sqlSession.selectList("adminGetReportMember", report_target);
	}
	// 회원 프로필 수정
	public int updateProfMember(String mode, int mem_num) {
		if(mode.equals("prof_img")) {
			return sqlSession.update("adminUpdateProfMemberImg", mem_num);
		}else {
			return sqlSession.update("adminUpdateProfMemberMsg", mem_num);
		}
	}
	// 회원 프로필 꺼내기
	public ProfileDTO getProf(int mem_num) {
		return sqlSession.selectOne("adminGetProfMember", mem_num);
	}
	// 피드 신고 내역
	public List<ReportDTO> listFeedReport(String mode){
		if(mode.equals("all")) { // 전체 내역
			return sqlSession.selectList("adminReportListFeed");
		}else { // 미처리 내역
			return sqlSession.selectList("adminReportListFeedCheck");
		}
	}
	// 신고 꺼내기
	public ReportDTO getReport(int report_num) {
		return sqlSession.selectOne("getReport", report_num);
	}
	// 해당 피드의 신고 내역
	public List<ReportDTO> getFeedReportList(String view, int report_target){
		if(view.equals("피드")) { // 피드 신고 내역
			return sqlSession.selectList("adminGetFeedReport", report_target);
		}else { // 피드 댓글 신고 내역
			return sqlSession.selectList("adminGetFeedReplyReport", report_target);
		}
	}
	// 해당 피드의 신고 내역 지우기
	public int feedReportDel(String view, int report_target) {
		if(view.equals("피드")) {
			return sqlSession.delete("adminFeedReportDel",report_target);
		}else {
			return sqlSession.delete("adminFeedReplyReportDel", report_target);
		}
	}
	// 해당 피드의 신고 report 0으로 수정
	public int feedReportUpdate(int feed_num) {
		return sqlSession.update("adminFeedReport0", feed_num);
	}
	// 해당 피드 댓글의 신고 report 0 으로 수정
	public int feedReplyReportUpdate(int fr_num) {
		return sqlSession.update("adminFeedReplyReport0", fr_num);
	}
	// 해당 피드 삭제로, 신고 처리 여부 변경 0 -> 1
	public int feedReportCheckUpdate(String view, int report_target) {
		if(view.equals("피드")) {
			return sqlSession.update("adminFeedReportCheck", report_target);
		}else {
			return sqlSession.update("adminFeedReplyReportCheck", report_target);
		}
	}
	// 해당 피드의 피드 태그 목록
	public List<Feed_themeDTO> listGetFeedTheme(int feed_num){
		return sqlSession.selectList("adminGetFeedThemeList", feed_num);
	}
	// LoginMapper 내용
	public MemberDTO findMember(String id){ // 회원 찾기
        return sqlSession.selectOne("adminFindGetMember",id);
     }
	// 탈퇴 내역
	public List<DontgoDTO> listMemberBye(){
		return sqlSession.selectList("adminMemberBye");
	}
	// fr_num 으로 feed_num 꺼내기
	public int getFeedReply(int fr_num) {
		return sqlSession.selectOne("adminGetFeedReply", fr_num);
	}
	// fr_num 삭제
	public int feedReplyDel(int fr_num) {
		return sqlSession.delete("adminFeedReplyDel", fr_num);
	}
	// 전체 회원 목록
		public List<MemberDTO> totalListMember(){
			return sqlSession.selectList("adminTotalMemberList");
		}
} 
