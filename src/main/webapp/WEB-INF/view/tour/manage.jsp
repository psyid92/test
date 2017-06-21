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
<style type="text/css">
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}

.btnDelete{
    display: inline-block; width: 50px; text-align: right; cursor: pointer;
}

.sidoLayout{
    border: 1px solid #ccc; margin: 5px 0px; padding: 5px;
}
.sido{
    display: inline-block; width: 220px; cursor: pointer;
}

.cityLayout{
    border-top: 1px solid #ccc; padding: 5px 5px 0px;
    display: none;
}
.city{
    display: inline-block; width: 200px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(function(){
    $("body").on("click", ".sido", function(){
    	var isHidden = $(this).parent().next().is(':hidden');
    	var snum=$(this).attr("data-snum");
    	$(".cityLayout").hide();
    	
		if(isHidden) {
			$.post("<%=cp%>/tour/cityList.do", {snum:snum}, function(data){
				$("#listCity"+snum).empty();
				var out="";
				for(var i=0; i<data.list.length; i++) {
					var cnum=data.list[i].cnum;
					var city=data.list[i].city;
					
					if(i==0)
						out+="<div id='city"+cnum+"' style='border: 1px solid #ccc; padding: 5px;'>";
					else
						out+="<div id='city"+cnum+"' style='border: 1px solid #ccc; padding: 5px; border-top:none;'>";
					out+="<span class='city'>"+city+"</span>&nbsp;";
					out+="<span class='btnDelete' onclick=\"deleteCity('"+snum+"', '"+cnum+"');\">삭제</span>";
					out+="</div>";
				}
				$("#listCity"+snum).html(out);
			}, "json");
			
			$(this).parent().next().show();
			
		} else {
			$(this).parent().next().hide();
		}
    });

/*	
   // 동적이 아닌 경우 
	$(".sido").each(function(index){
		$(this).click(function(){
			var isHidden = $(".cityLayout").eq(index).is(':hidden');
			$(".cityLayout").hide();
			
			if(isHidden)
				$(".cityLayout").eq(index).show();
			else
				$(".cityLayout").eq(index).hide();
		});
	});
*/

});

// 시도 추가
function insertSido() {
	var sido=$("#sidoName").val();
	if(! sido) {
		$("#sidoName").focus();
		return;
	}
	
	$.post("<%=cp%>/tour/insertSido", {sido:sido}, function(data){
		var snum;
		var state=data.state;
		if(state=="false") {
			alert("시도 중복등으로 추가하지 못했습니다.");
			return;
		}
		snum=data.snum;
		$("#sidoName").val("");
		
		var s="<div id='sido"+snum+"' class='sidoLayout'>";
		s+="<div style='padding: 5px;'>";
		s+="<span class='sido'>"+sido+"</span>&nbsp;";
		s+="<span class='btnDelete' onclick=\"deleteSido('"+snum+"');\">삭제</span>";
		s+="</div>";
		s+="<div class='cityLayout'>";
		s+="<div style='margin: 10px 3px;'>";
		s+="<input type='text' id='cityName"+snum+"' class='boxTF' style='width:190px;'>&nbsp;";
		s+="<button type='button' onclick=\"insertCity('"+snum+"');\" class='btn'>도시추가</button>";
		s+="</div>";
		s+="<div id='listCity"+snum+"'></div>";
		s+="</div>";
		
		$("#listSidoLayout").append(s);
		
	}, "json");
	
}

// 시도 삭제
function deleteSido(snum) {
	if(! confirm("시도를 삭제하시겠습니까?")) {
		return;
	}
	
	$.post("<%=cp%>/tour/deleteSido", {snum:snum}, function(data){
		if(data.state=="false") {
			alert("시도 삭제가 실패했습니다.");
			return;
		}
		
		$("#sido"+snum).remove();
		
	},"json");
}

// 도시 추가
function insertCity(snum) {
	var city=$("#cityName"+snum).val();
	
	if(! city) {
		$("#cityName"+snum).focus();
		return;
	}
	
	$.post("<%=cp%>/tour/insertCity", {snum:snum, city:city}, function(data){
		var cnum;
		var state=data.state;
		if(state=="false") {
			alert("도시 중복등으로 추가하지 못했습니다.");
			return;
		}
		cnum=data.cnum;
		$("#cityName"+snum).val("");
		
		// 자식 노드 개수
		var cnt= $("#listCity"+snum).children().size();
		
		var out="";
		if(cnt==0)
			out+="<div id='city"+cnum+"' style='border: 1px solid #ccc; padding: 5px;'>";
		else
			out+="<div id='city"+cnum+"' style='border: 1px solid #ccc; padding: 5px; border-top:none;'>";
		out+="<span class='city'>"+city+"</span>&nbsp;";
		out+="<span class='btnDelete' onclick=\"deleteCity('"+snum+"', '"+cnum+"');\">삭제</span>";
		out+="</div>";
		
		$("#listCity"+snum).append(out);
		
	}, "json");
}

// 도시 삭제
function deleteCity(snum, cnum) {
	if(! confirm("도시를 삭제하시겠습니까?")) {
		return;
	}
	
	$.post("<%=cp%>/tour/deleteCity", {cnum:cnum}, function(data){
		if(data.state=="false") {
			alert("도시 삭제가 실패했습니다.");
			return;
		}
		
		$("#city"+cnum).remove();
		
		$("#listCity"+snum).children().first().css("border-top", "1px solid #ccc");
		
	}, "json");
	
}
</script>
</head>
<body>

<div style="margin: 50px auto 10px; width:350px; min-height: 300px;">
    <div class="title">ㆍ시도 및 도시 관리</div>
    
    <div style="margin-top: 20px;">
         <input type="text" id="sidoName" class="boxTF" style="width: 210px;">
         <button type="button" onclick="insertSido();" class="btn">시도추가</button>
    </div>
    
    <div id="listSidoLayout" style="margin-top: 20px;">
         <c:forEach var="dto" items="${list}">
              <div id="sido${dto.snum}" class="sidoLayout">
                    <div style="padding: 5px;">
              		    <span class="sido" data-snum="${dto.snum}">${dto.sido}</span>
              		    <span class="btnDelete" onclick="deleteSido('${dto.snum}');">삭제</span>
              		 </div>
              		 <div class="cityLayout">
              		      <div style="margin: 10px 3px;">
                             <input type="text" id="cityName${dto.snum}" class="boxTF" style='width:190px;'>
                             <button type="button" onclick="insertCity('${dto.snum}');" class="btn">도시추가</button>
                         </div>
                         <div id="listCity${dto.snum}"></div>
              		 </div>
              </div>  
         </c:forEach>
    </div>
</div>

</body>
</html>