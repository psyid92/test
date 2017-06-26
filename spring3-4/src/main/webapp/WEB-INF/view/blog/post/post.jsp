<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.item-click {
   color: #424951; display: inline-block; cursor: pointer;
}
.item-click:hover {
   color:#000000;
}
.item-title {
   color: #aaa; display: inline-block;
}

.file-list-content {
   position: relative;
   display: none;
}
.file-list{
  border:1px solid #2f3741;
  width: 250px;
  position: absolute;
  z-index:1000;
  padding:10px;
  background: #fefefe;
  
  top: 10px;
  left: 120px;
}
.file-list-item{
    width: 240px;
    text-overflow:ellipsis;
    white-space: nowrap;overflow:hidden;
    text-align: left;
}

.reply-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>

<script type="text/javascript">
// ------------------------------------------------------
// 목록 열기, 목록 닫기
$(function(){
	var listClosed="${listClosed}";
	if(listClosed=="1") {
		$("#post-list").hide();
		$("#list-title-close").text("목록열기 ▼");
		$("#list-title-hitCount").text("");
	}
});

$(function(){
	$("#list-title-close").click(function(){
		if($("#post-list").is(':visible')) {
			$("#post-list").fadeOut(100);
			$("#list-title-close").text("목록열기 ▼");
			$("#list-title-hitCount").text("");
			$("#listClosed").val("1");
		} else {
			$("#post-list").fadeIn(100);
			$("#list-title-close").text("목록닫기 ▲");
			$("#list-title-hitCount").text("조회");
			$("#listClosed").val("0");
		}
	});
});

//------------------------------------------------------
// 리스트, 수정, 삭제, 다운로드 화면
function selectListRead(num) {
	var f = document.selectListForm;
	f.num.value=num;
	f.action="${blogUrl}";
	f.submit();
}

// 포스트 수정 폼
function updateBoard(num) {
		var url="${blogUrl}/postUpdate";
		var categoryNum="${categoryNum}";
		var menu="${menu}";
		var page="${page}";
		$.get(url, {num:num, categoryNum:categoryNum, menu:menu, page:page}, function(data){
			$("#blog-content").html(data);
		});
}

// 포스트 삭제
function deleteBoard(num) {
	if(confirm("게시글을 삭제 하시겠습니까 ?")) {
		var url="${blogUrl}/postDelete?${query}&page=${page}&num="+num;
		location.href=url;
	}
}

// 파일 다운로드 화면
function downloadLayout() {
	if($(".file-list-content").is(':visible')) {
		$(".file-list-content").fadeOut(100);
	} else {
		$(".file-list-content").fadeIn(100);
	}
}

function login() {
	location.href="<%=cp%>/member/login";
}

//------------------------------------------------------
// 댓글
$(function(){
	$("#reply-open-close").click(function(){
		  if($("#reply-content").is(':visible')) {
			  $("#reply-content").fadeOut(100);
			  $("#reply-open-close").text("댓글 ▼");
		  } else {
			  $("#reply-content").fadeIn(100);
			  $("#reply-open-close").text("댓글 ▲");
		  }
	});
})

// 댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${blogUrl}/postListReply";
	var num="${dto.num}";
	if(num=="")
		return;
	
	$.post(url, {num:num, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

// 댓글 추가
function sendReply() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return;
	}

	var num="${dto.num}"; // 해당 게시물 번호
	var content=$.trim($("#postReplyContent").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#postReplyContent").focus();
		return;
	}
	
	var query="num="+num;
	query+="&content="+content;
	query+="&answer=0";
	
	$.ajax({
		type:"POST"
		,url:"${blogUrl}/postCreatedReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#postReplyContent").val("")
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
				postReplyCount();
			} else if(state=="false") {
				alert("댓글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

// 댓글 개수
function postReplyCount() {
	var num="${dto.num}"; // 해당 게시물 번호
	var url="${blogUrl}/postReplyCount";
	$.post(url, {num:num}, function(data){
		var count=data.count;
		$("#postReplyCountView").text("("+count+")");
	}, "JSON");
}

//좋아요/싫어요 개수
function countLike(replyNum) {
	var url="${blogUrl}/postCountLike";
	$.post(url, {replyNum:replyNum}, function(data){
		var btnLike="#btnLike"+replyNum;
		var btnDisLike="#btnDisLike"+replyNum;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		
		$(btnLike).html(likeCount);
		$(btnDisLike).html(disLikeCount);
	}, "JSON");
}

//좋아요/싫어요 추가
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
		type:"POST"
		,url:"${blogUrl}/postReplyLike"
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
			alert(e.responseText);
		}
	});
}

