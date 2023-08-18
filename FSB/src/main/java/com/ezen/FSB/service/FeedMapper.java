package com.ezen.FSB.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.Board_replyDTO;
import com.ezen.FSB.dto.FeedDTO;
import com.ezen.FSB.dto.FeedReplyDTO;
import com.ezen.FSB.dto.Feed_likeDTO;
import com.ezen.FSB.dto.Feed_themeDTO;
import com.ezen.FSB.dto.GameLikeDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ThemeDTO;

@Service
public class FeedMapper {

	@Autowired
	private SqlSession sqlSession;
	
	//타임라인 가져오기
	public List<FeedDTO> getTimeline(int mem_num){
		List<FeedDTO> list = sqlSession.selectList("getTimeline", mem_num);
		for(FeedDTO dto :list) {
			List<ThemeDTO> feed_theme = getFeedTheme(dto.getFeed_num());
			dto.setFeed_theme(feed_theme);
			int isLike = memLikeCheck_feed(dto.getFeed_num(), mem_num);
			dto.setIsLike(isLike);
		}
		return list;
	}
	
	//개인 타임라인 가져오기(공개계정, 공개 피드만 가져오기)
	public List<FeedDTO> getOnesTimeline_open(int mem_num){
		List<FeedDTO> list = sqlSession.selectList("getOnesTimeline_open", mem_num);
		for(FeedDTO dto :list) {
			List<ThemeDTO> feed_theme = getFeedTheme(dto.getFeed_num());
			dto.setFeed_theme(feed_theme);
			int isLike = memLikeCheck_feed(dto.getFeed_num(), mem_num);
			dto.setIsLike(isLike);
		}
		return list;
	}
	
	//개인 타임라인 가져오기(비공개계정, 모두 가져오기)
	public List<FeedDTO> getOnesTimeline_secret(int mem_num){
		List<FeedDTO> list = sqlSession.selectList("getOnesTimeline_secret", mem_num);
		for(FeedDTO dto :list) {
			List<ThemeDTO> feed_theme = getFeedTheme(dto.getFeed_num());
			dto.setFeed_theme(feed_theme);
			int isLike = memLikeCheck_feed(dto.getFeed_num(), mem_num);
			dto.setIsLike(isLike);
		}
		return list;
	}
	
	//테마별 피드 목록 불러오기
	public List<FeedDTO> getThemeFeedList(int theme_num, int mem_num){
		Hashtable<String, Object> ht = new Hashtable<>();
		ht.put("theme_num", theme_num);
		ht.put("mem_num", mem_num);
		List<FeedDTO> list = sqlSession.selectList("getThemeFeedList", ht);
		for(FeedDTO dto :list) {
			List<ThemeDTO> feed_theme = getFeedTheme(dto.getFeed_num());
			dto.setFeed_theme(feed_theme);
			int isLike = memLikeCheck_feed(dto.getFeed_num(), mem_num);
			dto.setIsLike(isLike);
		}
		return list;
	}
	
	//게임별 피드 목록 불러오기(비회원 가능)
	public List<FeedDTO> getGameFeedList(int game_num){
		List<FeedDTO> list = sqlSession.selectList("getGameFeedList", game_num);
		for(FeedDTO dto :list) {
			List<ThemeDTO> feed_theme = getFeedTheme(dto.getFeed_num());
			dto.setFeed_theme(feed_theme);
		}
		return list;
	}
	
	//피드 하나 가져오기(회원)
	public FeedDTO getFeed(int feed_num, int mem_num){
		System.out.println("getFeed의 피드번호는 "+feed_num);
		FeedDTO dto = sqlSession.selectOne("getFeed", feed_num);
		List<ThemeDTO> feed_theme = sqlSession.selectList("getFeedTheme", feed_num);
		List<FeedReplyDTO> feed_reply = sqlSession.selectList("listFeedReply", feed_num);
		//댓글 볼 수 있는지 확인
		for(FeedReplyDTO reply :feed_reply) {
			int friend_num = reply.getMem_num();
			String fr_open = reply.getFr_open();
			
			Hashtable map = new Hashtable();
			map.put("mem_num", mem_num);
			map.put("friend_num", friend_num);
			
			if(friend_num == mem_num) { //내 댓글이라면
				reply.setVisible("ok");
			}else if(fr_open.equals("open")) { //공개댓글이라면
				String follow = sqlSession.selectOne("friendFollowCheck", map);
				if(follow != null && follow.equals("block")) {
					reply.setVisible("no");
				}else {
					reply.setVisible("ok");
				}
			}else { //비공개댓글이라면
				String follow = sqlSession.selectOne("myFollowCheck", map);
				if(follow != null && follow.equals("follow")) {
					reply.setVisible("ok");
				}else {
					reply.setVisible("no");
				}
			}
		}
		//좋아요 눌렀는지 확인
		int isLike = memLikeCheck_feed(feed_num, mem_num);
		
		dto.setFeed_theme(feed_theme);
		dto.setFeed_reply(feed_reply);
		dto.setIsLike(isLike);
		return dto;
	}
	
