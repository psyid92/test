<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<c:if test="${replyCount!=0}">
<script type="text/javascript">
// 댓글별 답글 리스트
function listAnswer(answer) {
	var rta="#listAnswer"+answer;
	var url="<%=cp%>/blog/${blogSeq}/postListReplyAnswer";
	$.post(url, {answer:answer}, function(data){
		$(rta).html(data);
	});
}

// 댓글별 답글 갯수
function countAnswer(answer) {
	var url="<%=cp%>/blog/${blogSeq}/postReplyCountAnswer";
	$.post(url, {answer:answer}, function(data){
		var count=data.count;
		var btnAnswerCount="#btnAnswerCount"+answer;
		var btnAnswerIcon="#btnAnswerIcon"+answer;
		
		$(btnAnswerCount).html(count);
		$(btnAnswerIcon).html("▲");
	}, "JSON");
}

// 댓글별 답글 폼
function replyAnswerForm(replyNum) {
	var id="#layoutAnswer"+replyNum;
	var rta="#rta"+replyNum;
	var btnAnswerIcon="#btnAnswerIcon"+replyNum;
	
	if($(id).is(':hidden')) {
		$("[id*=layoutAnswer]").hide();
		
		$("[id*=btnAnswerIcon]").each(function(){
			$(this).html("▼");
		});
		
		listAnswer(replyNum);
		countAnswer(replyNum);
		
		$(id).show();
		// $(rta).focus();
		$(btnAnswerIcon).html("▲");
	}  else {
		$(id).hide();
		$(btnAnswerIcon).html("▼");
	}
}

// 댓글별 답글 추가
function sendReplyAnswer(num, replyNum) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	var rta="#rta"+replyNum;
	var content=$.trim($(rta).val());
	if(! content ) {
		alert("내용을 입력하세요 !!!\n");
		$(rta).focus();
		return false;
	}
	
	var query="num="+num;
	query+="&content="+content;
	query+="&answer="+replyNum;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/blog/${blogSeq}/postCreatedReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$(rta).val("");
			
  			var state=data.state;
			if(state=="true") {
				listAnswer(replyNum);
				countAnswer(replyNum);
			} else if(state=="false") {
				alert("답글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

// 댓글별 답글 삭제
function deleteReplyAnswer(replyNum, answer) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/blog/${blogSeq}/postDeleteReply";
		$.post(url, {replyNum:replyNum, mode:"answer"}, function(data){
		        var state=data.state;
				if(state=="loginFail") {
					login();
				} else {
				    listAnswer(answer);
				    countAnswer(answer);
				}
		}, "json");
	}
}
</script>

<table style='width: 100%; margin: 15px 0px 0px; border-spacing: 0px; border-collapse: collapse;'>
	<tr height='40'>
		<td width='50%' style='padding-left: 5px;'>
		    <span style='color: #3EA9CD; font-weight: bold;'>댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span>
		</td>
		<td width='50%' align='right' style='padding-right: 5px;'>&nbsp;</td>
	</tr>

<c:forEach var="vo" items="${listReply}">
	<tr height='30'  style='border: 1px solid #C3C3C3;'>
		<td width='50%' style='padding-left: 5px;'>
		   ${vo.userName}
		</td>
		<td width='50%' align='right' style='padding-right: 5px;'>
		   ${vo.created }
<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">		   
		   | <a onclick='deleteReply("${vo.replyNum}", "${pageNo}");'>삭제</a>
</c:if>		   
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">		   
		   | <a href='#'>신고</a>
</c:if>		   
		</td>
	</tr>
	<tr height='50'>
		<td colspan='2' style='padding: 10px 5px;' valign='top'>
		    ${vo.content}
		</td>
	</tr>
	<tr>
	    <td colspan='2' style="padding: 0px 10px;">
	        <div style='clear: both; height: 30px; margin-bottom: 5px;'>
	            <div style='float: left;'>
	                 <button type="button" class="btn1" onclick="replyAnswerForm('${vo.replyNum}')">답글 <span id="btnAnswerCount${vo.replyNum}">${vo.answerCount}</span> <span id="btnAnswerIcon${vo.replyNum}">▼</span></button>
	            </div>
	            <div style='float: right;'>
	                  <button type="button" class="btn1" onclick="sendLike('${vo.replyNum}', '1')">좋아요 <span id="btnLike${vo.replyNum}">${vo.likeCount}</span></button>
	                  <button type="button" class="btn1" onclick="sendLike('${vo.replyNum}', '0')">싫어요 <span id="btnDisLike${vo.replyNum}">${vo.disLikeCount}</span></button>
	            </div>
	        </div>
	            
	        <div id="layoutAnswer${vo.replyNum}" style="clear: both; display: none;">
	            <div id="listAnswer${vo.replyNum}" style="clear: both;"></div>
	            
	            <div style="clear: both; height: 130px; margin-bottom: 5px;">
                     <div style="clear: both; padding-top: 10px;">
                          <textarea id="rta${vo.replyNum}" class="boxTF" rows="3" style="display:block; width: 100%; padding: 6px 12px; box-sizing:border-box;"></textarea>
                     </div>
                     <div style="text-align: right; padding-top: 10px;">
                          <button type="button" class="btn1" onclick="sendReplyAnswer('${vo.num}', '${vo.replyNum}')"
                                       style="padding:8px 25px;"> 등록하기 </button>
                     </div>
	            </div>
	            
	        </div>
	    </td>
	</tr>
</c:forEach>
</table>

<table style='width: 100%; margin: 5px auto 0px; border-spacing: 0px; border-collapse: collapse;'>
	<tr height='30'>
	   <td align='center'>
			${paging}
	   </td>
	</tr>
</table>

</c:if>