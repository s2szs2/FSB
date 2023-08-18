package com.ezen.FSB;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.AlarmDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.service.AlarmMapper;
import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.MemberMapper;
import com.ezen.FSB.service.MypageMapper;
import com.ezen.FSB.service.ShopMyPageMapper;
import com.fasterxml.jackson.databind.JsonNode;

import net.nurigo.java_sdk.api.Message;

@Controller
public class LoginController {

	@Autowired
	private LoginMapper loginMapper;

	@Autowired
	private ShopMyPageMapper shopMyPageMapper;

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	MypageMapper myPageMapper;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	@Autowired
	private JavaMailSender mailSender;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

/**
 * Simply selects the home view to render by returning its name.
 */


	@RequestMapping("/login.do") //로그인 인덱스로 이동
	public String login(HttpSession session, HttpServletRequest req) {
	
	//========================카카오url보내기========
	String kakaoUrl = KakaoController.getAuthorizationUrl(session);
	req.setAttribute("kakao_url", kakaoUrl);
	
	// 네이버 URL 보내기
	String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	System.out.println("네이버:" + naverAuthUrl);
	req.setAttribute("naver_url", naverAuthUrl);
		
	return "login/login";
	}
	
	@RequestMapping("/login_ok.do") //로그인시!
	public ModelAndView login_ok(HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView("message");
		
		//일반 로그인
		String id = req.getParameter("id");
		String passwd = req.getParameter("passwd");
		String saveId = req.getParameter("saveId");
		
		String dbPass = loginMapper.loginMember(id);
		String loginAct = null;
		String join = loginMapper.joinMember(id); // 승인 받은 사람인지 아닌지
		String msg = null, url = null;
		
		MemberDTO id_exist = loginMapper.findMember(id); //없는 아이디 일 때
		if (id_exist==null) {
			loginAct = "wrongId";
			msg = "없는 아이디 입니다. 다시 입력해 주세요.";
			url = "login.do";
		}else {
		
			if(join.equals("1")) {
				if (dbPass.equals(passwd)) {
					loginAct = "ok"; //데이터베이스 패스워드 = 입력한 패스워드
				}else {
					loginAct = "wrongPw"; //데이터베이스 패스워드 != 입력패스워드
				}

				switch(loginAct) {
					case "ok" :
						Cookie ck = new Cookie("saveId", id);
						if (saveId != null){
							ck.setMaxAge(24*60*60);
						}else {
							ck.setMaxAge(0);
						}
						resp.addCookie(ck);
						
						MemberDTO login_mem = loginMapper.findMember(id); //멤버 dto에서 그 아이디를 가진 사람 꺼내오기!
						
						//로그인 시 마다 카운트 +1회 해주기
						
						int res = loginMapper.plusCount(login_mem);
								
						HttpSession session = req.getSession();
		//				session.setAttribute("member", login_mem); // 다원 디티오 통째 추가 
						session.setAttribute("login_mem", login_mem);
						session.setAttribute("mem_num", login_mem.getMem_num()); // 다도미 추가
				        session.setAttribute("mem_nickname", login_mem.getMem_nickname()); // 다도미 추가
						session.setAttribute("mbId", login_mem.getMem_id());
						session.setAttribute("mbName", login_mem.getMem_name());
						session.setAttribute("loginOk", loginAct); //장바구니 구매같은거 누를때 -> 유리
						session.setAttribute("loginMode", "normalLogin");
						session.setMaxInactiveInterval(86400);
						msg = login_mem.getMem_name() + "님, 로그인 되었습니다.";
						url = "user_main.do";
						// admin 계정일 때
						if(login_mem.getMem_id().equals("admin@a.a")) {
							session.setAttribute("admin", login_mem);
						}
						// 안읽은 알람
						List<AlarmDTO> listCount = alarmMapper.boardunReadAlarmList(login_mem.getMem_num());
						//총 알람의 갯수
						int count = listCount.size();
						session.setAttribute("alarmCount", count);
						
						break;
					case "wrongId" :
						msg = "없는 아이디 입니다. 다시 입력해 주세요.";
						url = "login.do";
						break;
					case "wrongPw" :
						msg = "비밀번호가 틀렸습니다. 다시 입력해 주세요.";
						url =  "login.do";
						break;
					} 
			} else { // join 이 1이 아닌 경우
				msg = "가입승인 대기중입니다.";
				url =  "login.do";
			}
		}
//		req.setAttribute("msg", msg);
//		req.setAttribute("url", url);
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}
	
