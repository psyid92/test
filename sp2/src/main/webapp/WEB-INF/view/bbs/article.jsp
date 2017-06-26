<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
	.btnLike {
		color: #333333;
		font-weight: 500;
		border: 1px solid #cccccc;
		background: #ffffff;
		text-align: center;
		cursor: pointer;
		padding: 6px 10px 5px;
		border-radius: 4px;
	}
</style>

<script type="text/javascript">
function deleteBoard() {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
	var num = "${dto.num}";
	var page = "${page}";
	var query = "num=" + num + "&page=" + page;
	var url = "<%=cp%>/bbs/delete?" + query;

	if (confirm("위 자료를 삭제 하시겠습니까 ? "))
		location.href = url;
	</c:if>
	<c:if test="${sessionScope.member.userId!='admin' || sessionScope.member.userId!=dto.userId}">
		alert("게시물을 삭제할 수 없습니다.")
	</c:if>
}

function updateBoard() {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	  var num = "${dto.num}";
	  var page = "${page}";
	  var query = "num="+num+"&page="+page;
	  var url = "<%=cp%>/bbs/update?" + query;
	  location.href=url;
	</c:if>
	<c:if test="${sessionScope.member.userId!=dto.userId}">
	 alert("게시물을 수정할 수  없습니다.");
	</c:if>
}
</script>

<script>
	$(function(){
		listPage(1);
	});
	
	function listPage(page) {
		var url="<%=cp%>/bbs/listReply";
		var num="${dto.num}";
		
		// text/html
		$.post(url, {num:num, pageNo:page}, function(data){
			$("#listReply").html(data);
		});
	}

	// 게시물 공감 추가 및 개수
	function sendLikeBoard(num) {
		var msg = "게시물에 공감하십니까 ?";
		if (!confirm(msg))
			return;
		
		var query = "num=" + num;
		var url = "<%=cp%>/bbs/insertLikeBoard";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state = data.state;
				if (state == "true") {
					var count = data.countLikeBoard;
					$("#countLikeBoard").html(count);
				} else if (state == "false") {
					alert("공감은 한번만 가능합니다.");
				} else if (state == "loginFail"){
					location.href = "<%=cp%>/member/login"
				}
			}
			,error:function(e) {
				console.log(e.responseText);
			}
		});
	}
	
	function sendReply() {
		var num = "${dto.num}";
		var content = $("#replyContent").val().trim();
		if (!content) {
			$("#replyContent").focus();
			return;
		}
		
		// var query=$("form[name=replyForm]").serialize();
		var query = "num=" + num;
		query += "&content=" + encodeURIComponent(content);
		query += "&answer=0";
		
		$.ajax({
			type:"post"
			,url:"<%=cp%>/bbs/createdReply"
			,data:query
			,dataType:"json"
			,success:function(data){
				var state=data.state;
				$("#replyContent").val("");
								
				if (state=="true") {
					listPage(1);
				} else if (state=="false") {
					alert("댓글을 추가하지 못했습니다.");
				} else if (state=="loginFail") {
					location.href="<%=cp%>/member/login";
				}
			}
			,beforeSend : function(e) {
				e.setRequestHeader("AJAX", true);
			}
			,error:function(e) {
				if (e.status == 403) {
					location.href="<%=cp%>/member/login";
					return;
				}
				console.log(e.responseText);
			}
			
		});
	}
	
	function deleteReply(replyNum, page) {
		var msg = "댓글을 삭제 하시겠습니까 ? ";
		if (!confirm(msg))
			return;
		
		var url="<%=cp%>/bbs/deleteReply";
		$.post(url, {replyNum:replyNum, mode:"reply"}, function(data){
			listPage(page);
		}, "json");
	}
	
</script>
</head>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> 게시판 </h3>
    </div>
    
    <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.userName}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created} | 조회 ${dto.hitCount}
			    </td>
			</tr>
			
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="center" style="padding-bottom: 15px;">
					<button type="button" class="btnLike" onclick="sendLikeBoard('${dto.num}')">&nbsp;&nbsp;<span style="font-family: Wingdings;">C</span>&nbsp;&nbsp;<span id="countLikeBoard">${countLikeBoard}</span></button>	
				</td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       첨&nbsp;&nbsp;부 :
			       <c:if test="${not empty dto.saveFilename}">
			       	<a href="<%=cp%>/bbs/download?num=${dto.num}">${dto.originalFilename}</a>
			       </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			       <c:if test="${not empty preReadDto}">
		 			<a href="<%=cp%>/bbs/article?num=${preReadDto.num}&${query}">${preReadDto.subject}</a>
       			   </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
				   <c:if test="${not empty nextReadDto}">
		 			<a href="<%=cp%>/bbs/article?num=${nextReadDto.num}&${query}">${nextReadDto.subject}</a>
       			   </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			          <button type="button" class="btn" onclick="updateBoard();">수정</button>
			          <button type="button" class="btn" onclick="deleteBoard();">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/bbs/list';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
    <div>
            <table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
            <tr height='30'> 
	            <td align='left'>
	            	<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
	            </td>
            </tr>
            <tr>
               <td style='padding:5px 5px 0px;'>
                    <textarea id='replyContent' class='boxTA' style='width:99%; height: 70px;'></textarea>
                </td>
            </tr>
            <tr>
               <td align='right'>
                    <button type='button' class='btn' style='padding:10px 20px;' onclick='sendReply();'>댓글 등록</button>
                </td>
            </tr>
            </table>
            
            <div id="listReply"></div>
 	 </div>
    
</div>