<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
	
	<div id="body">
		<jsp:include page="body.jsp"/>
	</div>
	
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
<script src="http://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
</body>
</html>