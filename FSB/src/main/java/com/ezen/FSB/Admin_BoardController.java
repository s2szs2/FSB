package com.ezen.FSB;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.AlarmDTO;
import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.Board_replyDTO;
import com.ezen.FSB.dto.NoticeDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.SH_boardDTO;
import com.ezen.FSB.dto.SH_board_replyDTO;
import com.ezen.FSB.service.AdminBoardMapper;
import com.ezen.FSB.service.AdminMapper;
import com.ezen.FSB.service.AlarmMapper;
import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.MemberMapper;
import com.ezen.FSB.service.MypageMapper;

@Controller
public class Admin_BoardController { // 관리자 - 커뮤니티 Controller

	@Autowired
	AdminMapper adminMapper;
	
	@Autowired
	AdminBoardMapper adminBoardMapper;
	
	@Autowired
	LoginMapper loginMapper;
	
	
	@Autowired
	AlarmMapper alarmMapper;


	// 커뮤니티 공지글 목록
	@RequestMapping("/admin_board_notice_list.do")
	public ModelAndView listBNotice(@RequestParam Map<String, String> params) {
		String mode = params.get("mode");
		String sort = params.get("sort");
		
		ModelAndView mav = new ModelAndView("admin/board_notice_list");
		
		List<NoticeDTO> listBNotice = null;
		
		if(mode.equals("all")) { // 전체보기
			if(sort.equals("all")) { // 기본 정렬
				listBNotice = adminBoardMapper.listBNotice();
			}else {
				//tem.out.println("소트");
				listBNotice = adminBoardMapper.sortBNotice(sort);
			}
		}else { // 찾기
			listBNotice = adminBoardMapper.findBNotice(params);
		}
		mav.addObject("listBNotice", listBNotice);
		return mav;
	}
	// 커뮤니티 공지글 상세보기
	@RequestMapping("/admin_board_notice_view.do")
	public ModelAndView getBNotice(@RequestParam int n_num) {
		NoticeDTO dto = adminMapper.getNotice(n_num);
		if(dto == null) {
			return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
		}
		return new ModelAndView("admin/board_notice_view", "getNotice", dto);
	}
	// 커뮤니티 공지글 수정 폼
	@RequestMapping(value="/admin_board_notice_update.do", method=RequestMethod.GET)
	public ModelAndView updateBNotice(@RequestParam int n_num) {
		NoticeDTO dto = adminMapper.getNotice(n_num);
		return new ModelAndView("admin/board_notice_update", "getNotice", dto);
	}
	// 커뮤니티 공지글 수정 처리
	@RequestMapping(value="/admin_board_notice_update.do", method=RequestMethod.POST)
	public ModelAndView updateOkBNotice(@ModelAttribute NoticeDTO dto, BindingResult result) {
		if(result.hasErrors()) {}
		
		int res = adminMapper.updateNotice(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "게시판 공지글 수정 성공! 해당 게시글 보기 페이지로 이동합니다.");
			mav.addObject("url", "admin_board_notice_view.do?n_num="+dto.getN_num());
		}else {
			mav.addObject("msg", "게시판 공지글 수정 실패! 해당 게시글 수정 페이지로 이동합니다.");
			mav.addObject("url", "admin_board_notice_update.do?n_num="+dto.getN_num());
		}
		return mav;
	}
	// 커뮤니티 공지글 등록 폼
	@RequestMapping(value="/admin_board_notice_insert.do", method=RequestMethod.GET)
	public String insertBNotice() {
		return "admin/board_notice_insert";
	}
	// 커뮤니티 공지글 등록 처리
	@RequestMapping(value="/admin_board_notice_insert.do", method=RequestMethod.POST)
	public ModelAndView insertOkBNotice(@ModelAttribute NoticeDTO dto, BindingResult result) {
		if(result.hasErrors()) {}
		
		int res = adminMapper.insertNotice(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "게시판 공지글 등록 성공! 게시글 목록 페이지로 이동합니다.");
			mav.addObject("url", "admin_board_notice_list.do?mode=all&sort=all");
		}else {
			mav.addObject("msg", "게시판 공지글 등록 실패! 게시글 등록 페이지로 이동합니다.");
			mav.addObject("url", "admin_board_notice_insert.do");
		}
		return mav;
	}
	// 커뮤니티 공지글 삭제 처리
	@RequestMapping("/admin_board_notice_delete.do")
	public ModelAndView deleteBNotice(@RequestParam int n_num) {
		int res = adminMapper.deleteNotice(n_num);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "게시판 공지글 삭제 성공! 게시글 목록 페이지로 이동합니다.");
		}else {
			mav.addObject("msg", "게시판 공지글 삭제 실패! 게시글 목록 페이지로 이동합니다.");
		}
		mav.addObject("url", "admin_board_notice_list.do?mode=all&sort=all");
		return mav;
		
	}
	// 게시판 목록
	@RequestMapping("/admin_board_list.do")
	public ModelAndView listBoard(HttpServletRequest req, @RequestParam Map<String, Integer> params, @RequestParam String view) {
		
		ModelAndView mav = null;
		
		if(view.equals("free")) { // 자유
			mav = new ModelAndView("admin/board_list_free");
		}else if(view.equals("anony")) { // 익명
			mav = new ModelAndView("admin/board_list_anony");
		}else { // 중고
			mav = new ModelAndView("admin/board_list_sh");
		}
		
		//페이지 넘버
		int pageSize = 5;
		
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count;
		if(view.equals("free")) { // 자유
			count = adminBoardMapper.getCountBoard();
		}else if(view.equals("anony")) { // 익명
			count = adminBoardMapper.getCountBoard_anony();
		}else { // 중고
			count = adminBoardMapper.getCountBoard_sh("all");
		}
		params.put("start", startRow);
		params.put("end", endRow);
		
		if (endRow > count)
			endRow = count;
		
		if (count > 0) {
			if(view.equals("free")) { // 자유
				List<BoardDTO> list = adminBoardMapper.listFreeBoard(params);
				mav.addObject("listBoard", list);
			}else if(view.equals("anony")) { // 익명
				List<BoardDTO> list = adminBoardMapper.listAnonyBoard(params);
				mav.addObject("listBoard", list);
			}else { // 중고
				List<SH_boardDTO> list = adminBoardMapper.listSHBoard(params);
				mav.addObject("listBoard", list);
			}
			
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
		
		return mav;
	}
	
	// 게시판 글 삭제
		@RequestMapping("/admin_board_delete.do")
		public ModelAndView deleteBoard(HttpServletRequest req, @RequestParam int board_num, @RequestParam Map<String, String> params) {

			
			ModelAndView mav = new ModelAndView("message");
			// 이미지 경로
			HttpSession session = req.getSession();
			String upPath = session.getServletContext().getRealPath("/resources/img");
			
			String view = params.get("view"); // 어느 게시판에서 왔는지
			
			//알람2
			int mem_num = 0;
			String title = "";
			if(view.equals("secondhand")) {
				mem_num = alarmMapper.shBoardNum(board_num);
				title = alarmMapper.shBoardTitle(board_num);
			}else {
				mem_num = alarmMapper.BoardNum(board_num);
				 title = alarmMapper.BoardTitle(board_num);
			}
			// 받은 img 이름
			String board_img1 = params.get("board_img1");
			String board_img2 = params.get("board_img2");
			String board_img3 = params.get("board_img3");
			String board_img4 = params.get("board_img4");
			// img 로 파일 객체 생성&삭제
			if(board_img1 != null) {
				File file1 = new File(upPath, board_img1);
				if (file1.exists()){
					file1.delete();
					//tem.out.println("이미지1 삭제 성공");
				}else {
					mav.addObject("msg", "이미지1 삭제 실패! 게시판 목록 페이지로 이동합니다.");
					mav.addObject("url", "admin_board_list.do?view="+view);
					return mav;
				}
			}
			if(board_img2 != null) {
				File file2 = new File(upPath, board_img2);
				if (file2.exists()){
					file2.delete();
					//tem.out.println("이미지2 삭제 성공");
				}else {
					mav.addObject("msg", "이미지2 삭제 실패! 게시판 목록 페이지로 이동합니다.");
					mav.addObject("url", "admin_board_list.do?view="+view);
					return mav;
				}
			}
			if(board_img3 != null) {
				File file3 = new File(upPath, board_img3);
				if (file3.exists()){
					file3.delete();
					//tem.out.println("이미지3 삭제 성공");
				}else {
					mav.addObject("msg", "이미지3 삭제 실패! 게시판 목록 페이지로 이동합니다.");
					mav.addObject("url", "admin_board_list.do?view="+view);
					return mav;
				}
			}
			if(board_img4 != null) {
				File file4 = new File(upPath, board_img4);
				if (file4.exists()){
					file4.delete();
					//tem.out.println("이미지4 삭제 성공");
				}else {
					mav.addObject("msg", "이미지4 삭제 실패! 게시판 목록 페이지로 이동합니다.");
					mav.addObject("url", "admin_board_list.do?view="+view);
					return mav;
				}
			}
			
			// 댓글 삭제 전에 list 미리 뽑기
			List<Board_replyDTO> listR = null;
			List<SH_board_replyDTO> listSHR = null;
			if(view.equals("secondhand")) {
				listSHR = adminBoardMapper.listBoardSHReply(board_num);
			}else {
				listR = adminBoardMapper.listBoardReply(board_num);
			}
			
				if(view.equals("free")||view.equals("anony")) { // 자유 , 익명
					List<Board_replyDTO> list = adminBoardMapper.listBoardReply(board_num);
					if(list.size() != 0) { // 댓글이 있다면
						int res2 = adminBoardMapper.deleteReplyAll(board_num);
						if(res2>0) {
							// DB 삭제
							int res = adminBoardMapper.deleteBoard(board_num);
							if(res>0) {
								mav.addObject("msg", "이미지/게시글/댓글 삭제 성공! 게시판 목록 페이지로 이동합니다.");
							}else {
								mav.addObject("msg", "이미지/댓글 삭제 성공! 게시글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
							}
						}else {
							mav.addObject("msg", "이미지 삭제 성공! 댓글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
						}
					}else { // 댓글이 없다면
						// DB 삭제
						int res = adminBoardMapper.deleteBoard(board_num);
						if(res>0) {
							mav.addObject("msg", "이미지/게시글 삭제 성공! 게시판 목록 페이지로 이동합니다.");
						}else {
							mav.addObject("msg", "이미지 삭제 성공! 게시글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
						}
					}
				}else { // 중고
					List<SH_board_replyDTO> list = adminBoardMapper.listBoardSHReply(board_num);
					if(list.size() != 0) { // 댓글이 있다면
						int res2 = adminBoardMapper.deleteReplyAll_sh(board_num);
						if(res2>0) {
							// DB 삭제
							int res = adminBoardMapper.deleteBoard_sh(board_num);
							if(res>0) {
								mav.addObject("msg", "이미지/게시글/댓글 삭제 성공! 게시판 목록 페이지로 이동합니다.");
							}else {
								mav.addObject("msg", "이미지/댓글 삭제 성공! 게시글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
							}
						}else {
							mav.addObject("msg", "이미지 삭제 성공! 댓글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
						}
					}else { // 댓글이 없다면
						// DB 삭제
						int res = adminBoardMapper.deleteBoard_sh(board_num);
						if(res>0) {
							mav.addObject("msg", "이미지/게시글 삭제 성공! 게시판 목록 페이지로 이동합니다.");
						}else {
							mav.addObject("msg", "이미지 삭제 성공! 게시글 삭제 실패! 게시판 목록 페이지로 이동합니다.");
						}
					}
				}
			// 게시글 신고 처리
			List<ReportDTO> list = null;
			if(view.equals("secondhand")) { // 중고 게시글
				list = adminBoardMapper.listReportBoard_sh(board_num);
			}else { // 익명, 자유 게시글
				list = adminBoardMapper.listReportBoard(board_num);
			}
			if(list.size() >0) { // 신고 내역이 있다면 처리여부 0 -> 1
				if(view.equals("secondhand")) { // 중고 게시글
					int res = adminBoardMapper.checkReportBoard_sh(board_num);
					if(res>0) {
						//tem.out.println("게시글 신고 처리여부 적용 완료");
					}else {
						//tem.out.println("게시글 신고 처리여부 적용 실패");
					}
					// 알람처리!!!!!
					
					
					AlarmDTO rm = new AlarmDTO();
					rm.setMem_num(mem_num);
					rm.setAlm_cate("신고");
					rm.setAlm_content(""+title+""+"중고 게시글이 신고 처리되었습니다.");
					rm.setAlm_title("신고처리 소식");

					alarmMapper.addBoardAlarm(rm);
					
				}else { // 익명, 자유 게시글
					int res = adminBoardMapper.checkReportBoard(board_num);
					if(res>0) {
						//tem.out.println("게시글 신고 처리여부 적용 완료");
					}else {
						//tem.out.println("게시글 신고 처리여부 적용 실패");
					}
					
					// 알람처리!!!!!
					
					
					AlarmDTO rm = new AlarmDTO();
					rm.setMem_num(mem_num);
					rm.setAlm_cate("신고");
					rm.setAlm_content(""+title+""+"게시글이 신고 처리되었습니다.");
					rm.setAlm_title("신고처리 소식");

					alarmMapper.addBoardAlarm(rm);
					
				}
				
				
				
			}
			// 게시글의 댓글 신고 내역 삭제 처리
			if(view.equals("secondhand")) { // 중고
				for(SH_board_replyDTO dto : listSHR) {
					int br_num = dto.getBr_num();
					//tem.out.println(br_num);
					adminBoardMapper.delReportBr_sh(br_num);
				}
			}else { // 익명, 자유
				for(Board_replyDTO dto : listR) {
					int br_num2 = dto.getBr_num();
					//tem.out.println(br_num2);
					adminBoardMapper.delReportBr(br_num2);
				}
			}
			mav.addObject("url", "admin_board_list.do?view="+view);
			
			// 게시판, 댓글 미처리 신고내역
			int boardReport = adminBoardMapper.totalListBoard2().size() + adminBoardMapper.totalListBr2().size();
			session.setAttribute("boardReport", boardReport);
			
			return mav;
		}

	// 게시판 글 상세보기
	@RequestMapping("/admin_board_view.do")
	public ModelAndView getBoard(@RequestParam int board_num, @RequestParam String view, @RequestParam String sort) {
		ModelAndView mav = null;
	
		int count = 0;
		
		if(view.equals("secondhand")) { // 중고
			mav = new ModelAndView("admin/board_sh_view");
			SH_boardDTO dto = adminBoardMapper.getBoardSH(board_num);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<SH_board_replyDTO> getBoardReply = null;
			if(sort.equals("report")) { // 신고내역만 보기
				getBoardReply = adminBoardMapper.listBoardSHReplyReport(board_num);
			}else { // 전체 보기
				getBoardReply = adminBoardMapper.listBoardSHReply(board_num);
			}
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			count = adminBoardMapper.getCountReply_sh(board_num);
			mav.addObject("count", count);
			mav.addObject("view", view);
		}else { // 자유, 익명
			mav = new ModelAndView("admin/board_view");
			//tem.out.println("자유, 익명");
			BoardDTO dto = adminBoardMapper.getBoard(board_num);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<Board_replyDTO> getBoardReply = null;
			if(sort.equals("report")) { // 신고 내역만 보기
				getBoardReply = adminBoardMapper.listBoardReplyReport(board_num);
			}else { // 전체 보기
				getBoardReply = adminBoardMapper.listBoardReply(board_num);
			}
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			count = adminBoardMapper.getCountReply(board_num);
			mav.addObject("count", count);
			mav.addObject("view", view);
		}
		return mav;
	}
	// 게시판 댓글 신고내역 보기
	@RequestMapping("/admin_br_report_list.do")
	public ModelAndView listBoardReplyReport (@RequestParam String view, @RequestParam int br_num) {
		
		ModelAndView mav = new ModelAndView("admin/board_report_list");
		List<ReportDTO> list = null;
		if(view.equals("secondhand")) { // 중고의 댓글 신고내역
			list = adminBoardMapper.listReportBr_sh(br_num);
		}else { // 자유, 익명 의 댓글 신고내역
			list = adminBoardMapper.listReportBr(br_num);
		}
		mav.addObject("listReport", list);
		return mav;
	}
	// 게시판 신고내역 보기
	@RequestMapping("/admin_board_report_list.do")
	public ModelAndView listBoardReport (@RequestParam String view, @RequestParam int board_num) {
		
		ModelAndView mav = new ModelAndView("admin/board_report_list");
		List<ReportDTO> list = null;
		if(view.equals("secondhand")) { // 중고 신고내역
			list = adminBoardMapper.listReportBoard_sh(board_num);
		}else { // 익명, 자유 신고내역
			list  = adminBoardMapper.listReportBoard(board_num);
		}
		mav.addObject("listReport", list);
		return mav;
	}
	// 게시글 신고 취소
	@RequestMapping("/admin_board_report_del.do")
	public ModelAndView delBoardReport (HttpServletRequest req, @RequestParam String view, @RequestParam int board_num) {
		ModelAndView mav = new ModelAndView("message");
		if(view.equals("secondhand")) { // 중고 신고 취소
			// report 신고 내역에서 지우기
			int res = adminBoardMapper.delReportBoard_sh(board_num);
			if(res>0) {
				// 해당 board_report -> 0
				int res2 = adminBoardMapper.updateReportBoard_sh(board_num);
				if(res2>0) {
					mav.addObject("msg","게시글 신고 내역 삭제/게시글 신고 취소 성공!");
				}else {
					mav.addObject("msg","게시글 신고 내역 삭제 성공! 게시글 신고 취소 실패!");
				}
			}else {
				mav.addObject("msg","게시글 신고 내역 삭제 실패!");
			}
		}else { // 익명, 자유 신고 취소
			// report 신고 내역에서 지우기
			int res = adminBoardMapper.delReportBoard(board_num);
			if(res>0) {
				// 해당 board_report -> 0
				int res2 = adminBoardMapper.updateReportBoard(board_num);
				if(res2>0) {
					mav.addObject("msg","게시글 신고 내역 삭제/게시글 신고 취소 성공!");
				}else {
					mav.addObject("msg","게시글 신고 내역 삭제 성공! 게시글 신고 취소 실패!");
				}
			}else {
				mav.addObject("msg","게시글 신고 내역 삭제 실패!");
			}
		}
		mav.addObject("url", "admin_board_view.do?sort=all&board_num="+board_num+"&view="+view);
		
		// 게시판, 댓글 미처리 신고내역
		int boardReport = adminBoardMapper.totalListBoard2().size() + adminBoardMapper.totalListBr2().size();
		HttpSession session = req.getSession();
		session.setAttribute("boardReport", boardReport);
				
		return mav;
	}
	// 게시글 댓글 신고 취소
	@RequestMapping("/admin_br_report_del.do")
	public ModelAndView delBrReport (HttpServletRequest req, @RequestParam int br_num, @RequestParam int board_num, @RequestParam String view) {
		ModelAndView mav = new ModelAndView("message");
		
		if(view.equals("secondhand")) { // 중고 게시글 댓글
			// report 신고 내역에서 지우기
			int res = adminBoardMapper.delReportBr_sh(br_num);
			if(res>0) {
				// 해당 br 에서 report -> 0
				int res2 = adminBoardMapper.updateReportBr_sh(br_num);
				if(res2>0) {
					mav.addObject("msg","게시글 신고 내역 삭제/게시글 신고 취소 성공!");
				}else {
					mav.addObject("msg","게시글 신고 내역 삭제 성공! 게시글 신고 취소 실패!");
				}
			}else {
				mav.addObject("msg","게시글 신고 내역 삭제 실패!");
			}
		}else { // 자유, 익명 게시글 댓글
			// report 신고 내역에서 지우기
			int res = adminBoardMapper.delReportBr(br_num);
			if(res>0) {
				// 해당 br 에서 report -> 0
				int res2 = adminBoardMapper.updateReportBr(br_num);
				if(res2>0) {
					mav.addObject("msg","게시글 신고 내역 삭제/게시글 신고 취소 성공!");
				}else {
					mav.addObject("msg","게시글 신고 내역 삭제 성공! 게시글 신고 취소 실패!");	
				}
			}else {
				mav.addObject("msg","게시글 신고 내역 삭제 실패!");	
			}
		}
		mav.addObject("url","admin_board_view.do?sort=all&board_num="+board_num+"&view="+view);
		// 게시판, 댓글 미처리 신고내역
		int boardReport = adminBoardMapper.totalListBoard2().size() + adminBoardMapper.totalListBr2().size();
		HttpSession session = req.getSession();
		session.setAttribute("boardReport", boardReport);
		
		return mav;
	}
	// 게시판 댓글 삭제
		@RequestMapping("/admin_br_delete.do")
		public ModelAndView deleteBoardReply(HttpServletRequest req, @RequestParam int br_num, @RequestParam int board_num, @RequestParam String view) {
			
			ModelAndView mav = new ModelAndView("message");
			if(view.equals("secondhand")) { // 중고 게시판 댓글
				List<ReportDTO> list = adminBoardMapper.listReportBr_sh(br_num);
				if(list.size() >0) { // 신고내역이 있다면
					// 신고 처리여부 0 -> 1
					int res = adminBoardMapper.checkReportBr_sh(br_num);
					if(res>0) {
						//tem.out.println("신고처리 적용 완료");
					}else {
						//tem.out.println("신고처리 적용 실패");
					}
					// 알람처리 중고댓글 
					int mem_num = alarmMapper.shBoardNumReply(br_num);
					int boardNum = alarmMapper.shBoardTitleReply(br_num);
					String title = alarmMapper.BoardTitle(boardNum);
					AlarmDTO rm = new AlarmDTO();
					rm.setMem_num(mem_num);
					rm.setAlm_cate("신고");
					rm.setAlm_content(""+title+""+"중고 게시글에 작성하신 댓글이 신고 처리되었습니다.");
					rm.setAlm_title("신고처리 소식");

					alarmMapper.addBoardAlarm(rm);
				}
				// 댓글 삭제
				int res2 = adminBoardMapper.delBr_sh(br_num);
				if(res2>0) {
					mav.addObject("msg", "해당 댓글 삭제 성공!");
				}else {
					mav.addObject("msg", "해당 댓글 삭제 실패!");
				}
			}else { // 익명, 자유 게시판 댓글
				List<ReportDTO> list = adminBoardMapper.listReportBr(br_num);
				if(list.size()>0) { // 신고내역이 있다면
					// 신고 처리 여부 0 -> 1
					int res = adminBoardMapper.checkReportBr(br_num);
					if(res>0) {
						//tem.out.println("신고 처리 적용 완료");
					}else {
						//tem.out.println("신고처리 적용 실패");
					}
					
					// 알람처리 게시판댓글 
					int mem_num = alarmMapper.BoardNumReply(br_num);
					int boardNum = alarmMapper.BoardTitleReply(br_num);
					String title = alarmMapper.shBoardTitle(boardNum);
					AlarmDTO rm = new AlarmDTO();
					rm.setMem_num(mem_num);
					rm.setAlm_cate("신고");
					rm.setAlm_content(""+title+""+"게시글에 작성하신 댓글이 신고 처리되었습니다.");
					rm.setAlm_title("신고처리 소식");

					alarmMapper.addBoardAlarm(rm);
					
				}
				// 댓글 삭제
				int res2 = adminBoardMapper.delBr(br_num);
				if(res2>0) {
					mav.addObject("msg", "해당 댓글 삭제 성공!");
				}else {
					mav.addObject("msg", "해당 댓글 삭제 실패!");
				}
			}
			mav.addObject("url","admin_board_view.do?sort=all&board_num="+board_num+"&view="+view);
			
			// 게시판, 댓글 미처리 신고내역
			int boardReport = adminBoardMapper.totalListBoard2().size() + adminBoardMapper.totalListBr2().size();
			HttpSession session = req.getSession();
			session.setAttribute("boardReport", boardReport);
			
			return mav;
		}

	
	// 전체 게시판 신고 내역 페이지
	@RequestMapping("/admin_board_total_report.do")
	public ModelAndView listTotalReportBoard(@RequestParam String mode) {
		ModelAndView mav = new ModelAndView("admin/board_total_report_list");
		
		List<ReportDTO> listBoardReport = null; // 게시글 신고내역
		List<ReportDTO> listBrReport = null; // 댓글 신고내역
		
		if(mode.equals("all")) { // 전체 보기
			listBoardReport = adminBoardMapper.totalListBoard();
			listBrReport = adminBoardMapper.totalListBr();
		}else { // 미처리 내역 보기
			listBoardReport = adminBoardMapper.totalListBoard2();
			listBrReport = adminBoardMapper.totalListBr2();
		}

		mav.addObject("listBoardReport", listBoardReport);
		mav.addObject("listBrReport", listBrReport);
		return mav;
	}
	// 전체 게시판 신고 내역 - 상세보기
	@RequestMapping("/admin_board_total_report_view.do")
	public ModelAndView viewTotalReportBoard(@RequestParam int report_target, @RequestParam String report_mode) {
		ModelAndView mav = null;
		if(report_mode.equals("자유,익명게시글")) {
			mav = new ModelAndView("admin/board_view");
			//tem.out.println("자유, 익명 게시글");
			//tem.out.println(report_target);
			BoardDTO dto = adminBoardMapper.getBoard(report_target);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<Board_replyDTO> getBoardReply = adminBoardMapper.listBoardReply(report_target);
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			int count = adminBoardMapper.getCountReply(report_target);
			mav.addObject("count", count);
			//tem.out.println(dto.getBoard_title());
			//tem.out.println(dto.getBoard_anony_check());
			if(dto.getBoard_anony_check() == 1) { // 익명
				mav.addObject("view", "anony");
			}else { // 자유
				mav.addObject("view", "free");
			}
			return mav;
		}else if(report_mode.equals("중고게시글")) {
			mav = new ModelAndView("admin/board_sh_view");
			SH_boardDTO dto = adminBoardMapper.getBoardSH(report_target);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<SH_board_replyDTO> getBoardReply = adminBoardMapper.listBoardSHReply(report_target);
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			int count = adminBoardMapper.getCountReply_sh(report_target);
			mav.addObject("count", count);
			mav.addObject("view", "secondhand");
			return mav;
		}else if(report_mode.equals("자유,익명댓글")) {
			int board_num = adminBoardMapper.totalFindBoard(report_target);
			mav = new ModelAndView("admin/board_view");
			//tem.out.println("자유, 익명 댓글");
			BoardDTO dto = adminBoardMapper.getBoard(board_num);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<Board_replyDTO> getBoardReply = adminBoardMapper.listBoardReply(board_num);
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			int count = adminBoardMapper.getCountReply(board_num);
			mav.addObject("count", count);
			if(dto.getBoard_anony_check() == 1) { // 익명
				mav.addObject("view", "anony");
			}else { // 자유
				mav.addObject("view", "free");
			}
			return mav;
		}else if(report_mode.equals("중고댓글")) {
			int board_num = adminBoardMapper.totalFindBoard_sh(report_target);
			mav = new ModelAndView("admin/board_sh_view");
			SH_boardDTO dto = adminBoardMapper.getBoardSH(board_num);
			if(dto == null) {
				return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
			}
			mav.addObject("getBoard", dto);
			// 댓글 리스트
			List<SH_board_replyDTO> getBoardReply = adminBoardMapper.listBoardSHReply(report_target);
			mav.addObject("getBoardReply", getBoardReply);
			// 댓글 수
			int count = adminBoardMapper.getCountReply_sh(report_target);
			mav.addObject("count", count);
			mav.addObject("view", "secondhand");
			return mav;
		}
		return null;
	}
}
