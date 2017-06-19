<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.category-list {
	text-align:left;
}
.category-list ul{
	padding: 0px;
	list-style: none;
}
.category-list li{
	font-family: "Malgun Gothic", "Nanum Gothic", "Dotum";
	height: 22px;
	line-height: 22px;
}
.category-list .li-item{
	cursor: pointer;
}
.category-list .li-item:hover{
	background: #eee;
}
.category-list .li-active{
	background:#ddd;
}
</style>

<script type="text/javascript">
// 왼쪽 카테고리를 선택한 경우
$(function(){
    $("body").on("click", ".category-list .li-item", function(){
        $(".category-list .li-item").each(function(){
        	$(this).removeClass("li-active");
        });
    	
    	$(this).addClass("li-active");
    	
    	var categoryNum=$(this).attr("data-categoryNum");
    	var url="${blogUrl}";
    	if(categoryNum!=""&&categoryNum!="0")
    		url+="?categoryNum="+categoryNum;

    	location.href=url;
    });
});

$(function(){
	listCategory();
});

// 카테고리 리스트
function listCategory() {
	var url="${blogUrl}/categoryAllList";
	var bid="${blogInfo.userId}";
	
	$.post(url, {bid:bid, tmp:new Date().getTime()}, function(data){
        var count=data.count;
        var str="<ul>";
        str+="<li><b>category</b> <span id='categoryCount'>("+count+")</span></li>";
        
        str+="<li class='li-item' style='padding-left: 10px;' data-categoryNum='0'  data-parent='0'>";
    	str+="전체보기";
    	str+="</li>";
        
        for(var idx=0; idx<data.listCategory.length; idx++) {
        	var categoryNum=data.listCategory[idx].categoryNum;
        	var classify=data.listCategory[idx].classify;
        	var parent=data.listCategory[idx].parent;
        	var closed=data.listCategory[idx].closed;
        	
        	if(categoryNum==1) // 공지
        		continue;
        	
        	if(parent==0) {
        		str+="<li class='li-item' style='padding-left: 10px;' data-categoryNum='"+categoryNum+"'  data-parent='"+parent+"'>";
        	} else {
        		str+="<li class='li-item' style='padding-left: 20px;' data-categoryNum='"+categoryNum+"'  data-parent='"+parent+"'>";
        	}
        	str+="<img src='<%=cp%>/resource/images/icon_list.gif' border='0'>&nbsp;";
        	str+=classify;
        	str+="</li>";
        }
    	str+="</ul>";
        $(".category-list").html(str);
        
   }, "json");
}

// 포스트 글쓰기 폼
function postInsert() {
	var url="${blogUrl}/postInsert";
	$.get(url, {temp:new Date().getTime()}, function(data){
		$("#blog-content").html(data);
	});
}

function profile() {
	var url="${blogUrl}/profile";
	$.get(url, {temp:new Date().getTime()}, function(data){
		$("#blog-content").html(data);
	});
	
}
</script>

<div class="blog-left">
     <div class="profile-photo">
          <c:if test="${empty  blogInfo.photoFilename}">
              <img src="<%=cp%>/resource/images/noimage.png" width="164" height="164">
          </c:if>
          <c:if test="${not empty  blogInfo.photoFilename}">
              <img src="<%=cp%>/uploads/blog/${blogInfo.userId}/${blogInfo.photoFilename}" width="164" height="164">
          </c:if>
     </div>
     <div style="padding: 10px 2px 5px; white-space:pre;">${blogInfo.introduce}</div>
     <c:if test="${blogInfo.userId==sessionScope.member.userId}">
         <div style="padding: 5px 2px; text-align: center;">
             [<a href="javascript:postInsert();"><b>포스트 글쓰기</b></a>]
         </div>
     </c:if>
     <div style="padding: 5px 2px; text-align: center;">
             <a href="javascript:profile()">프로필</a>
             <c:if test="${blogInfo.userId!=sessionScope.member.userId}">
                 | <a href="">이웃추가</a>
             </c:if>
             <c:if test="${blogInfo.userId==sessionScope.member.userId}">
                  | <a href="${blogUrl}/manage">관리</a>
             </c:if>
             | <a href="">쪽지</a>
     </div>
</div>

<div class="blog-left">
    <div class="category-list"></div>
</div>
