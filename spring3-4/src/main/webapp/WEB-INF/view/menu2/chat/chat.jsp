<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

   String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
#chatMsgContainer{
   clear:both;
   border: 1px solid #ccc;
   height: 275px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
}
#chatMsgContainer p{
   padding-bottom: 0px;
   margin-bottom: 0px;
}
#chatConnectList{
	clear:both;
	width: 100%;
	height: 310px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
}
</style>

<script type="text/javascript">
// ---------------------------------------------
$(function(){
	var socket=null;
	
	// 채팅 서버(IP 주소를 사용 해야함)
	//   ws://ip주소:포트번호/cp/chat.msg
	var host="<%=wsURL%>";
	// var host='wss://' + window.location.host + '/wchat.msg';  // https
	
	if ('WebSocket' in window) {
		socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
    	socket = new MozWebSocket(host);
    } else {
    	writeToScreen('Your browser does not support WebSockets');
        return false;
    }

	socket.onopen = function(evt) { onOpen(evt) };
	socket.onclose = function(evt) { onClose(evt) };
	socket.onmessage = function(evt) { onMessage(evt) };
	socket.onerror = function(evt) { onError(evt) };
	
	 // 서버 접속이 성공한 경우 호출되는 콜백함수
	function onOpen(evt) {
	    var userId = "${sessionScope.member.userId}";
	    var nickName = "${sessionScope.member.userName}";
	    if(! userId) {
	    	location.href="<%=cp%>/member/login";
	    	return;
	    }
	    
		writeToScreen("채팅방에 입장했습니다.");
	    
	    // 서버 접속이 성공 하면 아이디와 이름을 JSON으로 서버에 전송
	    var obj = {};
	    var jsonStr;
	    obj.cmd="connect";
	    obj.userId=userId;
	    obj.nickName=nickName;
	    jsonStr = JSON.stringify(obj);  // JSON.stringify() : 자바스크립트 값을 JSON 문자열로 변환
	    socket.send(jsonStr);
	    
	    // 채팅입력창에 메시지를 입력하기 위해 키를 누르면 호출되는 콜백함수
	    $("#chatMsg").on("keydown",function(event) {
	    	// 엔터키가 눌린 경우, 서버로 메시지를 전송한다.
	        if (event.keyCode == 13) {
	            sendMessage();
	        }
	    });
	}

	// 연결이 끊어진 경우에 호출되는 콜백함수
	function onClose(evt) {
		// 채팅 입력창 이벤트를 제거 한다.
       	$("#chatMsg").on("keydown",null);
       	writeToScreen('Info: WebSocket closed.');
	}

	// 서버로부터 메시지를 받은 경우에 호출되는 콜백함수
	function onMessage(evt) {
    	// JSON으로 전송 받는다.
    	var data=JSON.parse(evt.data); // JSON 파싱
    	
    	var cmd=data.cmd;
    	
    	if(cmd=="connectList") { // 처음 접속할때 접속자 리스트를 받는다.
    		var userId=data.userId;
    		var nickName=data.nickName;
    		
    		var sp="<span style='display: block;' id='guest-"+userId+"'>"+userId+"("+nickName+")<span>";
    		$("#chatConnectList").append(sp);
    		
    	} else if(cmd=="connect") { // 다른 접속자가 접속했을 때
    		var userId=data.userId;
    		var nickName=data.nickName;
    		
    		var s=userId+"("+nickName+") 님이 입장하였습니다.";
    		writeToScreen(s);
    		
    		var sp="<span style='display: block;' id='guest-"+userId+"'>"+userId+"("+nickName+")<span>";
    		$("#chatConnectList").append(sp);
    		
    	} else if(cmd=="disconnect") { // 접속자가 나갔을 때
    		var userId=data.userId;
    		var nickName=data.nickName;
    		
    		var s=userId+"("+nickName+") 님이 나가셨습니다.";
    		writeToScreen(s);
    		
    		$("#guest-"+userId).remove();

    	} else if(cmd=="message") { // 메시지를 받은 경우
    		var userId=data.userId;
    		var nickName=data.nickName;
    		var msg=data.chatMsg;
    		
    		writeToScreen(nickName+"] " + msg);
    	}
	}

	// 에러가 발생시 호출되는 콜백함수
	function onError(evt) {
		writeToScreen('Info: WebSocket error.');
	}
	
	// 메시지 전송
	function sendMessage() {
	    var message = $("#chatMsg").val().trim();
	    if (message!="") {
	        var obj = {};
	        var jsonStr;
	        obj.cmd="message";
	        obj.chatMsg=message;
	        jsonStr = JSON.stringify(obj);
	        socket.send(jsonStr);
	        
	        $("#chatMsg").val("");
	        writeToScreen("보냄] "+message);
	    }		
	}
});
//---------------------------------------------

// 채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
    var $chatContainer = $("#chatMsgContainer");
    $chatContainer.append("<p/>");
    $chatContainer.find("p:last").css("wordWrap","break-word"); // 강제로 끊어서 줄 바꿈
    $chatContainer.find("p:last").html(message);

    // 추가된 메시지가 50개를 초과하면 가장 먼저 추가된 메시지를 한개 삭제
    while ($chatContainer.find("p").length > 25) {
    	$chatContainer.find("p:first").remove();
	}

    // 스크롤을 최상단에 있도록 설정함
    $chatContainer.scrollTop($chatContainer.prop("scrollHeight"));
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-send"></span> 채팅 <small>Chatting</small></h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 회원과 실시간으로 대화를 나룰수 있는 공간 입니다.
    </div>
    
    <div style="clear: both;">
        <div style="float: left; width: 350px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅 메시지</span>
             </div>
             <div id="chatMsgContainer"></div>
             <div style="clear: both; padding-top: 5px;">
                 <input type="text" id="chatMsg" class="form-control" 
                            placeholder="채팅 메시지를 입력 하세요...">
             </div>
        </div>
        
        <div style="float: left; width: 20px;">&nbsp;</div>
        
        <div style="float: left; width: 170px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">접속자 리스트</span>
             </div>
             <div id="chatConnectList"></div>
        </div>
    </div>
 
 </div>