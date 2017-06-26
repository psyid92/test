<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
// 차단한 친구 - 수락
function friendBlockAccept() {
    var chks = $("#tbBlockList input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		return;
	}
    
	if(! confirm("선택한 친구를 수락 하시겠습니까 ? "))
		return;

	var url="<%=cp%>/friend/friendBlock";
    var query = "mode=blockAccept";
    $.each(chks, function(e, ch) {                    
    	query+="&numList="+$(ch).val();
    });
    
    $.ajax({
        type: "POST",
        url: url,
        data: query,
        dataType:"json",
        success: function(data){
        	var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}
        	
        	var state=data.state;
        	
        	// 수락된 친구 삭제
        	if(state=="true") {
	        	var userId;
	        	$.each(chks, function(e, ch) {
	        	   userId=$(ch).attr("data-userId");
	       	        $("#tbBlockList tr[data-tid='"+userId+"']").remove();
	       	    });
        	}
        },
        error: function(e){
            alert(e.responseText);
        }
    });
}

// 차단한 친구 - 삭제
function friendBlockDelete() {
    var chks = $("#tbBlockList input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		return;
	}
    
	if(! confirm("선택한 친구를 삭제 하시겠습니까 ? "))
		return;
	
	var url="<%=cp%>/friend/friendBlock";
    var query = "mode=blockDelete";
    $.each(chks, function(e, ch) {                    
    	query+="&numList="+$(ch).val();
    });
    
    $.ajax({
        type: "POST",
        url: url,
        data: query,
        dataType:"json",
        success: function(data){
        	var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}
			
        	var state=data.state;
        	
        	// 삭제된 친구 삭제
        	if(state=="true") {
	        	var userId;
	        	$.each(chks, function(e, ch) {
	        	   userId=$(ch).attr("data-userId");
	       	        $("#tbBlockList tr[data-tid='"+userId+"']").remove();
	       	    });
        	}
        },
        error: function(e){
            alert(e.responseText);
        }
    });
}

// 거절한 친구 - 수락
function friendDenialAccept() {
    var chks = $("#tbDenialList input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		return;
	}
    
	if(! confirm("선택한 친구를 수락 하시겠습니까 ? "))
		return;

	var url="<%=cp%>/friend/friendBlock";
    var query = "mode=denialAccept";
    $.each(chks, function(e, ch) {                    
    	query+="&numList="+$(ch).val();
    	query+="&userIdList="+$(ch).attr("data-userId");
    });
    
    $.ajax({
        type: "POST",
        url: url,
        data: query,
        dataType:"json",
        success: function(data){
        	var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}
        	
        	var state=data.state;
        	
        	// 수락된 친구 삭제
        	if(state=="true") {
	        	var userId;
	        	$.each(chks, function(e, ch) {
	        	   userId=$(ch).attr("data-userId");
	       	        $("#tbDenialList tr[data-tid='"+userId+"']").remove();
	       	    });
        	}
        },
        error: function(e){
            alert(e.responseText);
        }
    });
	
}
</script>

<div>
    <div style="clear: both;">
        <div style="float: left;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">차단한 친구</span>
             </div>
             
             <div class="listFriend">
                 <table style="border-spacing: 0px;">
              		<tbody id="tbBlockList">
              		    <c:forEach var="dto" items="${friendBlockList}">
	              		    <tr height='25' data-tid='${dto.friendUserId}'>
	              		         <td align='center' width='30'>
	              		             <input type='checkbox' value='${dto.num}' data-userId='${dto.friendUserId}'>
	              		         </td>
	              		         <td align='left' width='200'>
	              		             ${dto.friendUserName}(${dto.friendUserId})
	              		         </td>
	              		    </tr>
              		    </c:forEach>
              		</tbody>
                 </table>
             </div>
             
             <div style="clear: both; padding-top: 10px;">
                 <a class="btn btn-default btn-sm" href="javascript:friendBlockAccept();">수락</a>
                 <a class="btn btn-default btn-sm" href="javascript:friendBlockDelete();">삭제</a>
             </div>
        </div>
        
        <div style="float: left; padding: 0px 10px;">&nbsp;</div>
        
        <div style="float: left;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">거절한 친구</span>
             </div>
        
             <div class="listFriend">
                 <table style="border-spacing: 0px;">
              		<tbody id="tbDenialList">
              		    <c:forEach var="dto" items="${friendDenialList}">
	              		    <tr height='25'  data-tid='${dto.friendUserId}'>
	              		         <td align='center' width='30'>
	              		             <input type='checkbox' value='${dto.num}' data-userId='${dto.friendUserId}'>
	              		         </td>
	              		         <td align='left' width='200'>
	              		             ${dto.friendUserName}(${dto.friendUserId})
	              		         </td>
	              		    </tr>
              		    </c:forEach>
              		</tbody>
                 </table>
             </div>

             <div style="clear: both; padding-top: 10px;">
                 <a class="btn btn-default btn-sm" href="javascript:friendDenialAccept()">수락</a>
             </div>

        </div>
    </div>
</div>    
