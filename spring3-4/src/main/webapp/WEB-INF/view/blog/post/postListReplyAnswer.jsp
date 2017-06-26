<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<c:if test="${not empty listReplyAnswer}">

<table style='width: 100%; margin: 0px; border-spacing: 0px; border-collapse: collapse;'>
<c:forEach var="vo" items="${listReplyAnswer}">
	<tr height='30' style='border: 1px solid #C3C3C3;'>
		<td width='50%' style="padding-left: 5px;">
		   ${vo.userName}
		</td>
		<td width='50%' align='right' style='padding-right: 5px;'>
		   ${vo.created }
<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">   
		   | <a onclick='deleteReplyAnswer("${vo.replyNum}", "${vo.answer}");'>삭제</a>
</c:if>
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">   
		   | <a href='#'>신고</a>
</c:if>
		</td>
	</tr>

	<tr height='50'>
		<td colspan='2' style='padding: 10px 5px;' valign='top'>
		    ${vo.content}
		</td>
	</tr>
</c:forEach>

</table>

</c:if>