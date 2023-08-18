package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.Board_replyDTO;
import com.ezen.FSB.dto.NoticeDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.SH_boardDTO;
import com.ezen.FSB.dto.SH_board_replyDTO;

@Service
public class AdminBoardMapper { // 커뮤니티

	@Autowired
	private SqlSession sqlSession;
	
	// 게시판 공지글 목록
		public List<NoticeDTO> listBNotice(){
			return sqlSession.selectList("adminListBNotice");
		}
		// 게시판 공지글 sort
		public List<NoticeDTO> sortBNotice(String sort){
			if(sort.equals("board")) { // 전체
				return sqlSession.selectList("adminSortBNoticeAll");
			}else if(sort.equals("free")) { // 자유
				return sqlSession.selectList("adminSortBNoticeFree");
			}else if(sort.equals("anony")) { // 익명
				return sqlSession.selectList("adminSortBNoticeAnony");
			}else if(sort.equals("sh")) { // 중고
				return sqlSession.selectList("adminSortBNoticeSH");
			}else if(sort.equals("reg_desc")) { // 등록일 최근 순
				return sqlSession.selectList("adminSortBNoticeRegDesc");
			}else { // 등록일 오래된 순
				return sqlSession.selectList("adminSortBNoticeRegAsc");
			}
		}
		// 게시판 공지글 찾기
		public List<NoticeDTO> findBNotice(java.util.Map<String, String> params){
			return sqlSession.selectList("adminFindBNotice", params);
		}
		// 자유게시판 목록
		public List<BoardDTO> listFreeBoard(java.util.Map<String, Integer> params){
			return sqlSession.selectList("adminlistFreeBoard", params);
		}
		// 익명게시판 목록
		public List<BoardDTO> listAnonyBoard(java.util.Map<String, Integer> params){
			return sqlSession.selectList("adminlistAnonyBoard", params);
		}
		// 중고게시판 목록
		public List<SH_boardDTO> listSHBoard(java.util.Map<String, Integer> params){
			return sqlSession.selectList("adminlistSHBoard", params);
		}
		// 자유, 익명 게시판 댓글 목록
		public List<Board_replyDTO> listBoardReply(int board_num){
			return sqlSession.selectList("adminListBoardReply", board_num);
		}
		// 중고 게시판 댓글 목록
		public List<SH_board_replyDTO> listBoardSHReply(int board_num){
			return sqlSession.selectList("adminListBoardSHReply", board_num);
		}
		// 자유, 익명게시판 상세보기
		public BoardDTO getBoard(int board_num) {
			return sqlSession.selectOne("adminGetBoard", board_num);
		}
		// 중고 게시판 상세보기
		public SH_boardDTO getBoardSH(int board_num) {
			return sqlSession.selectOne("adminGetBoardSH", board_num);
		}
		// 중고 게시판 댓글 신고 내역
		public List<ReportDTO> listReportBr_sh(int report_target){
			return sqlSession.selectList("adminListReportBr_sh", report_target);
		}
		// 자유, 익명 게시판 댓글 신고 내역
		public List<ReportDTO> listReportBr(int report_target){
			return sqlSession.selectList("adminListReportBr", report_target);
		}
		// 중고 게시글 신고 내역
		public List<ReportDTO> listReportBoard_sh(int report_target){
			return sqlSession.selectList("adminListReportBoard_sh", report_target);
		}
		// 자유, 익명 게시글 신고내역
		public List<ReportDTO> listReportBoard(int report_target){
			return sqlSession.selectList("adminListReportBoard", report_target);
		}
		// 중고 게시글 신고 취소 (report 에서 지우기)
		public int delReportBoard_sh(int report_target) {
			return sqlSession.delete("adminDelReportBoard_sh", report_target);
		}
		// 중고 게시글 신고 취소 (board 에서 report -> 0 )
		public int updateReportBoard_sh(int board_num) {
			return sqlSession.update("adminUpdateReportBoard_sh", board_num);
		}
		// 자유, 익명 게시글 신고 취소 (report 에서 지우기)
		public int delReportBoard(int report_target) {
			return sqlSession.delete("adminDelReportBoard", report_target);
		}
		// 자유, 익명 게시글 신고 취소 (board report -> 0)
		public int updateReportBoard(int board_num) {
			return sqlSession.update("adminUpdateReportBoard", board_num);
		}
		// 중고 게시글 댓글 신고 취소 (report 에서 지우기)
		public int delReportBr_sh(int report_target) {
			return sqlSession.delete("adminDelReportBr_sh", report_target);
		}
		// 중고 게시글 댓글 신고 취소 (board report ->0)
		public int updateReportBr_sh(int br_num) {
			return sqlSession.update("adminUpdateReportBr_sh", br_num);
		}
		// 익명, 자유 게시글 댓글 신고 취소 (report 에서 지우기)
			public int delReportBr(int report_target) {
				return sqlSession.delete("adminDelReportBr", report_target);
		}
		// 익명, 자유 게시글 댓글 신고 취소 (board report ->0)
		public int updateReportBr(int br_num) {
			return sqlSession.update("adminUpdateReportBr", br_num);
		}
		// 중고 게시글 삭제 시, 신고 처리 여부 0 ->1
		public int checkReportBoard_sh(int report_target) {
			return sqlSession.update("adminCheckReportBoard_sh", report_target);
		}
		// 익명, 자유 게시글 삭제 시, 신고 처리 여부 0 ->1
		public int checkReportBoard(int board_num) {
			return sqlSession.update("adminCheckReportBoard", board_num);
		}
		// 중고 게시판 댓글 삭제
		public int delBr_sh(int br_num) {
			return sqlSession.delete("adminDelBr_sh", br_num);
		}
		// 익명, 자유게시판 댓글 삭제
		public int delBr(int br_num) {
			return sqlSession.delete("adminDelBr", br_num);
		}
		// 중고 게시판 댓글 신고 처리 여부 0 -> 1
		public int checkReportBr_sh(int report_target) {
			return sqlSession.update("adminCheckReportBr_sh", report_target);
		}
		// 익명, 자유게시판 댓글 신고 처리 여부 0 -> 1
		public int checkReportBr(int report_target) {
			return sqlSession.update("adminCheckReportBr", report_target);
		}
		// 중고 게시판 신고 댓글 목록
		public List<SH_board_replyDTO> listBoardSHReplyReport(int board_num){
			return sqlSession.selectList("adminListBoardSHReplyReport", board_num);
		}
		// 익명 게시판 신고 댓글 목록
		public List<Board_replyDTO> listBoardReplyReport(int board_num){
			return sqlSession.selectList("adminListBoardReplyReport",board_num);
		}
		// 전체 게시글 신고내역
		public List<ReportDTO> totalListBoard(){
			return sqlSession.selectList("adminTotalListBoard");
		}
		// 전체 댓글 신고내역
		public List<ReportDTO> totalListBr(){
			return sqlSession.selectList("adminTotalListBr");
		}
		// 전체 게시글 미처리 신고내역
		public List<ReportDTO> totalListBoard2(){
			return sqlSession.selectList("adminTotalListBoard2");
		}
		// 전체 댓글 미처리 신고내역
		public List<ReportDTO> totalListBr2(){
			return sqlSession.selectList("adminTotalListBr2");
		}
		// br_num 으로 board_num 찾기 // 자유, 익명
		public int totalFindBoard(int br_num) {
			return sqlSession.selectOne("adminTotalFindBoard", br_num);
		}
		// br_num 으로 board_num 찾기 // 중고
		public int totalFindBoard_sh(int br_num) {
			return sqlSession.selectOne("adminTotalFindBoard_sh", br_num);
		}
		
