<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.listFriend {
	float:left;
	width:180px;
	height:240px;	
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border:1px solid #ccc;
}
</style>

<script type="text/javascript">
$(function(){
	friend("list");
});

//탭을 선택 한 경우
$(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		var active=$(this).attr("aria-controls");
		friend(active);
	});	
});

function friend(mode) {
	var url="<%=cp%>/friend/"+mode;
	
	$.get(url, {dumi:new Date().getTime()}, function(data){
		var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;	
		}
		var id="#tabFriendList";
		if(mode=="add")
			id="#tabFriendAdd";
		else if(mode=="block")
			id="#tabFriendBlock";
			
		$(id).html(data);
	});
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-user"></span> 친구관리 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 소중한 친구를 관리하는 공간 입니다.
    </div>

    <div>
	    <div role="tabpanel">
			  <ul class="nav nav-tabs" role="tablist">
			      <li role="presentation"  class="active"><a href="#tabFriendList" aria-controls="list" role="tab" data-toggle="tab">친구목록</a></li>
		          <li role="presentation"><a href="#tabFriendAdd" aria-controls="add" role="tab" data-toggle="tab">친구추가</a></li>
		          <li role="presentation"><a href="#tabFriendBlock" aria-controls="block" role="tab" data-toggle="tab">차단관리</a></li>
			  </ul>
			
			  <div class="tab-content" style="padding: 5px; margin-top: 15px;">
			      <div role="tabpanel" class="tab-pane active" id="tabFriendList"></div>
			      <div role="tabpanel" class="tab-pane" id="tabFriendAdd"></div>
			      <div role="tabpanel" class="tab-pane" id="tabFriendBlock"></div>
			  </div>
	    </div>
    </div>
    
</div>