//댓글 삭제
function deleteReply(replyNum, page) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="${blogUrl}/postDeleteReply";
		$.post(url, {replyNum:replyNum, mode:"reply"}, function(data){
		        var state=data.state;

				if(state=="loginFail") {
					login();
				} else {
					listPage(page);
					postReplyCount()
				}
		}, "json");
	}
}
</script>

 <div class="bodyFrame4" id="blog-content" style="margin-bottom: 20px;">
 <c:if test="${dataCount!=0}">

     <!-- 게시글(포스트) 리스트 보기 -->
      <div class="blog-body-content" style="min-height: 35px;">
         <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
          <thead>
            <tr height="30">
                <td>
                      <span style="font-weight: bold;">${classify} (${dataCount})</span>
                </td>
                <td width="80" align="center">
                      <span class="item-title" id="list-title-hitCount">조회</span>
                </td>
                <td width="100" align="center">
                      <span class="item-click" id="list-title-close">목록닫기 ▲</span>
                </td>
            </tr>
          </thead>
          
          <tbody id="post-list">
            <tr><td colspan="3" height="1" bgcolor="#212121"></td></tr>
<c:forEach var="vo" items="${list}">          
            <tr height="33">
                <td style="padding-left: 10px;">
                      <c:if test="${vo.categoryNum==1}"><span style="display: inline-block;width: 28px;height:18px;line-height:18px; background: #ED4C00;color: #FFFFFF">공지</span>&nbsp;</c:if>
                      <a href="javascript:selectListRead('${vo.num}');">${vo.subject}</a>
                </td>
                <td align="center">
                      <span class="item-title">${vo.hitCount}</span>
                </td>
                <td align="center">
                      <span class="item-title">${vo.created}</span>
                </td>
            </tr>
            <tr><td colspan="3" height="1" bgcolor="#ccc"></td></tr>
