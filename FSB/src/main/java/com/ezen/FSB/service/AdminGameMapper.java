package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ReviewDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.TagDTO;
import com.ezen.FSB.dto.ThemeDTO;

@Service
public class AdminGameMapper { // 보드게임

	@Autowired
	private SqlSession sqlSession;
	
	// 보드게임 목록
		public List<GameDTO> listGame(){
			return sqlSession.selectList("adminListGame");
		}
		// 보드게임 등록
		public int insertGame(GameDTO dto) {
			return sqlSession.insert("adminInsertGame", dto);
		}
		// 보드게임 태그 등록
		public int maxGameNum() { // f_game_seq.nextval
			return sqlSession.selectOne("adminMaxGameNum");
		}
		public int insertGameTag(TagDTO dto) {
			return sqlSession.insert("adminInsertGameTag", dto);
		}
		// 보드게임 테마 목록
		public List<ThemeDTO> listTheme(){
			return sqlSession.selectList("adminThemeList");
		}
		// 보드게임 테마 최대 num
		public int maxThemeNum() {
			return sqlSession.selectOne("adminMaxThemeNum");
		}
		// 보드게임 테마로 게임 목록 가져오기
		public List<GameDTO> findThemeGame(int theme_num){
			return sqlSession.selectList("adminFindThemeGame", theme_num);
		}
		// 보드게임 테마 정보 가져오기
		public ThemeDTO getTheme(int theme_num) {
			return sqlSession.selectOne("adminGetTheme", theme_num);
		}
		
		// 보드게임 상세보기
		public GameDTO getGame(int game_num) {
			return sqlSession.selectOne("adminGetGame", game_num);
		}
		public List<TagDTO> getGameTagList(int game_num){
			return sqlSession.selectList("adminGetGameTagList", game_num);
		}
		public List<ReviewDTO> getGameReview(int game_num){
			return sqlSession.selectList("adminGetGameReview", game_num);
		}
		public List<ReviewDTO> getGameReviewReport(int game_num){
			return sqlSession.selectList("adminGetGameReviewReport", game_num);
		}
		// 보드게임 한줄평 리뷰 수, 별점
		public int getGameReviewCount(int game_num) {
			return sqlSession.selectOne("adminGetGameReviewCount", game_num);
		}
		public int getGameReviewStar(int game_num) {
			return sqlSession.selectOne("adminGetGameReviewStar", game_num);
		}
		// 보드게임 한줄평 삭제
		public int deleteGameReview(int review_num) {
			return sqlSession.delete("adminDeleteGameReview", review_num);
		}
		// 보드게임 삭제 시, 한줄평 삭제
		public int deleteGameReview2(int game_num) {
			return sqlSession.delete("adminDeleteGameReview2", game_num);
		}
		// 보드게임 한줄평 신고 내역
		public List<ReportDTO> listReviewReport(){
			return sqlSession.selectList("adminListReviewReport");
		}
		// 보드게임 한줄평 신고 내역 상세보기
		public List<ReportDTO> reportListGameReview(int report_target){
			return sqlSession.selectList("adminReportListGameReview", report_target);
		}
		// 보드게임 한줄평 신고 내역 정렬
//		public List<ReviewDTO> listReviewReport1(){ // game_num asc
//			return sqlSession.selectList("adminListReviewReport1");
//		}
//		public List<ReviewDTO> listReviewReport2(){ // game_num desc
//			return sqlSession.selectList("adminListReviewReport2");
//		}
		public List<ReportDTO> listReviewReport3(){ // report_regdate asc
			return sqlSession.selectList("adminListReviewReport3");
		}
		public List<ReportDTO> listReviewReport4(){ // report_regdate desc
			return sqlSession.selectList("adminListReviewReport4");
		}
		// 보드게임 한줄평 신고 내역 -> 한줄평 상세보기
		public int reportReview_view(int review_num) {
			return sqlSession.selectOne("adminReportReview_view", review_num);
		}
		// 보드게임 한줄평 신고 내역 -> 미처리 신고내역만 보기
		public List<ReportDTO> listReviewReport2(){
			return sqlSession.selectList("adminListReviewReport2");
		}
		// 보드게임 한줄평 신고 내역 찾기
		public List<ReviewDTO> findReviewReport(java.util.Map<String, String> params){
			return sqlSession.selectList("adminFindReviewReport", params);
		}
		// 보드게임 한줄평 신고 취소 처리
		public int updateReviewReport(int review_num) {
			return sqlSession.update("adminUpdateReviewReport", review_num);
		}
		// 보드게임 한줄평 신고 취소 시, reportDTO 지우기
		public int delGameReviewReport(int report_target) {
			return sqlSession.delete("adminDelReportGameReview", report_target);
		}
		// 보드게임 한줄평 삭제 시, report 처리여부 0 -> 1
		public int checkGameReviewReport(int report_target) {
			return sqlSession.update("adminCheckGameReviewReport", report_target);
		}
		
		// 보드게임 찾기
		public List<GameDTO> findGame(java.util.Map<String, String> params){
			return sqlSession.selectList("adminFindGame", params);
		}
		// 보드게임 삭제
		public int deleteGame(int game_num) {
			return sqlSession.delete("adminDeleteGame", game_num);
		}
		// 보드게임 수정
		public int updateGame(GameDTO dto) {
			return sqlSession.update("adminUpdateGame", dto);
		}
		// 보드게임 수정 시 해당 태그 모두 삭제
		public int deleteGameTag(int game_num) {
			return sqlSession.delete("adminDeleteGameTag", game_num);
		}
		// 테마 수정
		public int updateTheme(ThemeDTO dto) {
			return sqlSession.update("adminUpdateTheme", dto);
		}
		// 테마 등록
		public int insertTheme(String theme_name) {
			return sqlSession.insert("adminInsertTheme", theme_name);
		}
		// 테마 삭제
		public int deleteTheme(int theme_num) {
			return sqlSession.delete("adminDeleteTheme", theme_num);
		}
		// 해당 테마를 가지고 있는 tagDTO 확인
		public List<TagDTO> listThemeTag(int theme_num){
			return sqlSession.selectList("adminListThemeTag", theme_num);
		}
		// 해당 테마를 가지고 있던 tagDTO 삭제
		public int deleteThemeTag(int theme_num) {
			return sqlSession.delete("adminDeleteThemeTag", theme_num);
		}
		// 보드게임 삭제 시, 등록된 상품이 있는지 확인하기
		public ShopProductDTO getProdGame(int game_num) {
			return sqlSession.selectOne("adminGetProdGame", game_num);
		}
		// 게임 좋아요 수
		public int getGameLike(int game_num) {
			return sqlSession.selectOne("adminGetGameLike", game_num);
		}
	
}
