package com.ezen.FSB.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.ProfileDTO;

@Service
public class MapMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<BusinessProfileDTO> locationList() {
		return sqlSession.selectList("locationList");
	}
	public List<BusinessProfileDTO> findPlace(String searchString) {
		return sqlSession.selectList("findPlace", searchString);
	}
	public BusinessProfileDTO getLoca(int bp_num) {
		return sqlSession.selectOne("getLoca", bp_num);
	}
	public ProfileDTO getBprof(int mem_num) {
		return sqlSession.selectOne("getBprof",mem_num);
	}
}
