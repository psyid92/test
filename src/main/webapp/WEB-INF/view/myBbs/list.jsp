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
function searchList() {
	var f = document.searchForm;
	f.action = "<%=cp%>/bbs/list";
	f.submit();
}
</script>
</head>
<body>
	<table>
		<tr>
			<td>
				${dataCount}개 (${page} / ${total_page} 페이지)
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="dto" items="${list}">
		<tr>
			<td>${dto.listNum}</td>
			<td>${dto.subject}</td>
			<td>${dto.name}</td>
			<td>${dto.created}</td>
			<td>${dto.hitCount}</td>
		</tr>
		</c:forEach>
	</table>
	
	<table>
		<tr>
			<td>
				${paging}
			</td>
		</tr>
	</table>
	
	<table>
		<tr>
			<td>	
				<form name="searchForm" method="post">
					<select name="searchKey">
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
						<option value="created">등록일</option>
					</select>
					<input type="text" name="searchValue">
					<button type="button" onclick="searchList()">검색</button>
				</form>
			</td>
		</tr>
		<tr>
			<td>
				<button type="button" onclick="javascript:location.href='<%=cp%>/mybbs/list';">새로고침</button>
				<button type="button" onclick="javascript:location.href='<%=cp%>/mybbs/created';">글올리기</button>
			</td>
		</tr>
	</table>
</body>
</html>