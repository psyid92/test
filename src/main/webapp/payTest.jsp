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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script type="text/javascript">
	var IMP = window.IMP; // 생략가능
	IMP.init('imp89184049'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명 : ${pay_Content}',
	    amount : ${pay_Pay}1,
	    buyer_email : '${email}',
	    buyer_name : '${name}',
	    buyer_tel : '${pay_Tel}',
	    buyer_addr : '${pay_Zip}',
	    buyer_postcode : '123-456',
	    m_redirect_url : 'googleMapAPItest.jsp'
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        $("#pay_allContent").show();
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
</script>
</head>
<body>
	<div id="pay_allContent">
		<input type="hidden" value="${pay_Num}">
		<input type="hidden" value="${name}">
		<input type="hidden" value="${email}">
		<input type="hidden" value="${pay_Content}">
		<input type="hidden" value="${pay_Pay}">
		<input type="hidden" value="${pay_Tel}">
		<input type="hidden" value="${pay_Zip}">
		<input type="hidden" value="${pay_Giup}">
	</div>
</body>
</html>