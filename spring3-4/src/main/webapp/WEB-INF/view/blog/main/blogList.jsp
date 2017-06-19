<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
.hover {
	cursor: pointer;
	/* text-decoration: underline; */
	color: #3EA9CD;
	font-weight: 500;
}
</style>

<script type="text/javascript">
$(function(){
	$("table .blog-title-introduce").hover( // 마우스 hover 처리
			function() {$(this).addClass("hover");},
			function() {$(this).removeClass("hover");}
	);
});
</script>

 <div class="bodyFrame3">
    <div style="width:700px; padding-top:35px; clear: both; margin: 0px auto;">
        <div class="body-title">
              <h3> 블로그 리스트</h3>
        </div>
    </div>
  
    <div style="width:700px; padding-top:20px; clear: both; margin: 0px auto;">
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
        <c:forEach var="dto" items="${listBlog}">
            <tr height='40' bgcolor='#eeeeee'>
                 <td width='50%' style='border:1px solid #cccccc; border-right:none; padding-left: 5px;'>
                       ${dto.nickName} | ${dto.created}
                 </td>
                 <td width='50%' align='right' style='border:1px solid #cccccc; border-left:none; padding-right: 5px;'>
                       [${dto.subject} / ${dto.groupSubject}]
                 </td>
            </tr>
            <tr height='50' class="blog-title-introduce">
                 <td colspan='2' style='padding: 5px;' valign='top' onclick="javascript:location.href='<%=cp%>/blog/${dto.blogSeq}';">
                     <span style="display: block;">
                         <label style="font-weight:800; ">${dto.title}</label>
                         <label>[${dto.visitorCount}]</label>
                     </span>
                     <span style="display: block; padding-top: 10px; white-space:pre;">${dto.introduce}</span>
                 </td>
            </tr>
        </c:forEach>
        
        <tr height="40" align="center">
            <td colspan="2">
                <c:if test="${dataCount==0}">등록된 블로그가 없습니다.</c:if>
                <c:if test="${dataCount!=0}">${paging}</c:if>
            </td>
         </tr>
      </table>
     </div>
     
</div>