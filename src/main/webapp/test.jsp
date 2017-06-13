<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>getCurrentPosition + Googlemap marker </title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlFRnxU1iPDVB1Lckdl_w-4eI7CrNvOio&callback=initMap" async defer></script>
<script type="text/javascript">
    function fnGetCurrentPosition() {
        if (navigator.geolocation)
        {
            $("#latlng").html("");
            $("#errormsg").html("");
            navigator.geolocation.getCurrentPosition (function (pos)
            {
                lat = pos.coords.latitude;
                lng = pos.coords.longitude;
 
                $("#latlng").html("latitude : " + lat + "longitude : "+ lng);
 
                var mapOptions = {
                    zoom: 16,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(lat,lng)
                };
 
                map = new google.maps.Map(document.getElementById('map'),mapOptions);
 
                var myIcon = new google.maps.MarkerImage("http://google-maps-icons.googlecode.com/files/restaurant.png", null, null, null, new google.maps.Size(17,17));
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(lat,lng),
                    map: map,
                    draggable: false,
                    icon: myIcon
                });
                markers.push(marker);
            },function(error)
            {
                switch(error.code)
                {
                    case 1:
                        $("#errormsg").html("User denied the request for Geolocation.");
                        break;
                    case 2:
                        $("#errormsg").html("Location information is unavailable.");
                        break;
                    case 3:
                        $("#errormsg").html("The request to get user location timed out.");
                        break;
                    case 0:
                        $("#errormsg").html("An unknown error occurred.");
                        break;
                }
            });
        }
        else
        {
            $("#errormsg").html("Geolocation is not supported by this browser.");
        }
    }
</script>
</head>
<body>
<div id="errormsg"></div>
<div id="latlng"></div>
<input type="button" value="GetCurrentPosition " onclick="Javascript:fnGetCurrentPosition();" />
<div id="map" style="width:760px;height:400px;margin-top:20px;"></div>
</body>
</html>