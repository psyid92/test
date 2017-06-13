package com.sp.score;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("score.scoreController")
public class ScoreController {
	@Autowired
	private ScoreService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping("/score/list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "searchKey", defaultValue = "hak") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue, HttpServletRequest req,
			Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		int rows = 5;
		int dataCount, total_page;
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		map.put("start", start);
		map.put("end", end);

		List<Score> list = service.listScore(map);

		String cp = req.getContextPath();
		String listUrl = cp + "/score/list";

		if (searchValue.length() != 0) {
			listUrl += "?searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return "score/list";
	}

	@RequestMapping(value = "/score/write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {

		model.addAttribute("mode", "insert");
		return "score/write";
	}

	@RequestMapping(value = "/score/write", method = RequestMethod.POST)
	public String writeSubmit(Score dto, Model model) throws Exception {
		int result = service.inserScore(dto);
		if (result == 0) {
			model.addAttribute("msg", "자료를 추가하지 못했습니다.");
			model.addAttribute("mode", "insert");
			return "score/write";
		}

		return "redirect:/score/list";
	}

	@RequestMapping(value = "/score/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam String hak, @RequestParam String page, Model model) throws Exception {

		Score dto = service.readScore(hak);
		if (dto == null) {
			return "redirect:/score/list?page=" + page;
		}

		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		return "score/write";
	}

	@RequestMapping(value = "/score/update", method = RequestMethod.POST)
	public String updateSubmit(Score dto, @RequestParam String page, Model model) throws Exception {
		service.updateScore(dto);
		return "redirect:/score/list?page=" + page;
	}
	
	@RequestMapping("/score/delete")
	public String delete(@RequestParam String hak, @RequestParam String page) throws Exception {
		service.deleteScore(hak);
		
		return "redirect:/score/list?page=" + page;
	}
	
	@RequestMapping("/score/deleteList")
	public String deleteList(String []haks, @RequestParam String page) throws Exception {
		
		List<String> list = Arrays.asList(haks); // 배열을 List로 변환
		service.deleteScoreList(list);
		
		return "redirect:/score/list?page=" + page;
	}

}
