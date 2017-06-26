package com.sp.common;

import org.springframework.stereotype.Service;

@Service("myUtil")
public class MyUtilBootstrap extends MyUtil {
    //********************************************
	// 페이징(paging) 처리(GET 방식) : 부트스트랩
	@Override
	public String paging(int current_page, int total_page, String list_url) {
		StringBuffer sb=new StringBuffer();
		
		int numPerBlock=10;
		int currentPageSetup;
		int n, page;
		
		if(current_page<1 || total_page < 1)
			return "";
		
		if(list_url.indexOf("?")!=-1)
			list_url+="&";
		else
			list_url+="?";
		
		// currentPageSetup : 표시할첫페이지-1
		currentPageSetup=(current_page/numPerBlock)*numPerBlock;
		if(current_page%numPerBlock==0)
			currentPageSetup=currentPageSetup-numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
		// 처음페이지
		if(current_page > 1) {
			sb.append("<li><a href='"+list_url+"page=1' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
		// 이전(10페이지 전)
		n=current_page-numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a href='"+list_url+"page="+n+"' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}
		
		// 바로가기
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a href='"+list_url+"page="+page+"'>"+page+"</a></li>");
			}
			page++;
		}
		
		// 다음(10페이지 후)
		n=current_page+numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a href='"+list_url+"page="+n+"' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
		// 마지막페이지
		if(current_page<total_page) {
			sb.append("<li><a href='"+list_url+"page="+total_page+"' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
		
		sb.append("</ul>");
	
		return sb.toString();
	}

    //********************************************
	// javascript 페이지 처리(javascript listPage() 함수 호출) : 부트스트랩
	@Override
    public String paging(int current_page, int total_page) {
		if(current_page < 1 || total_page < 1)
			return "";

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetup;
        int n;
        int page;
        StringBuffer sb=new StringBuffer();
        
        // 표시할 첫 페이지
        currentPageSetup = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
        	currentPageSetup = currentPageSetup - numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
        
        // 처음페이지
		if(current_page > 1) {
			sb.append("<li><a onclick='listPage(1);' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
        // 이전(10페이지 전)
        n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a onclick='listPage("+n+");' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}

        // 바로가기 페이지 구현
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a onclick='listPage("+page+");'>"+page+"</a></li>");
			}
			page++;
		}
        
        // 다음(10페이지 후)
        n = current_page + numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a onclick='listPage("+n+"); aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
        // 마지막 페이지
		if(current_page<total_page) {
			sb.append("<li><a onclick='listPage("+total_page+");' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
        
        sb.append("</ul>");

        return sb.toString();
    }

    //********************************************
	// javascript 페이지 처리(javascript 지정 함수 호출, methodName:호출할 스크립트 함수명) : 부트스트랩
	@Override
    public String pagingMethod(int current_page, int total_page, String methodName) {
		if(current_page < 1 || total_page < 1)
			return "";

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetup;
        int n;
        int page;
        StringBuffer sb=new StringBuffer();
        
        // 표시할 첫 페이지
        currentPageSetup = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
        	currentPageSetup = currentPageSetup - numPerBlock;

		sb.append("<ul class='pagination pagination-sm'>");
        
        // 처음페이지
		if(current_page > 1) {
			sb.append("<li><a onclick='"+methodName+"(1);' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='First'><span aria-hidden='true' class='glyphicon glyphicon-step-backward'></span></a></li>");
		}
        // 이전(10페이지 전)
        n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<li><a onclick='"+methodName+"("+n+");' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true' class='glyphicon glyphicon-triangle-left'></span></a></li>");
		}

        // 바로가기 페이지 구현
		page=currentPageSetup+1;
		while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("<li class='active'><a href='#'>"+page+" <span class='sr-only'>(current)</span></a></li>");
			} else {
				sb.append("<li><a onclick='"+methodName+"("+page+");'>"+page+"</a></li>");
			}
			page++;
		}
        
        // 다음(10페이지 후)
        n = current_page + numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<li><a onclick='"+methodName+"("+n+"); aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true' class='glyphicon glyphicon-triangle-right'></span></a></li>");
		}
        // 마지막 페이지
		if(current_page<total_page) {
			sb.append("<li><a onclick='"+methodName+"("+total_page+");' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		} else {
			sb.append("<li class='disabled'><a href='#' aria-label='Last'><span aria-hidden='true' class='glyphicon glyphicon-step-forward'></span></a></li>");
		}
        
        sb.append("</ul>");

        return sb.toString();
    }
}
