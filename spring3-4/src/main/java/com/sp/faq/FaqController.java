package com.sp.faq;

import java.net.URLDecoder;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("faq.faqController")
public class FaqController {
	@Autowired
	private FaqBoardService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/faq/faq")
	public String faq(
			@RequestParam(value="category", defaultValue="0") int categoryNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		List<FaqBoard> listFaqCategory=service.listFaqCategory();
		
		model.addAttribute("subMenu", "1");
		model.addAttribute("category", categoryNum);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("listFaqCategory", listFaqCategory);
		
		return ".four.menu4.faq.faq";
	}
	
	@RequestMapping(value="/faq/list")
	public String list(
			@RequestParam(value="category", defaultValue="0") int categoryNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model,
			HttpServletRequest req
			) throws Exception {
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("categoryNum", categoryNum);
        map.put("searchValue", searchValue);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);

        List<FaqBoard> list = service.listFaq(map);
        Iterator<FaqBoard> it=list.iterator();
        while(it.hasNext()) {
        	FaqBoard dto=it.next();
        	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
        }

        model.addAttribute("subMenu", "1");
        model.addAttribute("list", list);
        model.addAttribute("pageNo", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("category", categoryNum);
        model.addAttribute("paging", myUtil.paging(current_page, total_page));
		
		return "menu4/faq/list";
	}
	
	@RequestMapping(value="/faq/created", method=RequestMethod.GET)
	public String createdForm(
			@RequestParam(value="category", defaultValue="0") int categoryNum,
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null)
			return "redirect:/member/login";
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/faq/faq?category=" + categoryNum;
		
		List<FaqBoard> listCategory=service.listCategory();
		List<FaqBoard> listFaqCategory=service.listFaqCategory();

		model.addAttribute("subMenu", "1");
		model.addAttribute("category", categoryNum);
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("listFaqCategory", listFaqCategory);
		model.addAttribute("mode", "created");
		return ".four.menu4.faq.created";
	}

	@RequestMapping(value="/faq/created", method=RequestMethod.POST)
	public String createdSubmit(
			FaqBoard dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null)
			return "redirect:/member/login";
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/faq/faq?category=" +dto.getCategoryNum();
		
		dto.setUserId(info.getUserId());
		service.insertFaq(dto);
		
		return "redirect:/faq/faq?category=" + dto.getCategoryNum();
	}
	
	@RequestMapping(value="/faq/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String pageNo,
			@RequestParam(value="category", defaultValue="0") int categoryNum,
			Model model,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null)
			return "redirect:/member/login";
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/faq/faq?category=" + categoryNum;

		FaqBoard dto = service.readFaq(num);
			
		if(dto==null) {
			return "redirect:/faq/faq?category=" + categoryNum;
		}
			
		List<FaqBoard> listCategory=service.listCategory();
		List<FaqBoard> listFaqCategory=service.listFaqCategory();

		model.addAttribute("subMenu", "1");
		
		model.addAttribute("category", categoryNum);
		model.addAttribute("listCategory", listCategory);			
		model.addAttribute("listFaqCategory", listFaqCategory);			
		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);
		
		return ".four.menu4.faq.created";
	}

	@RequestMapping(value="/faq/update", 
			method=RequestMethod.POST)
	public String updateSubmit( 
	               FaqBoard faq,
	               @RequestParam String pageNo,
	               @RequestParam(value="category", defaultValue="0") int categoryNum,
	               HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null)
			return "redirect:/member/login";
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/faq/faq?category="+categoryNum+"&pageNo="+pageNo;

		service.updateFaq(faq);
		
		return "redirect:/faq/faq?category="+categoryNum+"&pageNo="+pageNo;
	}
	
	@RequestMapping(value="/faq/delete")
	public String delete(
			@RequestParam(value="num") int num,
			@RequestParam(value="pageNo") String pageNo,
			@RequestParam(value="category", defaultValue="0") int categoryNum,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null)
			return "redirect:/member/login";
		
		if(! info.getUserId().equals("admin"))
			return "redirect:/faq/faq?category="+categoryNum+"&pageNo="+pageNo;

		// 자료 삭제
		service.deleteFaq(num);

		return "redirect:/faq/faq?category="+categoryNum+"&pageNo="+pageNo;
	}
	
	//-------------------------------------------
	@RequestMapping(value="/faq/categoryCreated", 
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryCreated(
				@RequestParam(value="classify") String classify,
				HttpServletRequest req) throws Exception {
		int categoryNum=0, dataCount=0;

		String state="false";
		
		dataCount=service.dataCountCategory();
		if(dataCount<10) {
			FaqBoard faq=new FaqBoard();
			faq.setCategoryNum(categoryNum);
			faq.setClassify(classify);
			
			int result=service.insertCategory(faq);
			if(result==1)
				state="true";
		}
		
		req.setAttribute("state", state);
		return categoryList(req);
	}
	
	@RequestMapping(value="/faq/categoryList")
	@ResponseBody
	public Map<String, Object> categoryList(HttpServletRequest req) throws Exception {
		List<FaqBoard> list=service.listCategory();
		
		// 카테고리 추가 및 삭제에서 상태
		String state = (String)req.getAttribute("state");
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("list", list);
		return model;
	}
	
	@RequestMapping(value="/faq/categoryDelete")
	@ResponseBody
	public Map<String, Object> categoryDelete(
			@RequestParam(value="categoryNum") int categoryNum,
			HttpServletRequest req) throws Exception {
		String state="true";
		
		int result=service.deleteCategory(categoryNum);
		if(result==0)
			state="false";
		
		req.setAttribute("state", state);
		return categoryList(req);
	}
}
