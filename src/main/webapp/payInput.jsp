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
<script type="text/javascript">
	function jumun() {
		var f = document.myForm;
		f.action
	}
</script>
</head>
<body>

	<form action="payTest.jsp" method="post" name="myForm">
		결제번호 : <input type="text" name="pay_Num"><br>
		이름 : <input type="text" name="name"><br>
		이메일 : <input type="text" name="email"><br>
		주문내용 : <input type="text" name="pay_Content"><br>
		총 금액 : <input type="text" name="pay_Pay"><br>
		고객전화 : <input type="text" name="pay_Tel"><br>
		배달주소 : <input type="text" name="pay_Zip"><br>
		기업 명 : <input type="text" name="pay_Giup"><br>
		
		<button type="button" onclick="jumun()">주문하기</button>
	</form>

</body>
</html>