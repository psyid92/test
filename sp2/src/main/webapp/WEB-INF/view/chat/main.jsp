<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
	/* 채팅 할 주소 */
	// String wsURL = "ws://" + request.getServerName() + ":" + request.getServerPort() + cp + "/chat.msg";
	String wsURL = "http://" + request.getServerName() + ":" + request.getServerPort() + cp + "/chat.msg";
%>

<style>
#chatMsgList {
	height: 280px;
	clear: both;
	border: 1px solid #cccccc;
	padding: 3px;
	overflow-y: scroll;
	width: 100%; 
}

#chatConnectList {
	height: 310px;
	clear: both;
	border: 1px solid #cccccc;
	padding: 3px;
	overflow-y: scroll;
	width: 100%;
}

#chatMsgList p{
	padding-bottom: 0px;
	margin-bottom: 0px;
}

#chatConnectList p{
	padding-bottom: 0px;
	margin-bottom: 0px;
}
</style>
<script src="<%=cp%>/resource/sockjs/sockjs.min.js"></script>
<script>
$(function() {
	// IE8 지원, 프로토콜은 ws가 아닌 http
	
	var wsUrl = "<%=wsURL%>";
	var socket = null;
	
	// IE8 지원은 sockjs 라이브러리의 함수를 이용한다.
	// socket = new WebSocket(wsUrl);
	socket = new SockJS(wsUrl);
	
	socket.onopen = function(evt) {onConnect(evt);};
	socket.onclose = function(evt) {alert("연결 차단...");};
	socket.onmessage = function(evt) {onMessage(evt)};
	socket.onerror = function(evt) {};
	
	function onConnect(evt) {
		var uid = "${sessionScope.member.userId}";
		var nickName = "${sessionScope.member.userName}";
		var obj = {}; // 자바스크립트 객체
		var jsonStr;
		obj.cmd = "conn";
		obj.userId = uid;
		obj.nickName=nickName;
		// JSON으로 변환
		jsonStr = JSON.stringify(obj);
	
		socket.send(jsonStr);
		
		$("#chatMsg").on("keydown", function(event){
			if(event.keyCode == 13)
				sendMessage();
		});
		
	}
	
	function onMessage(evt) {
		// JSON 정보를 전송 받는다.
		var data = JSON.parse(evt.data);
		var cmd = data.cmd;
		
		if (cmd == "connect-list") {
			var userId = data.userId;
			var nickName = data.nickName;
			
			var s = "<p id='pList" + userId + "'>"+nickName + "(" + userId + ")</p>";
			$("#chatConnectList").append(s);
		} else if (cmd == "message") {
			var guestId = data.guestId;
			var nickName = data.nickName;
			var msg = data.message;
			
			var s = nickName + "> " + msg;
			writeToScreen(s);
		} else if (cmd == "disconn") {
			var guestId = data.guestId;
			var nickName = data.nickName;
			
			$("#pList" + guestId).remove();
			
			var s = nickName + "(" + guestId + ") 님이 저승으로 가셨습니다.";
			
			writeToScreen(s);
		} else if (cmd == "time") {
			var hour = data.hour;
			var minute = data.minute;
			var second = data.second;
			
			s = hour + " : " + minute + " : " + second;
			
			writeToScreen(s);
		}
	}
	
	function sendMessage() {
		var msg = $("#chatMsg").val().trim();
		if (!msg)
			return;
		
		var obj = {};
		var jsonStr;
		obj.cmd = "message";
		obj.message = msg;
		jsonStr = JSON.stringify(obj);
		socket.send(jsonStr);
		
		$("#chatMsg").val("");
		
		writeToScreen("보냄> " + msg);
		
	}
});

function writeToScreen(message) {
	var $chat = $("#chatMsgList");
	$chat.append("<p>");
	
	$chat.find("p:last").html(message);
	
	$chat.scrollTop($chat.prop("scrollHeight"));
}

</script>
<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> 채팅 </h3>
    </div>
    
	<div>
	    <div style="clear: both;">
			<div style="float: left; width: 350px;">
				<span style="display: block; padding-bottom: 10px; font-weight: 600;">* 채팅 문자열</span>
				<div id="chatMsgList"></div>
				<span style="display: block;">
					<input type="text" id="chatMsg" style="width: 98%;" class="boxTF" placeholder="채팅 문자열을 입력 하세요...">
				</span>
			</div>
			<div style="float: left; width: 30px;">&nbsp;</div>
			<div style="float: left; width: 250px;">
				<span style="display: block; padding-bottom: 10px; font-weight: 600;">* 접속자 리스트</span>
				<div id="chatConnectList"></div>
			</div>
		</div>
    </div>
</div>