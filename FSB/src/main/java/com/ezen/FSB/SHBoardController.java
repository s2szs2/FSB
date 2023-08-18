package com.ezen.FSB;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.NoticeDTO;
import com.ezen.FSB.dto.SH_boardDTO;
import com.ezen.FSB.dto.SH_board_replyDTO;
import com.ezen.FSB.service.BoardMapper;

@Controller
public class SHBoardController {

	
	@Autowired
	private BoardMapper boardMapper;
	
	@Resource(name = "uploadPath")
	private String upPath;
	
	
	//중고게시판 검색
		@RequestMapping("board_sh_find.do")
		public ModelAndView shFind(HttpServletRequest req, @RequestParam java.util.Map<String,Object> params) {
			
			ModelAndView mav = new ModelAndView("board/list_sh");
			String select = (String) params.get("select");
			String searchString =(String) params.get("searchString");
		
			if(select.equals("writer")){
				select = "m.mem_nickname";
			}else if(select.equals("title")) {
				select = "board_title";
			}else {
				select ="board_content";
			}
			//조회수 순 
			List<SH_boardDTO> readlist = boardMapper.readlist_sh();
			mav.addObject("readlist", readlist);
			//댓글순
			List<SH_boardDTO> replylist = boardMapper.replylist_sh();
			mav.addObject("replylist", replylist);
			
			params.put("search", select);
			params.put("searchString", searchString);

			//검색시 페이지 넘버
					int pageSize = 10;
					String pageNum = (String) params.get("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = boardMapper.getCountFind_sh(params);
									params.put("start", startRow);
					params.put("end", endRow);
					if (endRow > count)
						endRow = count;
					List<SH_boardDTO> list = null;
					if (count > 0) {
						list = boardMapper.findSH(params);
						int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
						int pageBlock = 2;
						int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount)
							endPage = pageCount;

						mav.addObject("startPage", startPage);
						mav.addObject("endPage", endPage);
						mav.addObject("pageBlock", pageBlock);
						mav.addObject("pageCount", pageCount);
					}
					
						mav.addObject("count", count);
						mav.addObject("listBoard_sh", list);
			
						return mav;
		}
		//중고게시판 리스트
				@RequestMapping("/board_secondhand.do")
				public ModelAndView boardSecondhand(HttpServletRequest req, @RequestParam java.util.Map<String, Object> params) {
						ModelAndView mav = new ModelAndView();
						HttpSession session = req.getSession();
						session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
						//공지사항 리스트 
						String mode = req.getParameter("mode");
						List<NoticeDTO> nlist =boardMapper.nlistBoard(mode);
						//조회수 순
						List<SH_boardDTO> readlist = boardMapper.readlist_sh();
						mav.addObject("readlist", readlist);
						//댓글순
						List<SH_boardDTO> replylist = boardMapper.replylist_sh();
						mav.addObject("replylist", replylist);
						//거래방법 소트시키기 위해서 받은 모드 
						if(mode.equals("sell")) {
						mode="팝니다";
						}else if(mode.equals("buy")) {
							mode="삽니다";
						}else if(mode.equals("change")){
							mode="교환";
						}
						params.put("board_condition", mode);
						
						
						//페이지 넘버
						int pageSize = 10;

						String pageNum = req.getParameter("pageNum");
						if (pageNum == null) {
							pageNum = "1";
						}
						int currentPage = Integer.parseInt(pageNum);
						int startRow = (currentPage - 1) * pageSize + 1;
						int endRow = startRow + pageSize - 1;
						int count = boardMapper.getCountBoard_sh(mode);
						params.put("start", startRow);
						params.put("end", endRow);

						if (endRow > count)
							endRow = count;
						List<SH_boardDTO> list = null;
						if (count > 0) {
							list =boardMapper.listBoard_sh(params);
							int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
							int pageBlock = 2;
							int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
							int endPage = startPage + pageBlock - 1;
							if (endPage > pageCount)
								endPage = pageCount;

							mav.addObject("startPage", startPage);
							mav.addObject("endPage", endPage);
							mav.addObject("pageBlock", pageBlock);
							mav.addObject("pageCount", pageCount);
						}
						mav.addObject("count", count);
						mav.addObject("listBoard_sh", list);
						mav.addObject("nlistBoard", nlist);
						mav.setViewName("board/list_sh");
						return mav;	
						}
					
