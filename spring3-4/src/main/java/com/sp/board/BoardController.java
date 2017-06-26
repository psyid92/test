package com.sp.board;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("board.boardController")
public class BoardController {
	@Autowired
	private BoardService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value="/board/list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(value="searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue = "") String searchValue,
			Model model,
			HttpServletRequest req
			) throws Exception {

		String cp = req.getContextPath();

		int rows = 10;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		map.put("start", start);
		map.put("end", end);

		List<Board> list = service.listBoard(map);

		// 글번호 만들기
		int listNum, n = 0;
		Iterator<Board> it = list.iterator();
		while (it.hasNext()) {
			Board data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/board/list";
		String articleUrl = cp + "/board/article?page=" + current_page;

		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue="
					+ URLEncoder.encode(searchValue, "UTF-8");
		}

		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("subMenu", "3");
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);

		return ".four.menu4.board.list";
	}

	@RequestMapping(value="/board/created", method=RequestMethod.GET)
	public String createdForm(
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}

		model.addAttribute("subMenu", "3");
		model.addAttribute("mode", "created");

		return ".four.menu4.board.created";
	}

	@RequestMapping(value="/board/created", method=RequestMethod.POST)
	public String createdSubmit(
			Board dto,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		
		dto.setMemberIdx(info.getMemberIdx());
		service.insertBoard(dto, "created");

		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/board/article", method=RequestMethod.GET)
	public String article(
			@RequestParam(value="boardNum") int boardNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue = "") String searchValue,
			Model model
			) throws Exception {

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		// 조회수 증가
		service.updateHitCount(boardNum);

		// 해당 레코드 가져 오기
		Board dto = service.readBoard(boardNum);
		if (dto == null)
			return "redirect:/board/list?page="+page;

		// 스마트에디터를 사용하므로 엔터를 <br>로 변경하지 않음
        // dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("groupNum", dto.getGroupNum());
		map.put("orderNo", dto.getOrderNo());

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);

		String query = "page=" + page;
		if (searchValue.length()!=0) {
			query += "&searchKey=" + searchKey + "&searchValue="
					+ URLEncoder.encode(searchValue, "utf-8");
		}

		model.addAttribute("subMenu", "3");
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query); // 이전과 다음에 사용할 인수

		return ".four.menu4.board.article";
	}

	@RequestMapping(value="/board/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam(value="boardNum") int boardNum,
			@RequestParam(value="page", defaultValue = "1") String page,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}

		Board dto = service.readBoard(boardNum);
		if (dto == null)
			return "redirect:/board/list";

		if (info.getMemberIdx()!=dto.getMemberIdx()
				&& !info.getUserId().equals("admin"))
			return "redirect:/board/list";

		// 자료 삭제
		service.deleteBoard(boardNum);

		return "redirect:/board/list?page=" + page;
	}

	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int boardNum,
			@RequestParam String page,
			Model model,
			HttpSession session
			) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}

		Board dto = service.readBoard(boardNum);
		if (dto == null) {
			return "redirect:/board/list";
		}

		if (info.getMemberIdx()!=dto.getMemberIdx())
			return "redirect:/board/list";

		model.addAttribute("subMenu", "3");
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);

		return ".four.menu4.board.created";
	}

	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	public String updateSubmit( 
			Board board,
			@RequestParam String page,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}

		// 수정 하기
		service.updateBoard(board);

		return "redirect:/board/list?page=" + page;
	}

	@RequestMapping(value="/board/reply", method=RequestMethod.GET)
	public String replyForm(
			@RequestParam int boardNum,
			@RequestParam String page,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}
		
		Board dto = service.readBoard(boardNum);
		if (dto == null) {
			return "redirect:/board/list?page="+page;
		}

		String str = "["+dto.getSubject()+"] 에 대한 답변입니다.\n";
		dto.setContent(str);

		model.addAttribute("subMenu", "3");
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "reply");

		return ".four.menu4.board.created";
	}

	@RequestMapping(value="/board/reply", method = RequestMethod.POST)
	public String replySubmit(
			Board dto,
		    @RequestParam String page,
		    HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) {
			return "redirect:/member/login";
		}

		dto.setMemberIdx(info.getMemberIdx());
		service.insertBoard(dto, "reply");

		return "redirect:/board/list?page="+page;
	}
}
