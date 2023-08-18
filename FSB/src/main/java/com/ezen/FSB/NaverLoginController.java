package com.ezen.FSB;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.AlarmDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.service.AlarmMapper;
import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.NaverLoginMapper;
import com.ezen.FSB.service.ShopMyPageMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class NaverLoginController {
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Autowired
	private NaverLoginMapper naverLoginMapper;
	
	@Autowired
	private ShopMyPageMapper shopMyPageMapper;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	@Autowired
	private LoginMapper loginMapper;
	
	 // 네이버 로그인 성공 시 
	 @SuppressWarnings("null")
	 @RequestMapping(value = "naver_login_ok", method = { RequestMethod.GET, RequestMethod.POST })
	 public String callback(HttpServletRequest req, Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		 OAuth2AccessToken oauthToken;
	     oauthToken = naverLoginBO.getAccessToken(session, code, state);
	 
	     // 1. 로그인 사용자 정보를 읽어온다.
	     apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
	      
	      /** apiResult json 구조
	      {"resultcode":"00",
	       "message":"success",
	       "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
	      **/
	      
	      // 2. String형식인 apiResult를 json형태로 바꿈
	      JSONParser parser = new JSONParser();
	      Object obj = parser.parse(apiResult);
	      JSONObject jsonObj = (JSONObject) obj;
	      
	      // 3. 데이터 파싱 
	      // Top레벨 단계 _response 파싱
	      JSONObject response_obj = (JSONObject)jsonObj.get("response");
	      // response의 nickname값 파싱
	      String name = (String)response_obj.get("name");
	      String nickname = (String)response_obj.get("nickname");
	      String email = (String)response_obj.get("email");
	      String mobile = (String)response_obj.get("mobile");
	      String hp[] = mobile.split("-");

	      // 이메일이 처음 로그인하는 이메일이면 네이버로 회원가입 하기
	      MemberDTO id_check = loginMapper.findMember(email);
	      MemberDTO dto = new MemberDTO();
	      if(id_check == null) { // 회원 가입 
	         dto.setMem_id(email);
	         dto.setMem_name(name);
	         dto.setMem_nickname(nickname);
	         dto.setMem_mode("일반");
	         dto.setMem_join("1");
	         dto.setMem_hp1(hp[0]);
	         dto.setMem_hp2(hp[1]);
	         dto.setMem_hp3(hp[2]);
	         
	         // 네이버 회원가입 회원 번호
	         int res2 = naverLoginMapper.naverMemNum();
	         dto.setMem_num(res2);
	         
	         // 회원가입
	         int res = naverLoginMapper.insertNaverMember(dto);
	         session.setAttribute("login_mem", dto);
	         req.setAttribute("msg", dto.getMem_nickname() + " 님, 로그인 되었습니다.");

	         // 리뷰 테이블 초기화 작업(회원가입 시 주는 포인트)
	         if (res > 0) {
	            String point_type = "+";
	            String point_content = "신규가입";
	            int point_amount = 3000;
	            int point_total = 3000;
	            ShopPointHistoryDTO dto2 = new ShopPointHistoryDTO();
	            dto2.setMem_num(dto.getMem_num());
	            dto2.setPoint_type(point_type);
	            dto2.setPoint_content(point_content);
	            dto2.setPoint_amount(point_amount);
	            dto2.setPoint_total(point_total);
	            shopMyPageMapper.memberPoint(dto2);
	            
	         } else {   // 회원가입 실패 시
	            req.setAttribute("msg", "로그인 실패, 관리자에게 문의해주세요.");
	            req.setAttribute("url", "user_main.do");
	         }
	         
	      } else { // 기존 회원 이면
	         session.setAttribute("login_mem", id_check);
	         session.setAttribute("mbId", id_check.getMem_id());
	         req.setAttribute("msg", id_check.getMem_nickname() + " 님, 로그인 되었습니다.");
	      }
	         
	      // 4.파싱 닉네임 세션으로 저장
	      session.setAttribute("naverName", name);
	      session.setAttribute("naverNickname", nickname); 
	      session.setAttribute("mbId", email);
	      session.setAttribute("naverHp", hp);
	      session.setAttribute("naverLogin", "naverLogin");
	      req.setAttribute("url", "user_main.do");
	      
	      model.addAttribute("result", apiResult);
	      session.setMaxInactiveInterval(86400);
	      // 안읽은 알람
	         List<AlarmDTO> listCount = null;
	            if (id_check == null) {
	               listCount = alarmMapper.boardunReadAlarmList(dto.getMem_num());
	            } else {
	               listCount = alarmMapper.boardunReadAlarmList(id_check.getMem_num());
	            }
	            //총 알람의 갯수
	            int count = listCount.size();
	            session.setAttribute("alarmCount", count);
	      return "message";
	   }
	
	// 네이버 로그아웃
	@RequestMapping("naverLogout.do")
	public ModelAndView naver_logout(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("login/naverLogout");
		HttpSession session = req.getSession();
		String loginMode = (String)session.getAttribute("naverLogin");
		if (loginMode.equals("naverLogin")) {
			mav.addObject("url","http://nid.naver.com/nidlogin.logout");
			mav.addObject("msg","로그아웃되었습니다.");
			mav.addObject("loginMode", loginMode);
			session.invalidate();
		}
		return mav;
	}
}
