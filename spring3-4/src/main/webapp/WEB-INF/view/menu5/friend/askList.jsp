<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<c:forEach var="dto" items="${friendAskList}">
  <span>
       &nbsp;<a href="javascript:askDelete('${dto.num}');"><img src="<%=cp%>/resource/images/icon-minus.png" border="0"></a>&nbsp;
       ${dto.friendUserName}(${dto.friendUserId})
  </span>
  <br>
</c:forEach>