	 @RequestMapping(value = "/kakao.do", produces = "application/json") //카카오 톡 로그인시 
		public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView("message");
			// 결과값을 node에 담아줌
			JsonNode node = KakaoController.getAccessToken(code);
			// accessToken에 사용자의 로그인한 모든 정보가 들어있음
			
			System.out.println(code);
			JsonNode accessToken = node.get("access_token");
			// 사용자의 정보
			JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
			String kemail = null;
			String kname = null;
			String kgender = null;
			String kbirthday = null;
			String kage = null;
			String kimage = null;
			// 유저정보 카카오에서 가져오기 Get properties
			JsonNode properties = userInfo.path("properties");
			JsonNode kakao_account = userInfo.path("kakao_account");
			kemail = kakao_account.path("email").asText();
			kname = properties.path("nickname").asText();
			kimage = properties.path("profile_image").asText();
			kgender = kakao_account.path("gender").asText();
			kbirthday = kakao_account.path("birthday").asText();
			kage = kakao_account.path("age_range").asText();
			
			//이메일이 처음 로그인하는 이메일이면- > 가입시켜
			MemberDTO id_check = loginMapper.findMember(kemail);
			MemberDTO dto = new MemberDTO();
			if(id_check==null) {
				
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

				
			   
				int count = 0;
				dto.setMem_nickname(nickName);
				dto.setMem_id(kemail);
				dto.setMem_mode("일반");
				dto.setMem_name(kname);	
				dto.setMem_join("1");
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
				dto.setMem_report(0);
				
				int res2= memberMapper.kakaoMemNum();
				
				dto.setMem_num(res2);
				
				int res = memberMapper.insertKakaoMember(dto);
				session.setAttribute("login_mem", dto);
			
			
			if (res >0) {
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
				int res3 = shopMyPageMapper.memberPoint(dto2);
				
			} else {	// 회원가입 실패 시
				request.setAttribute("msg", "로그인 실패, 관리자에게 문의해주세요.");
				request.setAttribute("url", "user_main.do");
			}
			
			} else {	// 기존 회원 이면
			session.setAttribute("login_mem", id_check);
			session.setAttribute("mbId", id_check.getMem_id());
			request.setAttribute("msg", id_check.getMem_nickname() + " 님, 로그인 되었습니다.");
			}
		
			session.setAttribute("loginMode", "kakaoLogin");
			session.setAttribute("login_mem", dto);
			session.setAttribute("kemail", kemail);
			session.setAttribute("kname", kname);
			session.setAttribute("kimage", kimage);
			session.setAttribute("kgender", kgender);
			session.setAttribute("kbirthday", kbirthday);
			session.setAttribute("kage", kage);	
			session.setAttribute("access_Token", accessToken );	
			
			session.setMaxInactiveInterval(86400);
			
