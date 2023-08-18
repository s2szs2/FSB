package com.ezen.FSB;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.FSB.dto.MemberDTO;

import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.MemberMapper;


@Controller
public class MemberController {

	@Autowired
	private LoginMapper loginMapper;
	
	@Autowired
	MemberMapper memberMapper;
	

	
	@RequestMapping("/signMember.do") //회원가입 
	public String signMember(HttpSession session, HttpServletRequest req) {
		String mode = req.getParameter("mode");
		String id = req.getParameter("email");
		String name = req.getParameter("name");
		String passwd = req.getParameter("passwd");
	
		String join;
		int count = 0;
		if(mode.equals("1")) {
			join = "1";		
			mode = "일반";
		}else {join ="2"; mode = "사업자";
		}
		
		//랜덤 닉네임 생성
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		Random random = new Random();

		String nickName = random.ints(leftLimit, rightLimit + 1)
		      .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		      .limit(targetStringLength)
		      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		      .toString();

		
		
		MemberDTO dto = new MemberDTO();
		dto.setMem_id(id);
		dto.setMem_mode(mode);
		dto.setMem_name(name);
		dto.setMem_passwd(passwd);
		dto.setMem_join(join);
		dto.setMem_nickname(nickName);
		dto.setMem_count(count);
		//뱃지설정!!
		dto.setBadge_king("0");
		dto.setBadge_write("0");
		dto.setBadge_1004("0");
		dto.setBadge_good("0");
		dto.setBadge_rich("0");
		//뱃지2
		dto.setBadge_king_2("0");
		dto.setBadge_write_2("0");
		dto.setBadge_1004_2("0");
		dto.setBadge_good_2("0");
		dto.setBadge_rich_2("0");
		//태그 설정
		dto.setTag_1("0");
		dto.setTag_2("0");
		dto.setTag_3("0");
		dto.setTag_4("0");
		dto.setTag_5("0");
		dto.setTag_6("0");
		dto.setTag_7("0");
		dto.setTag_8("0");
		
		
		
		int res = memberMapper.insertMember2(dto);
		
		
	
		req.setAttribute("mode", mode);
		req.setAttribute("id", id);
		req.setAttribute("name", name);
		req.setAttribute("passwd", passwd);
	return "member/agree";
	}
	
	
	@RequestMapping("/signOk.do") //가입하기 누르면-> 개인정보동의서 뜨게
	public String agree(HttpSession session, HttpServletRequest req) {
		String id = req.getParameter("id");
		
		MemberDTO dto = loginMapper.findMember(id);
		//1.이용약관동의   2.개인정보수집   3.위치기반   4.이벤트
		
		String chkAll = req.getParameter("chkAll");
		String chk = req.getParameter("chk");
		String chk2 = req.getParameter("chk2");
		String chk3 = req.getParameter("chk3");
		String chk4 = req.getParameter("chk4");
		
		
		
		if(chk!=null&&chk!=null&&chk3!=null&&chk4!=null) { //1,2,3,4 전부동의	
			dto.setMem_sel_agree("1,2,3,4"); 
		}else if(chk!=null&&chk!=null&&chk3!=null&&chk4==null) { //1,2,3 동의
			dto.setMem_sel_agree("1,2,3");
			
		}else if(chk!=null&&chk!=null&&chk3==null&&chk4!=null) { //1,2,4 동의
			dto.setMem_sel_agree("1,2,4");
			
		}else if(chk!=null&&chk!=null&&chk3==null&&chk4==null) { //1,2만동의
			dto.setMem_sel_agree("1,2");
		}else if(chkAll!=null) { // 전부동의 체크
			dto.setMem_sel_agree("1,2,3,4");
		}
		
		int res = memberMapper.agreeUpdate(dto);
		String msg = "가입완료.";
		String url =  "login.do";
	
	req.setAttribute("msg", msg);
	req.setAttribute("url", url);
	return "message";
	}
	
	
	@RequestMapping("/duplication.do") //중복확인
	public String duplication(HttpSession session, HttpServletRequest req) {
		String id = req.getParameter("email");
		
		int res;
		MemberDTO dto = loginMapper.findMember(id);
		if(dto==null) {
			res = 0;
		} else res=1;
		
		
		req.setAttribute("result", res);
		req.setAttribute("id", id);
	return "member/dbCheckId";
	}
	
	
	
}
