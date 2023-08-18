package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.MemberDTO;


@Service
public class LoginMapper {
	
	
	@Autowired
	private SqlSession sqlSession;
	
	public MemberDTO findMember(String id){ // 회원 찾기
        return sqlSession.selectOne("findMember",id);
     }
	
	public MemberDTO findId(String name){ // 이름으로 찾기
        return sqlSession.selectOne("findId", name);
     }
	
	public MemberDTO findIdnum(String name){ // 넘버로 찾기
        return sqlSession.selectOne("findIdnum", name);
     }
	
	public MemberDTO findNick(String name){ // 닉네임 중복 찾기
        return sqlSession.selectOne("findNick", name);
     }
	
	
	public List<MemberDTO> idMember(String id){ // 아이디 일치 확인
        return sqlSession.selectList("idMember",id);
     }
	
	public String loginMember(String id){ // 비밀번호 일치 여부 확인
        return sqlSession.selectOne("loginMember", id);
     }
	
	public String joinMember(String id){ // 승인 여부 확인(개인/사업자)
        return sqlSession.selectOne("joinMember", id);
     }
	
	 public int changePw(MemberDTO dto) { //비밀번호 찾기, 비밀번호 변경시 
		    return sqlSession.update("changePw", dto);
	 }
	 
	 
	 public int plusCount(MemberDTO dto) { //로그인시 자동 방문횟수+1
		    return sqlSession.update("plusCount", dto);
	 }
	 
	
	 
	 public int imageUpdate(MemberDTO dto) {
		    return sqlSession.update("imageUpdate", dto);
	 }
	 
}