			//중고게시판 작성 폼 띄우기 get
				@RequestMapping(value = "/write_board_sh.do", method = RequestMethod.GET)
				public ModelAndView writeFormSHBoard(HttpServletRequest req) {
					int num = 0, re_group = 0, re_step = 0, re_level = 0;
					ModelAndView mav = new ModelAndView();
					//로그인 체크 
					HttpSession session= req.getSession();
						MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
						if(mdto == null) {
							session.invalidate();
							mav.setViewName("message_back");
							mav.addObject("msg","로그인 해주세요" );
							return mav;
						}
					String snum = req.getParameter("board_num");
					if (snum != null) {
						num = Integer.parseInt(snum);
						re_group = Integer.parseInt(req.getParameter("board_re_group"));
						re_step = Integer.parseInt(req.getParameter("board_re_step"));
						re_level = Integer.parseInt(req.getParameter("board_re_level"));
					}
					
					mav.addObject("board_num", num);
					mav.addObject("board_re_group", re_group);
					mav.addObject("board_re_step", re_step);
					mav.addObject("board_re_level", re_level);
					mav.setViewName("board/writeForm_sh");
					return mav;
				}
				//중고 게시판 글작성 post
				@RequestMapping(value = "/write_board_sh.do", method = RequestMethod.POST)
				public String writeShPro(HttpServletRequest req, @RequestParam Map<String, Object> map, @ModelAttribute SH_boardDTO dto,BindingResult result)
								throws IllegalStateException, IOException {
							if (result.hasErrors()) {
								dto.setBoard_img1("");
								dto.setBoard_img2("");
								dto.setBoard_img3("");
								dto.setBoard_img4("");
							}
							//로그인 체크 
							HttpSession session= req.getSession();
								MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
								if(mdto == null) {
									session.invalidate();
									req.setAttribute("msg","로그인 해주세요" );
									req.setAttribute("url","login.do" );
									return "message";
								}
								
							//회원 정보 세션에서 꺼내기
							int mem_num = mdto.getMem_num();
							//tem.out.println("중고게시판 등록 멤버넘버" + mem_num);
							dto.setMem_num(mem_num);
							
							//셀렉트 지역
							String location = req.getParameter("board_location");
							if(location.equals("0")) {
								location = "서울";
							}else if(location.equals("1")) {
								location = "경기";
							}else if(location.equals("2")) {
								location = "강원도";
							}else if(location.equals("3")) {
								location = "충청북도";
							}else if(location.equals("4")) {
								location = "충청남도";
							}else if(location.equals("5")) {
								location = "경상북도";
							}else if(location.equals("6")) {
								location = "경상남도";
							}else if(location.equals("7")) {
								location = "전라북도";
							}else if(location.equals("8")) {
								location = "전라남도";
							}else {
								location = "제주도";
							}
							dto.setBoard_location(location);

							
							//셀렉트 거래종류
							String condition = req.getParameter("board_condition");
							if(condition.equals("0")) {
								condition = "팝니다";
							}else if(condition.equals("1")) {
								condition = "삽니다";
							}else if(condition.equals("2")) {
								condition = "교환";
							}else {
								condition = "거래완료(내정)";
							}
							dto.setBoard_condition(condition);
							
							
							//셀렉트 거래 방법
							String package1 = req.getParameter("board_package");
							if(package1.equals("1")) {
								package1 = "택배만";
							}else if(package1.equals("2")) {
								package1 = "직거래만";
							}else {
								package1 = "택배/직거래";
							}
							dto.setBoard_package(package1);
							
							//ip받아오기
							dto.setBoard_ip(req.getRemoteAddr());
							
							//이미지 받기
							String upPath = session.getServletContext().getRealPath("/resources/img");
							session.setAttribute("upPath", upPath);
							for(int i=0; i<4; ++i) {
								String imgs = (String) map.get("imgs"+i);
								//tem.out.println(imgs);
								if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
								
								byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
								String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
								
								if(i==0) dto.setBoard_img1(fileName);
								if(i==1) dto.setBoard_img2(fileName);
								if(i==2) dto.setBoard_img3(fileName);
								if(i==3) dto.setBoard_img4(fileName);
								
								File file = new File(upPath, fileName);
								//저장공간에 비어있는 파일 생성
								try{
									file.createNewFile();
								}catch(IOException e) {
									e.printStackTrace();
								}
								// 파일에 이미지 출력
								try {
									FileOutputStream fos = new FileOutputStream(file);
									fos.write(imageData);
									fos.close();
								} catch (IOException e) {
									e.printStackTrace();
								}
								
							}
							//tem.out.println(upPath); //콘솔에 확인용 경로 출력
							
							req.setAttribute("mode", "all");
							req.setAttribute("dto", dto);
							String mode = "all";
							int res = boardMapper.insertBoard_sh(dto,mode);
							if (res > 0) {
									req.setAttribute("msg", "게시글 등록 성공");
									req.setAttribute("url", "board_secondhand.do?mode=all");
							}else {
								req.setAttribute("msg", "게시글 등록 실패");
								req.setAttribute("url", "write_board_sh.do");
							}
							return "message";
					}
		//중고게시판 상세보기 
		@RequestMapping("/content_board_sh.do")
		public ModelAndView getBoard_sh(HttpServletRequest req, @RequestParam int board_num, @RequestParam int pageNum, @RequestParam(required = false) Map<String,Integer> params) throws IOException {

			HttpSession session = req.getSession();
			ModelAndView mav = new ModelAndView("/board/content_sh");
			//로그인 체크 
				MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
				if(mdto == null) {
					session.invalidate();
					mav.setViewName("message_back");
					mav.addObject("msg","로그인 해주세요" );
					return mav;
				}
			String upPath = session.getServletContext().getRealPath("/resources/img");
			session.setAttribute("upPath", upPath);
			SH_boardDTO dto = boardMapper.getBoard_sh(board_num, "content");
			mav.addObject("getBoard", dto);
			
			// 여기부터 승미가 만짐 (매개변수 int board_num -> Map<String, Integer> params 로 바꿈
			int pageSize = 10;
			if (pageNum == 0) {
				pageNum = 1;
			}
			int currentPage = pageNum;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			int count = boardMapper.getCountReply_sh(board_num);
			Map<String, Integer> map2 = new HashMap<String, Integer>();
			map2.put("start", startRow);
			map2.put("end", endRow);
			map2.put("board_num", board_num);
			
			params.put("board_num",board_num);
			params.put("board_replycount",count);
			int board_replycount= boardMapper.setReply_sh(params);

			if (endRow > count)
				endRow = count;
			List<SH_board_replyDTO> list = null;
			if (count > 0) {
				list = boardMapper.listReply_sh(map2);
				int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
				int pageBlock = 2;
				int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;

				mav.addObject("startPage", startPage);
				mav.addObject("endPage", endPage);
				mav.addObject("pageBlock", pageBlock);
				mav.addObject("pageCount", pageCount);
				mav.addObject("pageNum",currentPage);
				mav.addObject("board_replycount_sh",board_replycount);
			}
			mav.addObject("count", count);
			mav.addObject("listReply_sh", list);
			
			
			return mav;
		}
				//중고게시글 수정버튼 클릭시
				@RequestMapping(value = "/update_board_sh.do", method = RequestMethod.GET)
				public ModelAndView updateBoard_sh(HttpServletRequest req, int board_num) {
					ModelAndView mav = new ModelAndView();
					//로그인 체크 
					HttpSession session= req.getSession();
						MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
						if(mdto == null) {
							session.invalidate();
							mav.setViewName("message_back");
							mav.addObject("msg","로그인 해주세요" );
							return mav;
						}
					SH_boardDTO dto = boardMapper.getBoard_sh(board_num, "update");
					mav.addObject("getBoard", dto);
					mav.setViewName("board/updateForm_sh");
					return mav;
				}
			 // 중고 게시글 수정 후
		         @RequestMapping(value = "/update_board_sh.do", method = RequestMethod.POST)
		         public ModelAndView updateOkBoard_sh(HttpServletRequest req, @RequestParam Map<String, String> map, @ModelAttribute SH_boardDTO dto, BindingResult result)
		               throws IllegalStateException, IOException {
		         
		            //로그인 체크 
		            ModelAndView mav = new ModelAndView("message");
		            HttpSession session= req.getSession();
		               MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		               if(mdto == null) {
		       					session.invalidate();
		       					req.setAttribute("msg","로그인 해주세요" );
		       					req.setAttribute("url","login.do" );
		               }
		            
		            // 멤버 넘버
		            int mem_num = mdto.getMem_num();
		            //tem.out.println("중고게시판 수정 멤버넘버" + mem_num);
		            dto.setMem_num(mem_num);
		               
		            int board_num = Integer.parseInt(req.getParameter("board_num"));
		            if (result.hasErrors()) {
		            }
		            //셀렉트 지역
		            String location = req.getParameter("board_location");
		            if(location.equals("0")) {
		               location = "서울 ";
		            }else if(location.equals("1")) {
		               location = "경기 ";
		            }else if(location.equals("2")) {
		               location = "강원도 ";
		            }else if(location.equals("3")) {
		               location = "충청북도 ";
		            }else if(location.equals("4")) {
		               location = "충청남도 ";
		            }else if(location.equals("5")) {
		               location = "경상북도 ";
		            }else if(location.equals("6")) {
		               location = "경상남도 ";
		            }else if(location.equals("7")) {
		               location = "전라북도 ";
		            }else if(location.equals("8")) {
		               location = "전라남도 ";
		            }else {
		               location = "제주도 ";
		            }
		            dto.setBoard_location(location);

		            
		            //셀렉트 거래종류
		            String condition = req.getParameter("board_condition");
		            if(condition.equals("0")) {
		               condition = "팝니다";
		            }else if(condition.equals("1")) {
		               condition = "삽니다";
		            }else if(condition.equals("2")) {
		               condition = "교환";
		            }else {
		               condition = "거래완료(내정)";
		            }
		            dto.setBoard_condition(condition);
		            
		            
		            //셀렉트 거래 방법
		            String package1 = req.getParameter("board_package");
		            if(package1.equals("1")) {
		               package1 = "택배만";
		            }else if(package1.equals("2")) {
		               package1 = "직거래만";
		            }else {
		               package1 = "택배/직거래";
		            }
		            dto.setBoard_package(package1);
		            
		            // 기존 이미지 널 처리
		            dto.setBoard_img1("");
		            dto.setBoard_img2("");
		            dto.setBoard_img3("");
		            dto.setBoard_img4("");
		            
		            String upPath = session.getServletContext().getRealPath("/resources/img");

		            //이미지 처리
		            for(int i=0; i<4; ++i) {
		            String imgs = (String) map.get("imgs"+i);
		            if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
		            if(imgs.equals("1") || imgs.equals("2") || imgs.equals("3") || imgs.equals("4")) {
		               if(i==0) dto.setBoard_img1((String) map.get("board_img"+imgs));
		               if(i==1) dto.setBoard_img2((String) map.get("board_img"+imgs));
		               if(i==2) dto.setBoard_img3((String) map.get("board_img"+imgs));
		               if(i==3) dto.setBoard_img4((String) map.get("board_img"+imgs));
		            }else {
		               byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
		               String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
		               if(i==0) dto.setBoard_img1(fileName);
		               if(i==1) dto.setBoard_img2(fileName);
		               if(i==2) dto.setBoard_img3(fileName);
		               if(i==3) dto.setBoard_img4(fileName);
		                           
		               File file = new File(upPath, fileName);
		               //저장공간에 비어있는 파일 생성
		               try{
		                  file.createNewFile();
		               }catch(IOException e) {
		                  e.printStackTrace();
		               }
		               // 파일에 이미지 출력
		                  try {
		                     FileOutputStream fos = new FileOutputStream(file);
		                     fos.write(imageData);
		                     fos.close();
		                  } catch (IOException e) {
		                     e.printStackTrace();
		                  }
		               }   
		            }
		               
		            //삭제된 이미지 서버에서 삭제
		            String deleted_img = (String)map.get("deleted_img");
		            String[] arr = deleted_img.split(","); //1번 방부터 시작, 총 길이는 삭제된 개수+1

		            for(int i=1; i<arr.length; i++) {
		               int delImgNum = Integer.parseInt(arr[i]);
		               String delImgName = (String)map.get("board_img"+delImgNum);
		               File file = new File(upPath, delImgName);
		               if (file.exists()) {
		                  file.delete();
		               }
		            }

		            int res = boardMapper.updateBoard_sh(dto);
		            if (res > 0) {
		               mav.addObject("msg", "수정성공! ");
		               mav.addObject("url", "content_board_sh.do?board_num=" + board_num+"&pageNum=0");
		               mav.addObject("getBoard_sh", dto);
		            } else {
		               mav.addObject("msg", "수정실패!");
		               mav.addObject("url", "update_board_sh.do?board_num=" + board_num+"&pageNum=0");
		            }
		            return mav;
		         }
				//중고게시글 삭제
				@RequestMapping("/delete_board_sh.do")
				public ModelAndView deleteBoard_sh(HttpServletRequest req,
						@RequestParam(required = false) Map<String, String> params) {
					int board_num = Integer.parseInt(params.get("board_num"));
					ModelAndView mav = new ModelAndView("message");
					//로그인 체크 
					HttpSession session= req.getSession();
						MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
						if(mdto == null) {
							session.invalidate();
							mav.setViewName("message");
							mav.addObject("msg","로그인 해주세요" );
							mav.addObject("url","login.do" );
							return mav;
						}
					String board_img1 = req.getParameter("board_img1");
					String board_img2 = req.getParameter("board_img2");
					String board_img3 = req.getParameter("board_img3");
					String board_img4 = req.getParameter("board_img4");
					int res = boardMapper.deleteBoard_sh(board_num);
					if (res > 0) {
						String upPath = (String) session.getAttribute("upPath");

						File file1 = new File(upPath, board_img1);
						File file2 = new File(upPath, board_img2);
						File file3 = new File(upPath, board_img3);
						File file4 = new File(upPath, board_img4);

						if (file1.exists() || file2.exists() || file3.exists() || file4.exists()) {
							file1.delete();
							file2.delete();
							file3.delete();
							file4.delete();
							mav.addObject("msg", "이미지, 글, 댓글 삭제 성공");
						} else {
							mav.addObject("msg", "이미지 실패, 글 삭제 성공");
						}
					} else {
						mav.addObject("msg", "삭제 실패");
						mav.addObject("url", "content_board_sh.do?board_num="+board_num+"&pageNum=0");
					}
					mav.addObject("url", "board_secondhand.do?mode=all");
					return mav;
				}
		// 중고 게시판 댓글 입력
			@RequestMapping(value = "/write_reply_sh.do")
			public ModelAndView writeReply_sh(HttpServletRequest req, @RequestParam Map<String,Object> params, @ModelAttribute SH_board_replyDTO dto, BindingResult result) {
				
				int re_group = 0, re_step = 0, re_level = 0;
				HttpSession session = req.getSession();
				ModelAndView mav = new ModelAndView("message");
				//로그인 체크 
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
				int board_num = dto.getBoard_num();
				int br_num = dto.getBr_num();
				dto.setBoard_num(board_num);

				MemberDTO dto3 = (MemberDTO)session.getAttribute("login_mem");
			      dto.setMem_num(dto3.getMem_num());
				dto.setMem_nickname(dto3.getMem_nickname());
				
				//대댓글일때
				if(br_num>0) {
					re_group = dto.getBr_re_group();
					re_step=dto.getBr_re_step();
					re_level=dto.getBr_re_level();
				}
				mav.addObject("board_num", board_num);
				mav.addObject("br_num", br_num);
				mav.addObject("br_re_group", re_group);
				mav.addObject("br_re_step", re_step);
				mav.addObject("br_re_level", re_level);
				mav.addObject("dto", dto);
				
				int res = boardMapper.insertReply_sh(dto);
				if (res > 0) {
					mav.addObject("msg", "댓글이 등록 되었습니다.");
					mav.addObject("url", "content_board_sh.do?pageNum=1&board_num="+board_num);
				} else {
					mav.addObject("msg", "댓글 등록 실패");
					mav.addObject("url", "content_board_sh.do?board_num="+board_num);
				}
				return mav;
			}
			
