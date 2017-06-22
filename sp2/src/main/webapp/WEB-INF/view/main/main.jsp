<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script>
	$(function(){
		info();
	});
	$(function(){
		setInterval("info()", 1000);
	});
	function info() {
		var url = "<%=cp%>/main/info";
		$.post(url, {}, function(data) {
			var hour = data.hour;
			var minute = data.minute;
			var second = data.second;
			
			var s = hour + " : " + minute + " : " + second;
			$("#infoLayout").html(s);
		}, "json");
	}
	
</script>

<div class="body-container" style="width: 700px;">
    <div>
    	메인 화면 입니다.<br><br><br>
        
        <div id="infoLayout"></div>
        
    </div>
</div>