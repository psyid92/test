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

	<form action="<%=cp%>/demo/write" method="post">
		아이디 : <input type="text" name="id"><br>
		이름 : <input type="text" name="name"><br>
		생일 : <input type="text" name="birth"><br>
		전화 : <input type="text" name="tel"><br>
		<button>보내기</button>
	</form>

</body>
</html>