</c:forEach>
            
            <tr height="40">
                <td align="right" colspan="3" >
                      <form name="selectListForm" method="post">
                      <select name="rows" class="selectField" onchange="selectListRead('0');">
                          <option value="5" ${rows=="5"?"selected='selected'":"" }>5줄 보기</option>
                          <option value="10" ${rows=="10"?"selected='selected'":"" }>10줄 보기</option>
                          <option value="20" ${rows=="20"?"selected='selected'":"" }>20줄 보기</option>
                          <option value="30" ${rows=="30"?"selected='selected'":"" }>30줄 보기</option>
                      </select>
                      <input type="hidden" name="categoryNum" value="${categoryNum}">
                      <input type="hidden" name="menu" value="${menu}">
                      <input type="hidden" name="num" value="0">
                      <input type="hidden" name="page" value="${page}">
                      <input type="hidden" name="listClosed" id="listClosed" value="${listClosed}">
                      </form>
                </td>
            </tr>
                        
            <tr height="30">
                <td align="center" colspan="3">
                    ${paging}
                </td>
            </tr>
         </tbody>
        
         </table>
     </div>
 
     <!-- 게시글(포스트) 내용 보기 -->
     <div class="blog-body-content" style="margin-top: 10px; margin-bottom: 10px;">
         <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
            <tr height="35">
                <td colspan="2" align="center">
                      <span style="font-weight: bold;">${dto.subject}</span>
                </td>
            </tr>
            <tr><td colspan="2" height="1" bgcolor="#212121"></td></tr>
            
            <tr height="30">
                <td width="50%">
                      <span class="item-title" style="color: #212121;">
                                 ${dto.classify}
                                 <c:if test="${not empty dto.groupClassify}">
                                     / ${dto.groupClassify}
                                 </c:if>
                      </span>
                </td>
                <td width="50%" align="right">
                     <span class="item-title">조회 ${dto.hitCount} | ${dto.created}</span>&nbsp;

                     <c:if test="${listFile.size()>0 && not empty sessionScope.member}">
                            <span class="item-click" onclick="downloadLayout();">첨부(${listFile.size()})</span>
                            <div class="file-list-content">
                                <div class="file-list">
                                   <div class='file-list-item' style="text-align: right;">
                                           <a href="javascript:downloadLayout();">X</a>
                                   </div>
                                   
                                   <c:forEach var="vo" items="${listFile}">
                                         <div class='file-list-item'><a href="${blogUrl}/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a></div>
                                   </c:forEach>    
                            </div>
                          </div>  
                     </c:if>
                     <c:if test="${listFile.size()>0 && empty sessionScope.member}">
                         <span class="item-title">첨부(${listFile.size()})</span>
                     </c:if>
                                 
                </td>
            </tr>
                        
            <tr>
                <td colspan="2" valign="top" style="min-height: 100px; white-space: pre; padding: 10px;">${dto.content}</td>
             </tr>
            
             <tr height="30">
                <td width="50%">
                     <c:if test="${dto.categoryNum!=1}">
                              <span class="item-click" id="reply-open-close">댓글 ▼</span>&nbsp;<span id="postReplyCountView" class="item-title" style="color:#424951">(${replyCount})</span>
                     </c:if>
                </td>
                <td width="50%" align="right">
                       <c:if test="${dto.blogId==sessionScope.member.userId}">
                          <span class="item-click"
                                      onclick="updateBoard('${dto.num}');">수정</span>&nbsp;
                           <span class="item-click"
                                      onclick="deleteBoard('${dto.num}');">삭제</span>   &nbsp; 
                       </c:if>
                                     
                        <c:if test="${empty preReadDto}">
                            <span class="item-title">이전글</span>&nbsp;
                        </c:if>
                        <c:if test="${not empty preReadDto }">
                            <span class="item-click"
                                      onclick="selectListRead('${preReadDto.num}');">이전글</span>&nbsp;
                        </c:if>
                        <c:if test="${empty nextReadDto}">
                            <span class="item-title">다음글</span>
                        </c:if>
                        <c:if test="${not empty nextReadDto }">
                            <span class="item-click"
                                      onclick="selectListRead('${nextReadDto.num}');">다음글</span>
                        </c:if>
                </td>
            </tr>
         </table>
     </div>
     
     <!-- 댓글 폼 및 리스트-->
     <div id="reply-content" class="blog-body-content" style="display:none; margin-top: 10px; margin-bottom: 10px;">
     
          <div class="reply-write">
                 <div style="clear: both;">
           	           <span style="font-weight: bold;">댓글 쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
                 </div>
                 <div style="clear: both; padding-top: 10px;">
                      <textarea id="postReplyContent" class="boxTF" rows="3" style="display:block; width: 100%; padding: 6px 12px; box-sizing:border-box;"></textarea>
                 </div>
                 <div style="text-align: right; padding-top: 10px;">
                      <button type="button" class="btn1" onclick="sendReply();" style="padding:8px 25px;"> 등록하기 </button>
                 </div>           
          </div>
          
          <div id="listReply" style="width:100%; margin: 0px 0px 10px;"></div>
     
     </div>
     
</c:if>

 <c:if test="${dataCount==0}">
      <div class="blog-body-content" style="height: 100px; line-height: 100px; text-align: center;">
                등록된 포스트가 없습니다.
      </div> 
 </c:if>
      
 </div>