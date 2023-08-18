package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.AlarmDTO;


@Service
public class AlarmMapper {
	
	
	@Autowired
	private SqlSession sqlSession;
	
	//보드 알람 인서트
	 public int addBoardAlarm(AlarmDTO dto) {//오토커밋됨 스프링 이용하면
			return sqlSession.insert("addBoardAlarm", dto); // 루트에 세션등록해놨으니까 . sql문도 안쓰고 클로즈~ 뭐 어쩌구도 안씀
		}
	 
		// 멤버별 보드게임 알람 리스트
		public List<AlarmDTO> boardAlarmList(int mem_num) {
			return sqlSession.selectList("boardAlarmList", mem_num);
		}
		
		//<!-- 댓글번호로 게시글 번호 찾기 -->
		public int replyBoardNum(int num){ 
	        return sqlSession.selectOne("replyBoardNum", num);
	     }
		
		
		// 글번호로 작성자  번호 찾기
		public int BoardNum(int num){ 
	        return sqlSession.selectOne("BoardNum", num);
	     }
		
		//글번호로 제목 찾기
		public String BoardTitle(int num){ 
	        return sqlSession.selectOne("BoardTitle", num);
	     }
		
		// 중고게시판  글번호로 작성자  번호 찾기
		public int shBoardNum(int num){ 
	        return sqlSession.selectOne("shBoardNum", num);
	     }
		
		//중고게시판 글번호로 제목 찾기
		public String shBoardTitle(int num){ 
	        return sqlSession.selectOne("shBoardTitle", num);
	     }
		
		
		
		//댓글번호로 작성자  번호 찾기 
		public int BoardNumReply(int num){ 
	        return sqlSession.selectOne("BoardNumReply", num);
	     }
		
		// 댓글번호로 글 번호 찾기 
		public int BoardTitleReply(int num){ 
	        return sqlSession.selectOne("BoardTitleReply", num);
	     }
		
		//댓글 번호로 작성자 번호 찾기 (중고)
		public int shBoardNumReply(int num){ 
	        return sqlSession.selectOne("shBoardNumReply", num);
	     }
		
		//댓글번호로 글 번호 찾기 (중고) 
		public int shBoardTitleReply(int num){ 
	        return sqlSession.selectOne("shBoardTitleReply", num);
	     }
		
		// 알람 삭제 
		 public int delAlarm(int num) {
				return sqlSession.delete("delAlarm", num);
			}
		 
		 public int readAlarm(int num) {
			    return sqlSession.update("readAlarm", num);
		 }
		 
		// 멤버별 보드게임 알람 리스트
			public List<AlarmDTO> boardunReadAlarmList(int mem_num) {
				return sqlSession.selectList("boardunReadAlarmList", mem_num);
			}
}
