<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">


</script>
<body style="background:#f4efe1; ">
 <div id="allBody" style="width:979px; max-width: 80%; margin: auto;">
    <div style="background: black; margin: auto; min-height: 100px; vertical-align: middle; display: table-ce" id="myGeo" align="center">
    <!-- 현재 위치 검색 버튼 - ajax로 반영 -->
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
</body>
</html>