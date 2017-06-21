<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>

<script type="text/javascript">
	$(function(){
		$("th").mouseover(function(){
			$(this).css("background", "#e87330");
		});
		$("th").mouseout(function(){
			$(this).css("background", "#f7f2e2");
		});
	});
</script>
<style type="text/css">

</style>
	<div align="center" style="padding-bottom: 30px;">
		<div style="width: 444px; height: 91px; background-image:url('<%=cp%>/resource/img/title_back.png');"></div>
 	</div>
 	<div>
 		<table style="margin: auto; text-align:center; width: 979px; height: 45px; border-collapse: collapse;">
 			<tr id="headerMenu">
 				<th id="menu" onclick="javascript:location.href='<%=cp%>/menu'">메뉴</th>
 				<th id="area" onclick="javascript:location.href='<%=cp%>/find'">주변 맛집</th>
            	<th id="weather" onclick="javascript:location.href='<%=cp%>/recommand'">날씨와 추천</th>
            	<th id="random" onclick="javascript:location.href='<%=cp%>/random'">랜덤주문</th>
            	<th id="customer" onclick="javascript:location.href='<%=cp%>/forUser'">고객센터</th>
 			</tr>
 		</table>
 	</div>
