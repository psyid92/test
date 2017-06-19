<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.imgLayout{
	width: 170px;
	height: 185px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #DAD9FF;
}
.subject {
     width:160px;
     height:25px;
     line-height:25px;
     margin:5px auto;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
}
.subject:hover {
    color:tomato;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
var photoPage=1;
function listPagePhoto(page) {
	var owner="${owner}";
	var bid="${bid}";
	var url="<%=cp%>/blog/${blogSeq}/photo";
	
	photoPage=page;
	$.post(url, {pageNo:page, owner:owner, bid:bid}, function(data){
		$("#blog-content").html(data);
	});
}

function articleView(num) {
	var owner="${owner}";
	var url="<%=cp%>/blog/${blogSeq}/photoArticle";
	
	$.post(url, {num:num, owner:owner}, function(data){
		$("#photo-content").html(data);
	});
}

<c:if test="${owner==1}">
function insertFormView() {
	var url="<%=cp%>/blog/${blogSeq}/photoCreated";
	var owner="${owner}";
	var bid="${bid}";
	$.get(url, {bid:bid, owner:owner, tmp:new Date().getTime()}, function(data){
		if($.trim(data)=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		} else if($.trim(data)=="blogFail") {
			location.href="<%=cp%>/blog/${blogSeq}";
			return;
		}
		$("#photo-content").html(data);
	});
}

function updateFormView(num) {
	var url="<%=cp%>/blog/${blogSeq}/photoUpdate";
	var owner="${owner}";
	var bid="${bid}";
	
	$.get(url, {bid:bid, owner:owner, num:num}, function(data){
		if($.trim(data)=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		} else if($.trim(data)=="blogFail" || $.trim(data)=="articleFail") {
			location.href="<%=cp%>/blog/${blogSeq}";
			return;
		}
		$("#photo-content").html(data);
	});
}

function deletePhoto(num, imageFilename) {
	if(! confirm("게시물을 삭제 하시겠습니까 ?"))
		return;
	
	var url="<%=cp%>/blog/${blogSeq}/photoDelete";
	$.post(url, {num:num, imageFilename:imageFilename}, function(data){
		if($.trim(data)=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		} else if($.trim(data)=="blogFail") {
			location.href="<%=cp%>/blog/${blogSeq}";
			return;
		}
		listPagePhoto(photoPage);
	});
}
</c:if>
</script>

<div id="photo-content">
    <div class="blog-body-content" style="padding-bottom: 0px;">
         <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
            <tr height="30">
                <td width="50%">
                      <span style="font-weight: bold;">포토</span>
                </td>
                <td width="50%" align="right">
                      <c:if test="${owner==1}">
                          <span style="cursor: pointer;" onclick="insertFormView()">등록하기</span>
                      </c:if>
                </td>
            </tr>
            <tr><td colspan="2" height="1" bgcolor="#212121"></td></tr>
          </table>
          
         <table style="width: 100%; margin: 10px auto 10px; border-spacing: 0px;">
<c:forEach var="dto" items="${list}" varStatus="status">
                 <c:if test="${status.index==0}">
                       <tr>
                 </c:if>
                 <c:if test="${status.index!=0 && status.index%4==0}">
                        <c:out value="</tr><tr>" escapeXml="false"/>
                 </c:if>
			     <td width="190" align="center">
			        <div class="imgLayout">
			             <img src="<%=cp%>/uploads/blog/${dto.blogId}/${dto.imageFilename}" width="160" height="160" border="0">
			             <span class="subject" onclick="javascript:articleView('${dto.num}');" >
			                   ${dto.subject}
			             </span>
			         </div>
			     </td>
</c:forEach>

<c:set var="n" value="${list.size()}"/>
<c:if test="${n>0&&n%4!=0}">
		        <c:forEach var="i" begin="${n%4+1}" end="4" step="1">
			         <td width="190">
			             <div class="imgLayout">&nbsp;</div>
			         </td>
		        </c:forEach>
</c:if>
	
<c:if test="${n!=0 }">
		       <c:out value="</tr>" escapeXml="false"/>
</c:if>
          </table>
           
         <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
              <tr height="40">
                 <td align="center">
                   <c:if test="${dataCount==0}">
                   		등록된 게시물이 없습니다.
                   </c:if>
                   <c:if test="${dataCount!=0}">
                   		${paging}
                   </c:if>
                 </td>
              </tr>
          </table>
          
    </div>
</div>