			// 로그인 null 오류 수정
			String msg = null;
			String url = "user_main.do";
			List<AlarmDTO> listCount = null;
			if(id_check == null) { // 신규 회원
				MemberDTO dto2 = loginMapper.findMember(dto.getMem_id());
				msg = dto2.getMem_name() + "님, 로그인 되었습니다.";
				// 안읽은 알람
				listCount = alarmMapper.boardunReadAlarmList(dto2.getMem_num());
			}else { // 기존 회원
				msg = id_check.getMem_name() + "님, 로그인 되었습니다.";
				// 안읽은 알람
				listCount = alarmMapper.boardunReadAlarmList(id_check.getMem_num());
			}

			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			
			//총 알람의 갯수
			int count = listCount.size();
			session.setAttribute("alarmCount", count);
			return mav;
		}
	
	@RequestMapping("/logout.do") // 일반 로그아웃
	public String logout(HttpSession session) {
		return "login/logout";
	}
	

	@RequestMapping(value="/kakaologout.do") //카카오톡 로그아웃 
	public String unlink(HttpSession session, HttpServletRequest request) {
		JsonNode access_Token = (JsonNode)session.getAttribute("access_Token");
		
		String jsonString = access_Token.toString();
		
		KakaoController.unlink(jsonString);
		session.removeAttribute("access_Token");
		session.invalidate();

        

		String msg = "로그아웃 되었습니다.";
		String url = "user_main.do";
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "message";
	}
	
	@RequestMapping("/close.do") // 창 닫기
	public String close() {
		return "closeWindow";
	}
	
	
	
	
	//================아이디, 비밀번호 찾기 part=========================
	
	@RequestMapping("/find.do") // 아이디찾기, 비밀번호 찾기
	public String login_search(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		req.setAttribute("mode", mode);
		return "login/find";
	}
	
	
	 //======================================================핸드폰 인증
	public static void certifiedPhoneNumber(String phoneNumber, String numStr) { //핸드폰으로 문자보내는 행위.. 
		  
	      String api_key = "NCSVJBLU69Q9RJ5A";
	      String api_secret = "6OPXHDHVD4DB8BMFCPM2HXXLFN1BOSV9";
	      Message coolsms = new Message(api_key, api_secret);
	
	      
	        HashMap<String, String> params = new HashMap<String, String>();
	        params.put("to", phoneNumber);    
	        params.put("from", "010-2086-1658");   
	        params.put("type", "SMS");
	        params.put("text", "[flyingsuperboard] 인증번호 ["+numStr+"] 을 입력하세요");
	        params.put("app_version", "test app 1.2"); // application name and version
	
	        try {
	            JSONObject obj = (JSONObject)coolsms.send(params);
	            System.out.println(obj.toString());
	        } catch (Exception e) {
	            System.out.println(e.getMessage());
	            
	        }
	}
	 	
	
	
	@RequestMapping("/sendSMS.do") //jsp 페이지 넘긴 mapping 값 //문자 보내기 눌렀을때 랜덤번호 생성및 그 번호 핸드폰 문자로 보내기
	@ResponseBody    
	public ModelAndView sendSMS(@RequestParam Map<String, String> params, HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String mode = params.get("mode");
		req.setAttribute("mode", mode);
		
		
		String name = params.get("name");
		String phoneNumber = params.get("phoneNumber");
		String id = params.get("id");
		
		Random rand  = new Random(); //랜덤숫자 생성하기 !!
		String numStr = "";
		for(int i=0; i<4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr+=ran;
		}
		
		certifiedPhoneNumber(phoneNumber, numStr); 
		req.setAttribute("name", name);
		req.setAttribute("phoneNumber", phoneNumber);
		req.setAttribute("numStr", numStr);
		
		if(id!=null) { //비밀번호 찾기라면
			MemberDTO id_find = loginMapper.findId(name);
			String id_ok = id_find.getMem_id();
			if(id_ok.equals(id)) {
				
				mav.addObject("id", id);
				mav.setViewName("/login/find_phone");
				return mav;
			}
		}
		mav.addObject("id", id);
		mav.addObject("mode", mode);
		mav.setViewName("/login/find_phone");
		return mav;
		//여기까지 이름 번호 넘어옴
	}
	
	@RequestMapping("/sendSMS_ok.do")    // 보냈을 때 입력한 값, 보낸 값 일치하는지 확인 후 아이디 찾아줘 
	public String sms_ok(@RequestParam Map<String, String> params, HttpServletRequest req) {
		String name = params.get("name");
		String phoneNumber = params.get("phoneNumber");
		String id = params.get("id");
		String numberok = params.get("numberok");
		String numStr = params.get("numStr");
		String mode = req.getParameter("mode");
		req.setAttribute("mode", mode);
		
	
		
		if(numberok.equals(numStr)) {
				if(id==null) {
				req.setAttribute("name", name);
				req.setAttribute("phoneNumber", phoneNumber);
				req.setAttribute("numStr", numStr);	
				req.setAttribute("numberok", numberok);
				req.setAttribute("mode", "id");
				
				return "login/find_phone_id";
				
				}else {
					req.setAttribute("name", name);
					req.setAttribute("phoneNumber", phoneNumber);
					req.setAttribute("numStr", numStr);	
					req.setAttribute("numberok", numberok);
					req.setAttribute("id", id);
				
					return "login/find_phone_id";
				}
			//여기까지 이름 넘어옴 
		}
		return null;
	}
	
	@RequestMapping("/find_phone_ok.do")  //아이디찾기 창
	public String find_phone_ok(HttpServletRequest req) {
		String name = (String)req.getParameter("name");
		String phoneNumber = (String)req.getParameter("phoneNumber");
		String mode = req.getParameter("mode");
		req.setAttribute("mode", mode);
		
		MemberDTO id_find = loginMapper.findId(name);
	
		
	
		
			String id = id_find.getMem_id();
			req.setAttribute("id", id);
			
			req.setAttribute("joindate", id_find.getMem_regdate());
			
		
		return "login/find_phone_ok";
	}
	
	@RequestMapping("/find_pw.do") // 핸드폰으로 찾기 비밀번호 재설정 창
	public String find_pw(@RequestParam Map<String, String> params, HttpServletRequest req) {
		String mode = req.getParameter("mode");
		req.setAttribute("mode", mode);
		String id = params.get("id");
		req.setAttribute("id", id);
		return "login/find_pw_ok";
	}
	
	@RequestMapping("/pw_re_ok.do") // 비밀번호 일치시 재설정
	public String message_close(@RequestParam Map<String, String> params, HttpServletRequest req) {
		String mode = req.getParameter("mode");
		req.setAttribute("mode", mode);
		String passwd  = params.get("passwd");
		String passwd2  = params.get("passwd2");
		String id = params.get("id");
		
		MemberDTO dto = loginMapper.findMember(id);
		dto.setMem_passwd(passwd);
		int res = loginMapper.changePw(dto);
		req.setAttribute("msg", "변경되었습니다.");	
		return "message_close";
	}
	
	//============이메일로 인증하기===========================
		
		@RequestMapping(value = "/sendEmail.do") //이메일 보내기
		public ModelAndView sendEmail(@RequestParam String email, @RequestParam Map<String, String> params, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
			
			ModelAndView mv = new ModelAndView();
			String mode = request.getParameter("mode");
			request.setAttribute("mode", mode);
			String name = params.get("name");
			MemberDTO vo = loginMapper.findMember(email);
			//System.out.println(vo.getMem_name());	
			if(vo != null) {
			Random r = new Random();
			int num = r.nextInt(999999); // 랜덤난수설정
			
		
			
			if (num != 0 ) {
				session.setAttribute("email", vo.getMem_id());
	
				String setfrom = "flyingsuperboard1004@gmail.com"; 
				String tomail = email; //받는사람
				String title = "[flyingsuperboard] 이메일 인증 번호"; 
				String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
						+ "flyingsuperboard 이메일 인증번호는 " + num + " 입니다." + System.getProperty("line.separator"); // 
	 
				try { 
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");
	
					messageHelper.setFrom(setfrom); 
					messageHelper.setTo(tomail); 
					messageHelper.setSubject(title);
					messageHelper.setText(content); 
	
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
				
				if (name==null) {
			   
				mv.setViewName("/login/find_email");
				mv.addObject("num", num);
				mv.addObject("email", email);
				mv.addObject("mode", mode);
				
				return mv;
				} else {
					mv.setViewName("/login/find_email");
					mv.addObject("num", num);
					mv.addObject("name", name);
					mv.addObject("email", email);
					mv.addObject("mode", mode);
					return mv;
				}
			}else {
				mv.addObject("msg", "입력하신 메일은 존재하지 않습니다.");
				mv.setViewName("/message_close");
				mv.addObject("mode", mode);
				return mv;
			}
		
		}else {
			mv.addObject("msg", "입력하신 메일은 존재하지 않습니다.");
			mv.setViewName("/message_close");
			mv.addObject("mode", mode);
			return mv;
		}
		}
	
		@RequestMapping(value = "/sendEmail_ok.do", method = RequestMethod.POST) // 받은 이메일 인증번호랑 내가 입력한 값 같은지 확인
		public String sendEmail_ok(@RequestParam(value="email_injeung") String email_injeung,
					@RequestParam(value = "num") String num, @RequestParam Map<String, String> params, HttpServletRequest req) throws IOException{
				String email = params.get("email");
				String name = params.get("name");
				String mode = params.get("mode");
				req.setAttribute("mode", mode);
				
				if(email_injeung.equals(num)) {
					if(name==null) {
					String id= email;
					MemberDTO dto = loginMapper.findMember(id);
					String id2 = dto.getMem_id();
					
					req.setAttribute("id", id2);			
					req.setAttribute("joindate", dto.getMem_regdate());
					req.setAttribute("mode", "id");
					return "login/find_phone_ok";
					
					}else {
						String id2= email;
						MemberDTO dto = loginMapper.findMember(id2);
						String id = dto.getMem_id();
		
						req.setAttribute("id", id);
						req.setAttribute("mode", "passwd");
						return "/login/find_pw_ok";
					}
				}
				else {
					return "login/find_phone_ok";
				}
		} //이메일 인증번호 확인
		
		@RequestMapping("/find_email_pw.do") // 이메일로 찾기 비밀번호 재설정 창
		public String find_pw(HttpServletRequest req) {
			String mode = req.getParameter("mode");
			req.setAttribute("mode", mode);
			String id = (String)req.getAttribute("id2");
			req.setAttribute("id", id);
			return "login/find_pw_ok";
		}
				
	
	}
