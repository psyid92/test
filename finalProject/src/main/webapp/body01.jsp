<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<style>
#gesipan table, #gesipan td, #gesipan a {
	background-color: white;
}
#gesipan table {
	margin: 23.5px 44.75px;
	border: 4px solid gray;
	outline: 2px solid black;
}

</style>
<div style="width: 979px; height: 200px; margin: 0 auto 30px;">
	<img src="./resource/img/banner01.gif" style="width: 100%; height: 100%;">
</div>
<div id="bodyMenu" align="center" style="width: 979px; margin: 0 auto 30px;">
	<table>
		<tr>
			<td rowspan="2">
				<img src="./resource/img/chinese.png" width="303px" height="496px;">
			</td>
			<td>
				<img src="./resource/img/chinese.png">
			</td>
			<td>
				<img src="./resource/img/chinese.png">		
			</td>
		</tr>
		<tr>
			<td>
				<img src="./resource/img/chinese.png">
			</td>
			<td>
				<img src="./resource/img/chinese.png">
			</td>
		</tr>
	</table>
</div>

<div style="width: 979px; height: 400px; margin: 0 auto 30px;" id="gesipan">
	<table style="width: 400px; height: 153px; float: left;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				공지사항
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				[공지] 멤버쉽 등급 및 혜택 안내
			</td>
			<td>
				2017-06-19
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				안녕하세요. 사이트이름입니다. 현재 시행중인 회원제 선정기준 및 혜택 에 대해 안내 드립니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>


	<table style="width: 400px; height: 153px; float: right;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				맛집리뷰 게시판
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				내닉네임 | 맛있어요♡
			</td>
			<td>
				2017-06-05
			</td>
		</tr>
		<tr>
			<td style="font-size: 13px;">
				치킨이 친절하고 사장님이 맛있습니다!<br>                
			</td>
			<td align="right">
				★★★★☆
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>
	<table style="width: 400px; height: 153px; float: left;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				이벤트
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				[이벤트] 오늘 하루 치킨이 반값!
			</td>
			<td>
				2017-06-21
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				안녕하세요. 사이트이름입니다. 오늘은 치킨의 날로써 모든 치킨이 반값이오니 많은 주문 바랍니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>


	<table style="width: 400px; height: 153px; float: right;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				F A Q
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-weight: bold;">
				내닉네임 | [질문] 아이디를 잊어버렸습니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				[답변] 앞으로 우리 싸이트 이용하지 마요.                
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>
</div>

