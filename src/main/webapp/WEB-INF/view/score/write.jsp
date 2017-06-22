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
.line1 {
    border-bottom: 1px solid #cccccc;
} 
.lineTop2 {
    border-top: 2px solid #cccccc;border-bottom: 1px solid #cccccc;
}
.lineBottom2 {
    border-bottom: 2px solid #cccccc;
}
</style>

<script type="text/javascript">
function check() {
	var f=document.forms[0];
	
	if(! f.hak.value.trim()) {
        alert("\n필수 입력 사항 입니다. !!!");
        f.hak.focus();
        return false;
	}
	f.hak.value=f.hak.value.trim();
	
	if(! f.name.value.trim()) {
        alert("\n필수 입력 사항 입니다. !!!");
        f.name.focus();
        return false;
	}
	f.name.value=f.name.value.trim();
	
    if(!/[12][0-9]{3}-[0-9]{2}-[0-9]{2}/.test(f.birth.value)) {
        alert("\n날짜 형식이 유효하지 않습니다. ");
        f.birth.focus();
        return false;
	}
	
    if(!/^(\d+)$/.test(f.kor.value)) {
            alert("\n숫자만 가능합니다. ");
            f.kor.focus();
            return false;
    }
    
    if(!/^(\d+)$/.test(f.eng.value)) {
        alert("\n숫자만 가능합니다. ");
        f.eng.focus();
        return false;
	}
    if(!/^(\d+)$/.test(f.mat.value)) {
        alert("\n숫자만 가능합니다. ");
        f.mat.focus();
        return false;
	}
	
    var mode="${mode}";
    if(mode=="insert")
        f.action="<%=cp%>/score/write";
    else if(mode=="update")
        f.action="<%=cp%>/score/update";
        
	return true;
}
</script>

</head>
<body>

<table style="width: 500px; margin: 30px auto 5px;">
<tr>
	<td align="center">
	    <span style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">성적처리</span>
	</td>
</tr>
</table>

<form method="post" onsubmit="return check();">
	<table style="width: 500px; margin: 10px auto 5px; border-spacing: 0px;">
	<tr height="25">
		<td width="100" align="center" class="lineTop2">학번</td>
		<td width="400" class="lineTop2">
			<input type="text" name="hak" class="boxTF" required="required"
			         ${mode=="update" ? "readonly='readonly' ":"" }
			         value="${dto.hak}">
		</td>
	</tr>

	<tr height="25">
		<td width="100" align="center" class="line1">이름</td>
		<td width="400" class="line1">
			<input type="text" name="name" class="boxTF" required="required"
			          value="${dto.name}">
		</td>
	</tr>
	
	<tr height="25">
		<td width="100" align="center" class="line1">생년월일</td>
		<td width="400" class="line1">
			<input type="date" name="birth" class="boxTF" required="required"
			           value="${dto.birth}">
		</td>
	</tr>
	
	<tr height="25">
		<td width="100" align="center" class="line1">국어</td>
		<td width="400" class="line1">
			<input type="number" name="kor" class="boxTF" required="required"
			           value="${dto.kor}">
		</td>
	</tr>

	<tr height="25">
		<td width="100" align="center" class="line1">영어</td>
		<td width="400" class="line1">
			<input type="number" name="eng" class="boxTF" required="required"
			           value="${dto.eng}">
		</td>
	</tr>
	
	<tr height="25">
		<td width="100" align="center" class="lineBottom2">수학</td>
		<td width="400" class="lineBottom2">
			<input type="number" name="mat" class="boxTF" required="required"
			          value="${dto.mat}">
		</td>
	</tr>
	
	<tr height="35">
		<td width="100" align="center" colspan="2">
				<input type="submit" class="btn" value=" ${mode=='insert'?'등록완료':'수정완료'} ">
				<input type="reset" class="btn" value="다시입력">
				<input type="button" class="btn" value=" ${mode=='insert'?'등록취소':'수정취소'} "
				     onclick="javascript:location.href='<%=cp%>/score/list';">

		        <c:if test="${mode=='update' }">
		           <input type="hidden" name="page"
		                     value="${page}"> 
		        </c:if>
		</td>
	</tr>
	
	<tr height="35">
		<td width="100" align="center" colspan="2">
		      ${msg}
		</td>
	</tr>
	</table>
</form>

</body>
</html>