	//피드 하나 가져오기(비회원)
	public FeedDTO getFeed(int feed_num){
		System.out.println("getFeed의 피드번호는 "+feed_num);
		FeedDTO dto = sqlSession.selectOne("getFeed", feed_num);
		List<ThemeDTO> feed_theme = sqlSession.selectList("getFeedTheme", feed_num);
		List<FeedReplyDTO> feed_reply = sqlSession.selectList("listFeedReply", feed_num);
		//댓글 볼 수 있는지 확인
		for(FeedReplyDTO reply :feed_reply) {
			String fr_open = reply.getFr_open();
			if(fr_open.equals("open")) {
				reply.setVisible("ok");
			}else {
				reply.setVisible("no");
			}
		}
		dto.setFeed_theme(feed_theme);
		dto.setFeed_reply(feed_reply);
		dto.setIsLike(0);
		return dto;
	}
	
	//게임 있는 피드 등록
	public int insertFeed(FeedDTO dto) {
		int res = sqlSession.insert("insertFeed", dto);
		return res;
	}
	
	//게임 없는 피드 등록
	public int insertFeed_noGame(FeedDTO dto) {
		int res = sqlSession.insert("insertFeed_noGame", dto);
		return res;
	}
	
	//게임 있는 피드 수정
	public int updateFeed(FeedDTO dto) {
		int res = sqlSession.update("updateFeed", dto);
		return res;
	}
	
	//게임 없는 피드 수정
	public int updateFeed_noGame(FeedDTO dto) {
		int res = sqlSession.update("updateFeed_noGame", dto);
		return res;
	}
	
	//피드 삭제
	public int deleteFeed(int feed_num) {
		int res = sqlSession.delete("deleteFeed", feed_num);
		return res;
	}
	
	//다음 feed_num 받아오기
	public int getNextFeedNum() {
		int res = sqlSession.selectOne("getNextFeedNum");
		return res;
	}
	
//------------------------------------------------------------------------------------------------------		
	//피드 테마 넣기
	public int insertFeedTheme(int feed_num, String[] list) {
		if(list !=null) {
			for(String theme :list) {
				int theme_num = Integer.parseInt(theme);
				Feed_themeDTO dto = new Feed_themeDTO();
				dto.setFeed_num(feed_num);
				dto.setTheme_num(theme_num);
				int res = sqlSession.insert("insertFeedTheme",dto);
				if(res != 1) {
					return -1;
				}
			}	
		}
		return 0; //성공하면 0, 실패하면 -1
	}

	//피드 테마 업데이트
	public int updateFeedTheme(int feed_num, String[] list) {
		int res = sqlSession.delete("deleteFeedTheme", feed_num); //일단 전부 삭제
		res = insertFeedTheme(feed_num, list);		
		return res; //성공하면 0, 실패하면 -1
	}
	
	//피드 테마 삭제
	public int deleteFeedTheme(int feed_num) {
		int res = sqlSession.delete("deleteFeedTheme", feed_num);
		return res;
	}
	
	//피드 테마 가져오기
	public List<ThemeDTO> getFeedTheme(int feed_num) {
		List<ThemeDTO> list = sqlSession.selectList("getFeedTheme", feed_num);
		return list;
	}
	
//------------------------------------------------------------------------------------------------------		
	//댓글 목록 가져오기
	public List<FeedReplyDTO> listFeedReply(int feed_num) {
		List<FeedReplyDTO> list = sqlSession.selectList("listFeedReply", feed_num);
		return list;
	}
	
