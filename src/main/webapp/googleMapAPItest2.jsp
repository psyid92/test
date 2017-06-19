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
<title>google API test</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
* {
	margin: 0;
	padding: 0;
}

html, body {
	width: 400px;
	height: 400px;
	padding: 100px;
}
</style>
</head>
<body>
	당산역, kh정보교육원 위치
	<br>
	<div id="map"></div>
	
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlFRnxU1iPDVB1Lckdl_w-4eI7CrNvOio&libraries=places"></script>
	
	<script>
      function initMap() {
    	navigator.geolocation.getCurrentPosition (function (pos){
    	var myLatLng = {lat: 37.534815, lng: 126.902645};
    	var myLatLng2 = {lat: 37.533720, lng: 126.896921}; 
    		lat = pos.coords.latitude;
    		lng = pos.coords.longitude; 
    	var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: {lat: 37.5392375, lng: 126.9003409}
        });
        
        var marker = new google.maps.Marker({
        	position: myLatLng,
        	label: '당산역',
        	map: map,
        	title: '당산역'
        });
        var marker = new google.maps.Marker({
        	position: myLatLng2,
        	label: 'kh',
        	map: map,
        	title: 'kh정보교육원 당산'
        });
        var marker = new google.maps.Marker({
        	position: new google.maps.LatLng(lat,lng),
        	label: '내위치',
        	map: map,
        	title: '현재위치'
        });
      });
	}
    </script>
</body>
</html>