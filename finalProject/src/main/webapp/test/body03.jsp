<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<style>
#weather {
	background-color: black;
	color: white;
}
</style>
<body style="background:#f4efe1; ">
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
 <div id="allBody" style="width:979px; max-width: 80%; margin: auto;">
    <div style="background: black; margin: auto; min-height: 100px; vertical-align: middle; display: table-ce" id="myGeo" align="center">
    <!-- 현재 위치 검색 버튼 - ajax로 반영 -->
       <button onclick="" type="button">현재위치검색</button>
       <input type="text" placeholder="위치를 입력해 주세요." style="min-width: 210px;">
    </div>
    <hr>
    
    <table style="width: 100%;">
       <tr style="height: 100px; ">
          <td width="10%;">포토</td>
          <td width="20%;">업체명</td>
          <td width="20%;">품목</td>
          <td width="30%;">위치</td>
          <td width="20%;">별점</td>
       </tr>
       <tr style="height: 100px; ">
          <td width="10%;">포토</td>
          <td width="20%;">업체명</td>
          <td width="20%;">품목</td>
          <td width="30%;">위치</td>
          <td width="20%;">별점</td>
       </tr>
       <tr style="height: 100px; ">
          <td width="10%;">포토</td>
          <td width="20%;">업체명</td>
          <td width="20%;">품목</td>
          <td width="30%;">위치</td>
          <td width="20%;">별점</td>
       </tr>
    </table>
    
 </div>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>