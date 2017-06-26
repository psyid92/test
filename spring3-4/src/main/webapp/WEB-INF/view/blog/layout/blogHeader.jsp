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

function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/nblog";
	f.submit();
}
</script>

<div class="blog-main-header-top">
              <div style="float: left;">
                     <a href="<%=cp%>/">
                        <span style="color: #424951; font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">SPRING</span>
                     </a>
              </div>
              <div style="float: left; text-align: center; padding: 0px 30px;">
                     <form name="searchForm" action="" method="post">
                         <input type="text" name="search" placeholder="통합검색" class="boxTF" style="width: 210px;">
                         <button type="button" class="btn1" onclick="searchList()" style="line-height: 18px;">검색</button>
                     </form>
              </div>
              <div style="float: right; text-align: right;">
					    <a href="<%=cp%>/nblog/me">내 블로그</a>
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
        
<div class="blog-main-header-menu">
                <ul class="nav">
                     <li class="list-menu-item"><a href="<%=cp%>/nblog?idx=0">블로그 홈</a></li>                
                     <li class="list-menu-item"><a href="<%=cp%>/nblog?idx=1&theme=6">영화</a></li>
                     <li class="list-menu-item"><a href="<%=cp%>/nblog?idx=2&theme=23">맛집</a></li>
                     <li class="list-menu-item"><a href="<%=cp%>/nblog?idx=3&theme=22">여행</a></li>
                     <li class="list-menu-item"><a href="<%=cp%>/nblog?idx=4&theme=24">IT</a></li>
                     <li class="list-menu-item" style="float: right;"><a href="#">모든주제</a></li>
                </ul>
</div>