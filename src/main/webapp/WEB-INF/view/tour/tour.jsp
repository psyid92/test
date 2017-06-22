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

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function cityList() {
	var snum=$("#sido").val();
	if(snum=="") {
		$("#city option").each(function() {
			$("#city option:eq(0)").remove();
		});

		$("#city").append("<option value=''>::도시선택::</option>");
		return false;
	}
	
	var url="<%=cp%>/tour/cityList";
	var params="snum="+snum;
	
	$.ajax({
		type:"post"
		,url:url
		,data:params
		,dataType:"json"
		,success:function(data){
			$("#city option").each(function() {
				$("#city option:eq(0)").remove();
			});

			 $("#city").append("<option value=''>::도시선택::</option>");
			 
			 for(var idx=0; idx<data.list.length; idx++) {
				 $("#city").append("<option value='"+data.list[idx].cnum+"'>"+data.list[idx].city+"</option>");
			 }
		}
	    ,error:function(e) {
	    	alert(e.responseText);
	    }
	});
}

function result() {
	var snum=$("#sido").val();
	var cnum=$("#city").val();
	var sido=$("#sido :selected").text();
	var city=$("#city :selected").text();

	if(! snum || !cnum)
		return false;
	
	var s=sido+":"+snum+", "+city+":"+cnum;
	alert(s);
}
</script>

</head>
<body>

    <div style="margin: 50px auto 10px; width:300px;">
	          <select id="sido" onchange="cityList();" class="selectField">
                   <option value="">::시도선택::</option>
                   <c:forEach var="dto" items="${list}">
                       <option value="${dto.snum}">${dto.sido}</option>
                   </c:forEach>
              </select>

              <select id="city" class="selectField">
                   <option value="">::도시선택::</option>
              </select>
              <button type="button" onclick="result();" class="btn">확인</button>
    </div>
    <div style="margin: 5px auto; width:300px;">
      <a href="<%=cp%>/tour/main">돌아가기</a>
    </div>

</body>
</html>