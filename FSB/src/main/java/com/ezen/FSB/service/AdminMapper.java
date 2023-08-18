package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.Board_replyDTO;
import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.NoticeDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ReviewDTO;
import com.ezen.FSB.dto.SH_boardDTO;
import com.ezen.FSB.dto.SH_board_replyDTO;
import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;
import com.ezen.FSB.dto.TagDTO;
import com.ezen.FSB.dto.ThemeDTO;

@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;

	// HOME
	public int homeGameReport() {
		return sqlSession.selectOne("adminHomeGameReport");
	}
	
	// 관리자 작성글
	
	// 관리자 작성글 등록
	public int insertNotice(NoticeDTO dto) {
		return sqlSession.insert("adminInsertNotice", dto);
	}
	// 관리자 작성글 목록
	public List<NoticeDTO> listNotice(){
		return sqlSession.selectList("adminListNotice");
	}
	// 관리자 작성글 정렬
	public List<NoticeDTO> sortNotice(String n_mode){ // 공지사항, 자주묻는 질문만 보기
		return sqlSession.selectList("adminListNoticeSort1", n_mode);
	}
	public List<NoticeDTO> sortNotice2(){ // 작성일 오래된 순
		return sqlSession.selectList("adminListNoticeSort2");
	}
	public List<NoticeDTO> sortNotice3(){ // 작성일 최근 순
		return sqlSession.selectList("adminListNoticeSort3");
	}
	// 관리자 작성글 찾기
	public List<NoticeDTO> findNotice(java.util.Map<String, String> params){
		return sqlSession.selectList("adminFindNotice", params);
	}
	// 관리자 작성글 삭제
	public int deleteNotice(int n_num) {
		return sqlSession.delete("adminDeleteNotice", n_num);
	}
	// 관리자 작성글 꺼내기
	public NoticeDTO getNotice(int n_num) {
		return sqlSession.selectOne("adminGetNotice", n_num);
	}
	// 관리자 작성글 수정
	public int updateNotice(NoticeDTO dto) {
		return sqlSession.update("adminUpdateNotice", dto);
	}
	
	
}
	
