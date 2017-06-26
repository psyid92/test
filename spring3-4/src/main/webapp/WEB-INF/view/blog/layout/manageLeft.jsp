<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.sub-menu ul{
	padding: 0px;
	list-style: none;
}
.sub-menu li{
	font-family: "Malgun Gothic", "Nanum Gothic", "Dotum";
	height: 23px;
	line-height: 23px;
	padding: 5px;
	font-size:13px;
	border-bottom: 1px solid #ccc;	
}
.sub-menu .li-menu{
	cursor: pointer;
	padding-left: 15px;
}
.sub-menu .li-menu:hover{
	background: #eee;
}
.sub-menu .li-menu-active{
	background:#ddd;
}
</style>

<script type="text/javascript">
$(function(){
    $("body").on("click", ".sub-menu .li-menu", function(){
        $(".sub-menu .li-menu").each(function(){
        	$(this).removeClass("li-menu-active");
        });
    	
    	$(this).addClass("li-menu-active");
     });
});

function manage() {
	var url="${blogUrl}/manage";
	location.href=url;
}

function manageBoard() {
	var url="${blogUrl}/manageBoard";
	$.get(url, {tmp:new Date().getTime()}, function(data){
		if($.trim(data)=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		} else if($.trim(data)=="blogFail") {
			location.href="<%=cp%>/nblog";
			return;
		}
		$("#manage-content").html(data);
	});
}

function deleteBlog() {
	if(confirm("블로그를 삭제 하시겠습니까 ?")) {
		var url="${blogUrl}/deleteBlog";
		location.href=url;
	}
}

function updateBlog() {
	var url="${blogUrl}/updateBlog";
	$.get(url, {tmp:new Date().getTime()}, function(data){
		if($.trim(data)=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		} else if($.trim(data)=="blogFail") {
			location.href="<%=cp%>/nblog";
			return;
		}
		$("#manage-content").html(data);
	});
}
</script>

<div class="blog-left" style="min-height: 600px;">
   <div class="sub-menu">
        <ul>
            <li style="height: 30px; line-height: 30px; font-size: 16px;"><b>블로그 관리</b></li>
            <li class="li-menu" onclick="manage();">블로그 정보</li>
            <li class="li-menu" onclick="manageBoard();">게시판 관리</li>
            <li class="li-menu" onclick="updateBlog();">블로그 수정</li>
            <li class="li-menu" onclick="deleteBlog();">블로그 삭제</li>                     
        </ul>
    </div>
</div>
