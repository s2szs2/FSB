package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.BusinessCouponUserDTO;

import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.MemberDTO;


@Service
public class MypageMapper {
	
	
	@Autowired
	private SqlSession sqlSession;
	
	
	 
	 public int changeNick(MemberDTO dto) { //닉네임 변경 
		    return sqlSession.update("changeNick", dto);
	 }
	 
	 public int changePhone(MemberDTO dto) { //핸드폰번호 설정&변경 
		    return sqlSession.update("changePhone", dto);
	 }
	 
	 public int changeMsg(MemberDTO dto) { //상태메세지 변경 
		    return sqlSession.update("changeMsg", dto);
	 }
	 
	 public int changeTag(MemberDTO dto) { //해쉬태그 변경 
		    return sqlSession.update("changeTag", dto);
	 }
	 
	 public int changeBadge(MemberDTO dto) { // 뱃지 설정 변경
		    return sqlSession.update("changeBadge", dto);
	 }
	 
	 public int changeBadgeOk(MemberDTO dto) { //뱃지 설정 변경 
		    return sqlSession.update("changeBadgeOk", dto);
	 }
	 
	 //배찌
	 public int memCountLike(int num) { // 좋아요 갯수 카운트 
			int res = sqlSession.selectOne("memCountLike", num);
			return res;
		}
	 
	 public int memCountShop(int num) { // 구매목록 갯수 카운트 
			int res = sqlSession.selectOne("memCountShop", num);
			return res;
		}
	 
	 
	 //내글목록 
	 
		public int memCountBoard(int num) { // 내 글 목록 카운트 
			int res = sqlSession.selectOne("memCountBoard", num);
			return res;
		}
		
		public int memCountShBoard(int num) { // 내글목록 카운트(중고게시판) 
			int res = sqlSession.selectOne("memCountShBoard", num);
			return res;
		}
		
		public int memCountFreeBoard(int num) { //내글 목록 카운트(자유게시판) 
			int res = sqlSession.selectOne("memCountFreeBoard", num);
			return res;
		}
		
		public int memCountSecretBoard(int num) { //내글 목록 카운트(익명게시판) 
			int res = sqlSession.selectOne("memCountSecretBoard", num);
			return res;
		}
		
		public int memCountReply(int num) { //내댓글 목록 카운트 
			int res = sqlSession.selectOne("memCountReply", num);
			return res;
		}
		
		public  List<BoardDTO> MemfreelistBoard(java.util.Map<String,Integer> params){ // 자유게시판, 내가 쓴 댓글이 있는 모든 글의 작성자? 
			List<BoardDTO> list = sqlSession.selectList("MemfreelistBoard", params);
			
			return list;
			}
		
		public  List<BoardDTO> MemShlistBoard(java.util.Map<String,Integer> params){ // 중고 게시판, 내가 쓴 댓글이 있는 모든 글 작성자?
			List<BoardDTO> list = sqlSession.selectList("MemShlistBoard", params);
			
			return list;
			}
		
		public  List<BoardDTO> MemSecretlistBoard(java.util.Map<String,Integer> params){ // 익명게시판, 내가 쓴 댓글이 있는 모든 글의 작성자?
			List<BoardDTO> list = sqlSession.selectList("MemSecretlistBoard", params);
			
			return list;
			}
		
		public  List<BoardDTO> freeReply(java.util.Map<String,Integer> params){ // 자유게시판, 내가 쓴 댓글이 있는 모든 글
			List<BoardDTO> list = sqlSession.selectList("freeReply", params);
			
			return list;
			}
		
		public  List<BoardDTO> secretReply(java.util.Map<String,Integer> params){ // 익명게시판, 내가 쓴 댓글이 있는 모든 글
			List<BoardDTO> list = sqlSession.selectList("secretReply", params);
			
			return list;
			}
		
		
		public  List<BoardDTO> shReply(java.util.Map<String,Integer> params){ // 중고 게시판, 내가 쓴 댓글이 있는 모든 글
			List<BoardDTO> list = sqlSession.selectList("shReply", params);
			
			return list;
			}
		
		
		// 멤버 별 좋아요 누른 보드게임 목록
		public List<GameDTO> myPageGameLikeList(int mem_num) {
			return sqlSession.selectList("myPageGameLikeList", mem_num);
		}
					
		// 멤버 별 좋아요 누른 보드게임 목록
		public List<BusinessCouponUserDTO> myPageCouponList(int mem_num) {
			return sqlSession.selectList("myPageCouponList", mem_num);
		}
	 
		//쿠 폰 삭제
		 public int delCoupon(int num) {
			return sqlSession.delete("delCoupon", num);
		}
					 
		//자동 삭제 기한에 따라
		public int expireBcouponUser() {
			return sqlSession.delete("expireBcouponUser");
		}
						
		
	 
}