		// BoardMapper.java 에서 가져온 내용
		//게시글 수 
		public int getCountBoard() {
			int res = sqlSession.selectOne("adminGetCountBoard");
			return res;
		}
		//익명 게시글 수 
		public int getCountBoard_anony() {
			int res = sqlSession.selectOne("adminGetCountBoard_anony");
			return res;
		}
		//중고게시판 게시글 수 
		public int getCountBoard_sh(String mode) {
			int res;
			if(mode.equals("all")) {
				res = sqlSession.selectOne("adminGetCountBoard_sh");
			}else {
				res = sqlSession.selectOne("adminGetCountBoard_sort",mode);
			}
				return res;
		}
		//자유 익명 게시글 삭제시 댓글 전체 밀기
		public int deleteReplyAll(int board_num) {
			int res = sqlSession.delete("adminDeleteReplyAll",board_num);
			return res;
		}
		//자유, 익명 게시글 삭제
		public int deleteBoard(int board_num) {
			int res = sqlSession.delete("adminDeleteBoard", board_num);
			return res;
				
		}
		//중고 게시글 삭제 시 해당 게시판 댓글 전체 밀기
		public int deleteReplyAll_sh(int board_num) {
			int res = sqlSession.delete("adminDeleteReplyAll_sh",board_num);
			return res;
		}
		//중고 게시글 삭제
		public int deleteBoard_sh(int board_num) {
			int res = sqlSession.delete("adminDeleteBoard_sh", board_num);
			return res;
		}
		//중고 댓글 수 
		public int getCountReply_sh(int board_num) {
			int res = sqlSession.selectOne("adminGetCountReply_sh", board_num);
			return res;
		}
		//자유, 익명 댓글 수 
		public int getCountReply(int board_num) {
			int res = sqlSession.selectOne("adminGetCountReply", board_num);
			return res;
		}
		

}
