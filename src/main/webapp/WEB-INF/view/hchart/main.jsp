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
<style type="text/css">
* {
	margin:0px;
	padding:0px;
}

body {
	font-size: 9pt;
	font-family:돋움;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
// http://www.highcharts.com/demo

$(function(){
	var url="<%=cp%>/hchart/line1";
	$.getJSON(url, function (csv) {
		$('#lineContainer1').highcharts({
	        title: {
	            text: '서울 2015년 월별 평균 기온',
	        },
	        xAxis: {
	            categories: ['1월', '2월', '3월', '4월', '5월', '6월',
	                '7월', '8월', '9월', '10월', '11월', '12월']
	        },
	        yAxis: {
	            title: {
	                text: '기온 (°C)'
	            },
	        },
	        series:csv
		});
	});
});

$(function(){
	var url="<%=cp%>/hchart/line2";
	$.getJSON(url, function (csv) {
		var year=csv.year;
		
		$('#lineContainer2').highcharts({
	        title: {
	            text: year+'년 월별 평균 기온',
	        },
	        xAxis: {
	            categories: ['1월', '2월', '3월', '4월', '5월', '6월',
	                '7월', '8월', '9월', '10월', '11월', '12월']
	        },
	        yAxis: {
	            title: {
	                text: '기온 (°C)'
	            },
	        },
	        series:csv.series
		});
	});
});

$(function(){
	var url="<%=cp%>/hchart/bar";
	$.getJSON(url, function (csv) {
		var year=csv.year;
		
		$('#barContainer').highcharts({
			chart: {
	            type: 'column'
	        },			
	        title: {
	            text: year+'년 월별 평균 기온',
	        },
	        xAxis: {
	            categories: ['1월', '2월', '3월', '4월', '5월', '6월',
	                '7월', '8월', '9월', '10월', '11월', '12월']
	        },
	        yAxis: {
	            title: {
	                text: '기온 (°C)'
	            },
	        },
	        series:csv.series
		});
	});
});

$(function(){
	var url="<%=cp%>/hchart/pie3d";
	$.getJSON(url, function (csv) {
		$('#pie3dContainer').highcharts({
			chart: {
	            type: 'pie',
	            options3d: {
	                enabled: true,
	                alpha: 45
	            }
	        },			
	        title: {
	            text: '시간별 접속자 수',
	        },
	        plotOptions: {
	            pie: {
	                innerSize: 100,
	                depth: 45
	            }
	        },
	        series:csv
		});
	});
});

</script>

</head>
<body>

<div style="clear: both;">
    <div id="lineContainer1" 
            style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
    <div id="lineContainer2" 
            style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
</div>
<br><hr><br>

<div style="clear: both;">
    <div id="barContainer" 
            style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
    <div id="pie3dContainer" 
            style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
</div>

</body>
</html>