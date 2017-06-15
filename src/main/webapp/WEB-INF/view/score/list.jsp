<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<style type="text/css">
* {
	margin: 0px; padding: 0px;
}
body {
	font-size: 9pt; font-family: 돋움;
}
a {
	cursor: pointer;
	color: #000000;
	text-decoration: none;
	font-size: 9pt;
	line-height: 150%;
}

a:hover, a:active {
	font-size: 9pt;
	color: #F28011;
	text-decoration: underline;
}
.btn {
    font-size: 9pt; color:rgb(0,0,0); 
    border:1px solid #AAAAAA; 
    background-color:rgb(255, 255, 255); 
    padding:0px 7px 3px 7px; 
    font-family: 나눔고딕, 맑은 고딕, 굴림;
}
.boxTF {
    border:1px solid #666666;
    height:13px;
    width:120px;
    margin-top:7px; margin-bottom:5px;
    padding:3px 2px 3px 2px;
    background-color:#ffffff;
    font-family:'돋움';
    font-size:9pt;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/score/list";
	f.submit();
}

function deleteScore(hak) {
	var url="<%=cp%>/score/delete?hak=" + hak + "&page=${page}";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function updateScore(hak) {
	var url="<%=cp%>/score/update?hak=" + hak + "&page=${page}";
	location.href=url;
}

function check() {
	var f=document.scoreListForm;
	
	if(f.haks==undefined)
		return;
	
	if(f.haks.length!=undefined) { // 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.chkAll.checked)
				f.haks[i].checked=true;
			else
				f.haks[i].checked=false;
		}
	} else { // 체크박스가 하나인 경우
		if(f.chkAll.checked)
			f.haks.checked=true;
		else
			f.haks.checked=false;
	}
}

function deleteList() {
	var f=document.scoreListForm;
	var cnt=0;
	
	if(f.haks==undefined) {
		return false;		
	}
	
	if(f.haks.length!=undefined) {// 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.haks[i].checked)
				cnt++;
		}
	} else {
		// 체크박스가 하나인 경우
		if(f.haks.checked)
			cnt++;
	}
	
	if(cnt==0) {
		alert("선택한 게시물이 없습니다.");
		return false;
	}
	
	if(confirm("선택한 게시물을 삭제하시겠습니까 ? ")) {
		f.action="<%=cp%>/score/deleteList";
		f.submit();
	}
}

</script>

</head>
<body>

<form name="searchForm" method="post">
<table style="width: 700px; margin: 30px auto 0px;">
<tr height="50">
	<td align="center" colspan="2">
	    <span style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">성적처리</span>
	</td>
</tr>
<tr height="25">
	<td width="70%">
		<input type="button" value="삭제" class="btn" id="deleteListBtn" onclick="deleteList();">
	    &nbsp;
		<select name="searchKey">
		    <option value="hak">학번</option>
		    <option value="name">이름</option>
		    <option value="birth">생년월일</option>
		</select>
		<input type="text" name="searchValue" class="boxTF">
        <input type="button" value="검색" class="btn" onclick="searchList();">
	</td>
	<td align="right">
		<input type="button" value="등록하기" class="btn"
		       onclick="javascript:location.href='<%=cp%>/score/write';">
	</td>
</tr>
</table>
</form>

<form name="scoreListForm" method="post">
<table border="1"  style="width: 700px; margin: 0px auto; border-collapse: collapse; border-spacing: 0;">
<tr height="25" align="center" bgcolor="#E4E6E4">
	<td width="50">
		<input type="checkbox" id="chkAll" name="chkAll" onclick="check();">
		<input type="hidden" name="page" value="${page}">
	</td>
	<td width="60">학번</td>
	<td width="90">이름</td>
	<td width="80">생년월일</td>
	<td width="60">국어</td>
	<td width="60">영어</td>
	<td width="60">수학</td>
	<td width="60">총점</td>
	<td width="60">평균</td>
	<td width="120">변경</td>
</tr>

<c:forEach var="dto" items="${list}">
<tr height="25" align="center">
    <td><input type="checkbox" name="haks"
                 value="${dto.hak}">
    </td>
    <td>${dto.hak}</td>
    <td>${dto.name}</td>
    <td>${dto.birth}</td>
    <td>${dto.kor}</td>
    <td>${dto.eng}</td>
    <td>${dto.mat}</td>
    <td>${dto.tot}</td>
    <td>${dto.ave}</td>
    <td>
         <a href="javascript:updateScore('${dto.hak}');">수정</a> |
         <a href="javascript:deleteScore('${dto.hak}');">삭제</a>
    </td>
</tr>
</c:forEach>

</table>

</form>

<table style="width: 700px; margin: 10px auto;">
<tr height="30" align="center">
	<td>
		${paging}
	</td>
</tr>
</table>

</body>
</html>