	//댓글 하나 가져오기
	public FeedReplyDTO getFeedReply(int fr_num) {
		FeedReplyDTO dto = sqlSession.selectOne("getFeedReply", fr_num);
		return dto;
	}

	//피드 댓글 작성 
	public int insertFeedReply(FeedReplyDTO dto) {
		if(dto.getFr_num() == 0) {//(일반 댓글)댓글 번호가 0이면
			int getcount = feedReplyCount(dto.getFeed_num());
			System.out.println(getcount);
			if(getcount == 0) {//첫번째 댓글이라면
				dto.setFr_re_group(1);
			}else {//아니라면
				int res = maxRe_group_reply();
				System.out.println(res);
				dto.setFr_re_group(res+1);
			}
		}else {//(답글) 기존 댓글 번호가 있다면
			int res = sqlSession.selectOne("maxRe_step_reply", dto.getFr_re_group()); //해당 타래의 답글 순서 가져오기
			dto.setFr_re_step(res+1);
			dto.setFr_re_level(1);
		}
		int res = sqlSession.insert("insertFeedReply", dto);
		if(res>0) res = plus_feed_replyCount(dto.getFeed_num());
		return res;
	}
	
	//피드 댓글 수정
	public int updateFeedReply(int fr_num, String fr_content) {
		Hashtable<String, Object> ht = new Hashtable <>();
		ht.put("fr_num", fr_num);
		ht.put("fr_content", fr_content);
		int res = sqlSession.update("updateFeedReply", ht);
		return res;
	}
	
	//피드 댓글 삭제
	public int deleteFeedReply(int fr_num, int feed_num) {
		int res = sqlSession.update("deleteFeedReply", fr_num);
		if(res>0) res = minus_feed_replyCount(feed_num);
		if(res>0) res = feedReplyCount(feed_num);
		return res;
	}
	
	//댓글 수 가져오기
	public int feedReplyCount(int feed_num) {
		int res = sqlSession.selectOne("feedReplyCount", feed_num);
		return res;
	}
	public int maxRe_group_reply() {
		int res = sqlSession.selectOne("maxRe_group_reply_feed");
		return res;
	}
	public int maxRe_step_reply() {
		int res = sqlSession.selectOne("maxRe_step_reply_feed");
		return res;
	}
	
	//피드 댓글 수 +1
	public int plus_feed_replyCount(int feed_num) {
		int res = sqlSession.update("plusReplyFeed", feed_num);
		return res;
	}
	//피드 댓글 수 -1
	public int minus_feed_replyCount(int feed_num) {
		int res = sqlSession.update("minusReplyFeed", feed_num);
		return res;
	}
	
//------------------------------------------------------------------------------------------------------	
	// 좋아요를 누른 회원인지 확인
	public int memLikeCheck_feed(int feed_num, int mem_num) {
		Map<String, Integer> params = new Hashtable<>();
		params.put("feed_num", feed_num);
		params.put("mem_num", mem_num);
		int res = sqlSession.selectOne("memLikeCheck_feed", params);
		return res; //좋아하면 1 아니면 0
	}
	// 좋아요 +1
	public int addLikeFeed(int feed_num, int mem_num) {
		int res = sqlSession.update("addLikeFeed", feed_num);
		return res;
	}
	// 좋아요 -1
	public int minusLikeFeed(int feed_num, int mem_num) {
		int res = sqlSession.update("minusLikeFeed", feed_num);
		return res;
	}
	// 좋아요DTO에 추가
	public int feedLike(Feed_likeDTO dto) {
		return sqlSession.insert("feedLike", dto);
	}
	// 좋아요DTO 삭제
	public int feedLikeDelete(Map<String, Integer> map) {
		return sqlSession.delete("feedLikeDelete", map);
	}
	// 좋아요 누른 총 개수 가져오기
	public int feedLikeCount(int feed_num) {
		return sqlSession.selectOne("feedLikeCount", feed_num);
	}
	
//------------------------------------------------------------------------------------------------------		
	//신고dto 넘기기
	public int report(ReportDTO dto) {
		int res = sqlSession.insert("report", dto);
		return res; 
	}
	//피드 신고 
	public int reportFeed(int feed_num) {
		int res = sqlSession.update("reportFeed", feed_num);
		return res;
	}
	//피드 댓글 신고 
	public int reportFeedReply(int fr_num) {
		int res = sqlSession.update("reportFeedReply", fr_num);
		return res;
	}
}
