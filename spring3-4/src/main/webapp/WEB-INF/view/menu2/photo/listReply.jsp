<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<div style="clear: both; padding-top: 20px;">
    <div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
    <div style="float: right; text-align: right;"></div>
</div>
              
<div style="clear: both; padding-top: 5px;">

<c:forEach var="vo" items="${listReply}">
    <!-- 리플 내용 리스트 시작 -->
    <div style="clear:both; margin-top:5px; padding: 10px; border: #d5d5d5 solid 1px; min-height: 130px;">
        <div style="clear: both;">
            <div style="float: left;">${vo.userName} | ${vo.created}</div>
            <div style="float: right;  text-align: rigth;">
<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">		   
                <a onclick='deleteReply("${vo.replyNum}", "${pageNo}");'>삭제</a>
</c:if>		   
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">		   
                <a href='#'>신고</a>
</c:if>		   
            </div>
        </div>
        <div style="clear: both; padding: 5px 0 5px 0px;  min-height: 70px;">
            ${vo.content}
        </div>
        <div style="clear: both; min-height: 30px;">
            <div style="float: left;">
                <button type="button" class="btn btn-primary btn-sm" onclick="replyAnswerLayout('${vo.replyNum}');">답글<span id="answerCount${vo.replyNum}">(${vo.answerCount})</span> <span id="answerGlyphicon${vo.replyNum}" class="glyphicon glyphicon-triangle-bottom"></span></button>
            </div>
            <div style="float: right; text-align: rigth;">
                <button type="button" class="btn btn-info btn-sm" onclick="sendLike('${vo.replyNum}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="likeCount${vo.replyNum}">${vo.likeCount}</span></button>
                <button type="button" class="btn btn-warning btn-sm" onclick="sendLike('${vo.replyNum}', '0')"><span class="glyphicon glyphicon-hand-down"></span> 싫어요 <span id="disLikeCount${vo.replyNum}">${vo.disLikeCount}</span></button>
            </div>                        
        </div>

        <!-- 답글 시작 -->
        <div id="replyAnswerLayout${vo.replyNum}" style="display: none;">
            <div style="clear: both; margin-top:10px; padding: 5px; border-top: #d5d5d5 solid 1px;">
                <textarea id="replyContent${vo.replyNum}" class="form-control" rows="3" required="required"></textarea>
            </div>
            <div style="text-align: right; padding-top: 7px;">
                <button type="button" class="btn btn-primary btn-sm" onclick="sendReplyAnswer('${vo.num}', '${vo.replyNum}')"> 답글등록 </button>
            </div>

            <!-- 답글 리스트 -->       
            <div id="listReplyAnswer${vo.replyNum}" style="padding-top: 5px;"></div>
        </div> <!-- 답글 끝 -->
                        
    </div>  <!-- 리플 내용 리스트 끝 -->
</c:forEach>
</div>
              
<div style="clear: both; padding-top: 10px; text-align: center;">
    ${paging}
</div>
