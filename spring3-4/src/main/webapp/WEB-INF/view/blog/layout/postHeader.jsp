<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	var idx="${menu}";
	if(!idx) idx=0;
	var menu=$(".list-menu-item")[idx];
	$(menu).addClass("active");
});

function guestbook() {
	$(".list-menu-item").each(function(){
    	$(this).removeClass("active");
    });
	var menu=$(".list-menu-item")[3];
	$(menu).addClass("active");
	
	var url="${blogUrl}/guest";
	$.get(url, {tmp:new Date().getTime()}, function(data){
		$("#blog-content").html(data);
	});
}

function photoView() {
	$(".list-menu-item").each(function(){
    	$(this).removeClass("active");
    });
	var menu=$(".list-menu-item")[2];
	$(menu).addClass("active");

	var url="${blogUrl}/photo";
	var owner="${owner}";
	var bid="${blogInfo.userId}";
	$.post(url, {bid:bid, owner:owner, tmp:new Date().getTime()}, function(data){
		$("#blog-content").html(data);
	});
}

function prologue() {
	var url="${blogUrl}/prologue";
	$.get(url, {tmp:new Date().getTime()}, function(data){
		$("#blog-content").html(data);
	});
}
</script>

<div class="blog-header-top">
              <div style="float: left;">
                     <a href="<%=cp%>/">
                        <span style="color: #424951; font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">SPRING</span>
                     </a>
              </div>
              <div style="float: right; text-align: right;">
                        <c:if test="${blogInfo.userId!=sessionScope.member.userId}">
						    <a href="<%=cp%>/nblog/me">내 블로그</a>
								&nbsp;|&nbsp;
						</c:if>
						<a href="">이웃 블로그</a>
									&nbsp;|&nbsp;					
						<a href="<%=cp%>/nblog">전체 블로그</a>
									&nbsp;|&nbsp;					
					    <c:if test="${empty sessionScope.member}">
							<a href="<%=cp%>/member/login">로그인</a>
						</c:if>
						<c:if test="${not empty sessionScope.member}">
								<span style="color:blue;">${sessionScope.member.userName}</span>님
								&nbsp;|&nbsp;
								<a href="<%=cp%>/member/logout">로그아웃</a>
						</c:if>
              </div>
</div>
        
<div class="blog-header-menu">
                <ul class="nav">
                     <li class="list-menu-item"><a href="${blogUrl}">블로그</a></li>
                     <li class="list-menu-item"><a href="${blogUrl}?menu=1&categoryNum=1">공지</a></li>
                     <li class="list-menu-item"><a href="javascript:photoView();">포토</a></li>
                     <li class="list-menu-item"><a href="javascript:guestbook();">방명록</a></li>
                     <li class="list-menu-item" style="float: right;"><a href="javascript:prologue();">프롤로그</a></li>
                </ul>
</div>
