<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	if (typeof String.prototype.trim !== 'funtion') {
		String.prototype.trim = function() {
			var TRIM_PATTERN = /(^\s*)|(\s*&)/g;
			return this.replace(TRIM_PATTERN, "");
		};
	}
	
	function sendBoard() {
		var f = document.boardForm;
		
		var str = f.subject.value;
		if (!str) {
			alert("제목을 입력하세요.")
			f.subject.focus();
			return;
		}
		
		var str = f.name.value;
		if (!str) {
			alert("이름을 입력하세요.")
			f.name.focus();
			return;
		}
		
		var str = f.content.value;
		if (!str) {
			alert("내용을 입력하세요.")
			f.content.focus();
			return;
		}
		
		var str = f.pwd.value;
		if (!str) {
			alert("패스워드를 입력하세요.")
			f.pwd.focus();
			return;
		}
		
		var mode = "${mode}";
		if (mode=="created")
			f.action = "<%=cp%>/mybbs/created";
		else if(mode=="update")
			f.action = "<%=cp%>/mybbs/update";
		
		f.submit();
	}
	
</script>
</head>
<body>
	<form name="boardForm" method="post">
		<table>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="subject" value="${dto.subject}">
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="name" value="${dto.name}">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="content" rows="12">${dto.content}</textarea>
				</td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td>
					<input type="password" name="pwd">
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>
					<button type="button" onclick="sendBoard();">
						${mode=='created'?"등록하기":"수정하기"}
					</button>
					<button type="reset">다시입력</button>
					<button type="button" onclick="javascript:location.href='<%=cp%>/mybbs/list?page=${page}';">
						${mode=='created'?"등록취소":"수정취소"}
					</button>
					<input type="hidden" name="num" value="${dto.num}"> 
					<input type="hidden" name="page" value="${page}">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>