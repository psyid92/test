<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bbs-article .table {
    margin-top: 15px;
}
.bbs-article .table thead tr, .bbs-article .table tbody tr {
    height: 30px;
}
.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
    font-weight: normal;
    border-top: none;
    border-bottom: none;
}
.bbs-article .table thead tr {
    border-top: #d5d5d5 solid 1px;
    border-bottom: #dfdfdf solid 1px;
} 
.bbs-article .table tbody tr {
    border-bottom: #dfdfdf solid 1px;
}
.bbs-article .table i {
    background: #424951;
    display: inline-block;
    margin: 0 7px 0 7px;
    position: relative;
    top: 2px;
    width: 1px;
    height: 13px;    
}

.bbs-reply {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bbs-reply-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>

<script type="text/javascript">
function deleteBoard() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var query = "num="+num+"&page="+page;
  var url = "<%=cp%>/bbs/delete?" + query;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
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

<script type="text/javascript">
//게시물 공감 개수
function countLikeBoard(num) {
	var url="<%=cp%>/bbs/countLikeBoard";
	$.post(url, {num:num}, function(data){
		var count=data.countLikeBoard;
		
		$("#countLikeBoard").html(count);
	}, "json");
}

// 게시물 공감 추가
function sendLikeBoard(num) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return;
	}

	msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return;
	
	var query="num="+num;

	$.ajax({
		type:"post"
		,url:"<%=cp%>/bbs/insertLikeBoard"
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				countLikeBoard(num);
			} else if(state=="false") {
				alert("좋아요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}

//-------------------------------------
// 댓글
function login() {
	location.href="<%=cp%>/member/login";
}

// 댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/bbs/listReply";
	var num="${dto.num}";
	$.post(url, {num:num, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

// 댓글 추가
function sendReply() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var num="${dto.num}"; // 해당 게시물 번호
	var content=$.trim($("#content").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#content").focus();
		return false;
	}
	
	var query="num="+num;
	query+="&content="+encodeURIComponent(content);
	query+="&answer=0";
	
	$.ajax({
		type:"post"
		,url:"<%=cp%>/bbs/createdReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#content").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}

// 댓글 삭제
function deleteReply(replyNum, page) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/bbs/deleteReply";
		$.post(url, {replyNum:replyNum, mode:"reply"}, function(data){
		        var state=data.state;

				if(state=="loginFail") {
					login();
				} else {
					listPage(page);
				}
		}, "json");
	}
}

// 댓글별 답글 리스트
function listAnswer(answer) {
	var listReplyAnswerId="#listReplyAnswer"+answer;
	var url="<%=cp%>/bbs/listReplyAnswer";
	$.post(url, {answer:answer}, function(data){
		$(listReplyAnswerId).html(data);
	});
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
function replyAnswerLayout(replyNum) {
	var id="#replyAnswerLayout"+replyNum;
	var replyContent="#replyContent"+replyNum;
	var answerGlyphiconId="#answerGlyphicon"+replyNum;
	
	if($(id).is(':hidden')) {
		$("[id*=replyAnswerLayout]").hide();
		
		$("[id*=answerGlyphicon]").each(function(){
			$(this).removeClass("glyphicon-triangle-top");
			$(this).addClass("glyphicon-triangle-bottom");
		});
		
		listAnswer(replyNum);
		countAnswer(replyNum);
		
		$(id).show();
		$(answerGlyphiconId).removeClass("glyphicon-triangle-bottom");
		$(answerGlyphiconId).addClass("glyphicon-triangle-top");
	}  else {
		$(id).hide();
		$(answerGlyphiconId).removeClass("glyphicon-triangle-top");
		$(answerGlyphiconId).addClass("glyphicon-triangle-bottom");
	}
}

// 댓글별 답글 등록
function sendReplyAnswer(num, replyNum) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	var rta="#replyContent"+replyNum;
	var content=$.trim($(rta).val());
	if(! content ) {
		alert("내용을 입력하세요 !!!\n");
		$(rta).focus();
		return false;
	}
	
	var query="num="+num;
	query+="&content="+encodeURIComponent(content);
	query+="&answer="+replyNum;
	
	$.ajax({
		type:"post"
		,url:"<%=cp%>/bbs/createdReply"
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
			console.log(e.responseText);
		}
	});
}

//댓글별 답글 갯수
function countAnswer(answer) {
	var url="<%=cp%>/bbs/replyCountAnswer";
	$.post(url, {answer:answer}, function(data){
		var count="("+data.count+")";
		var answerCountId="#answerCount"+answer;
		var answerGlyphiconId="#answerGlyphicon"+answer;
		
		$(answerCountId).html(count);
		$(answerGlyphiconId).removeClass("glyphicon-triangle-bottom");
		$(answerGlyphiconId).addClass("glyphicon-triangle-top");
	}, "json");
}

// 댓글별 답글 삭제
function deleteReplyAnswer(replyNum, answer) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/bbs/deleteReply";
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

// 댓글 좋아요/싫어요 개수
function countLike(replyNum) {
	var url="<%=cp%>/bbs/countLike";
	$.post(url, {replyNum:replyNum}, function(data){
		var likeCountId="#likeCount"+replyNum;
		var disLikeCountId="#disLikeCount"+replyNum;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "json");
}

// 댓글 좋아요/싫어요 추가
function sendLike(replyNum, replyLike) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(replyLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var query="replyNum="+replyNum;
	query+="&replyLike="+replyLike;

	$.ajax({
		type:"post"
		,url:"<%=cp%>/bbs/replyLike"
		,data:query
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				countLike(replyNum);
			} else if(state=="false") {
				alert("좋아요/싫어요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-book"></span> 게시판 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 회원과 자유로이 토론할 수 있는 공간입니다.
    </div>
    
    <div class="table-responsive" style="clear: both;">
        <div class="bbs-article">
            <table class="table">
                 <thead>
                     <tr>
                         <th colspan="2" style="text-align: center;">
                                ${dto.subject}
                         </th>
                     </tr>
                <thead>
                 <tbody>
                     <tr>
                         <td style="text-align: left;">
                             이름 : ${dto.userName}
                         </td>
                         <td style="text-align: right;">
                          ${dto.created}<i></i>조회 ${dto.hitCount}
                         </td>
                     </tr>
                     <tr style="border-bottom:none;">
                         <td colspan="2" style="height: 170px;">
                              ${dto.content}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="height: 40px; padding-bottom: 15px; text-align: center;">
                              <button type="button" class="btn btn-default btn-sm wbtn" style="background: white;" onclick="sendLikeBoard('${dto.num}')"><span class="glyphicon glyphicon-hand-up"></span> <span id="countLikeBoard">${countLikeBoard}</span></button>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">첨부</span> :
                              <c:if test="${not empty dto.saveFilename}">
                                  <a href="<%=cp%>/bbs/download?num=${dto.num}"><span class="glyphicon glyphicon-download-alt"></span> ${dto.originalFilename}</a>
                              </c:if>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
                              <c:if test="${not empty preReadDto }">
                                  <a href="<%=cp%>/bbs/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
                              </c:if>					
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
                              <c:if test="${not empty nextReadDto }">
                                  <a href="<%=cp%>/bbs/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
                              </c:if>
                         </td>
                     </tr>                                          
                </tbody>
                <tfoot>
                	<tr>
                		<td>
<c:if test="${sessionScope.member.userId==dto.userId}">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updateBoard();">수정</button>
</c:if>
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">	                		    
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteBoard();">삭제</button>
</c:if>                		    
                		</td>
                		<td align="right">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/bbs/list?${query}';"> 목록으로 </button>
                		</td>
                	</tr>
                </tfoot>
            </table>
       </div>
       
       <div class="bbs-reply">
           <div class="bbs-reply-write">
               <div style="clear: both;">
           	       <div style="float: left;"><span style="font-weight: bold;">댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
           	       <div style="float: right; text-align: right;"></div>
               </div>
               <div style="clear: both; padding-top: 10px;">
                   <textarea id="content" class="form-control" rows="3"></textarea>
               </div>
               <div style="text-align: right; padding-top: 10px;">
                   <button type="button" class="btn btn-primary btn-sm" onclick="sendReply();"> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
               </div>           
           </div>
       
           <div id="listReply"></div>
       </div>
   </div>

</div>