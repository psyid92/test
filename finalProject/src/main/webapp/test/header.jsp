<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script>
	$(function() {
		$("#headerMenu th").mouseover(function(){
		});
	});
</script>
<style type="text/css">
#headerMenu th:hover { background: #e87330;}
#headerMenu th:hover { color: white; }
body {
	background-color: #f4efe1;
}
#headerMenutr {
	background-color: #f7f2e2;
}
#headerMenu th {
	width: 195.8px;
}
</style>
	<div align="center" style="padding-bottom: 30px;">
		<div style="width: 444px; height: 91px; line-height: 91px; font-size: 40px; background-image:url('<%=cp%>/resource/img/title_back.png');">배 달 행</div>
 	</div>
 	<div style="width:979px; margin: auto; min-height: 100px; vertical-align: middle; display: table-ce" id="myGeo" align="center">
    <!-- 현재 위치 검색 버튼 - ajax로 반영 -->
       <button onclick="" type="button">현재위치검색</button>
       <input type="text" placeholder="위치를 입력해 주세요." style="min-width: 210px;">
    </div>
