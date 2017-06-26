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
function deleteBoard(num) {
	if (confirm("위 자료를 삭제 하시겠습니까?")) {
		var url = "<%=cp%>/mybbs/delete?num=" + num + "&page=${page}";
		location.href=url;
	}	
}
</script>
</head>
<body>
	<table>
		<tr>
			<td>
				${dto.subject}
			</td>
		</tr>
		<tr>
			<td>
				이름 : ${dto.name}
			</td>
			<td>
				${dto.created} | 조회 ${dto.hitCount}
			</td>
		</tr>
		<tr>
			<td>
				${dto.content}
			</td>
		</tr>
		<tr>
			<td>
				이전글 :
				<c:if test="${not empty preReadDto}">
					<a href="<%=cp%>/mybbs/article?num=${preReadDto.num}&${query}">${preReadDto.subject}</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				다음글 :
				<c:if test="${not empty nextReadDto}">
					<a href="<%=cp%>/mybbs/article?num=${nextReadDto.num}&${query}">${nextReadDto.subject}</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				From : ${dto.ipAddr}
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<button type="button" onclick="javascript:location.href='<%=cp%>/mybbs/update?num=${dto.num}&page=${page}';">수정</button>
				<button type="button" onclick="deleteBoard('${dto.num}')">삭제</button>
			</td>
			<td>
				<button type="button" onclick="javascript:location.href='<%=cp%>/mybbs/list?${query}';">리스트</button>
			</td>
		</tr>
	</table>
</body>
</html>