			//중고게시판 대댓글
					@ResponseBody
					@RequestMapping("/re_reply_sh.do")
					public ModelAndView re_reply_sh(HttpServletRequest req,int br_num,int pageNum) {
						ModelAndView mav = new ModelAndView("/board/Re_replyForm_sh");
						SH_board_replyDTO dto = boardMapper.getReply_sh(br_num);
						mav.addObject("dto",dto);
						mav.addObject("br_num", br_num);
						mav.addObject("br_re_group",dto.getBr_re_group());
						mav.addObject("br_re_step",dto.getBr_re_step());
						mav.addObject("br_re_level",dto.getBr_re_level());
						mav.addObject("pageNum", pageNum);
						
						return mav;
					}
			//중고게시판 댓글 수정
			@RequestMapping(value="/update_reply_sh.do", method = RequestMethod.GET)
			public ModelAndView updateReplySH(HttpServletRequest req,int br_num,int pageNum) {
				ModelAndView mav = new ModelAndView("/board/updateReplyForm_sh");
				//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
				SH_board_replyDTO dto = boardMapper.getReply_sh(br_num);
				mav.addObject("dto",dto);
				mav.addObject("br_num",br_num);
				mav.addObject("pageNum", pageNum);
				return mav;
			}
			@ResponseBody
			@RequestMapping(value="/update_replyOk_sh.do")
			public ModelAndView updateReplyProSH(HttpServletRequest req, @RequestParam Map<Object, Object> params) {
				ModelAndView mav = new ModelAndView();
				//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
				String br_num = (String)params.get("br_num");
				SH_board_replyDTO dto = boardMapper.getReply_sh(Integer.parseInt(br_num));
				//String pageNum = (String)params.get
				dto.setBr_content((String)params.get("br_content"));
				boardMapper.updateReply_sh(dto);
				return mav;
			}
			//중고게시판 댓글 삭제 
			@RequestMapping("/delete_reply_sh.do")
			public ModelAndView deleteReply_sh(HttpServletRequest req, int board_num,int br_num, int pageNum) {
				ModelAndView mav = new ModelAndView("message");
				//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
				int res = boardMapper.deleteReply_sh(br_num);
				if (res > 0) {
					mav.addObject("msg", "삭제 성공! ");
					mav.addObject("url",  "content_board_sh.do?board_num="+board_num+"&pageNum="+pageNum);
				} else {
					mav.addObject("msg", "삭제 실패!");
					mav.addObject("url",  "content_board_sh.do?board_num="+board_num+"&pageNum="+pageNum);
				}

				return mav;
			}
	}
