<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">
<style type="text/css">
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>

</head>
<body>

<div style="width:300px; margin: 30px auto;">
	<ul>
		<li><a href="<%=cp%>/tour/tour" style="font-size: 13pt; font-weight: bold; ">도시선택</a></li>
		<li><a href="<%=cp%>/tour/manage" style="font-size: 13pt; font-weight: bold; ">도시관리</a></li>
	</ul>
</div>

</body>
</html>