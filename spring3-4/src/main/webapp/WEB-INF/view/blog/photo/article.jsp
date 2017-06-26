<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
</script>

<div class="blog-body-content" style="padding-bottom: 0px;">
         <table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
          <thead>
              <tr height="30">
                  <td colspan="2">
                      <span style="font-weight: bold;">포토 보기</span>
                  </td>
              </tr>
              <tr><td colspan="2" height="1" bgcolor="#212121"></td></tr>
          </thead>
          
          <tbody>
              <tr height="35">
                   <td colspan="2" align="center">
                       <span style="font-weight: bold;">${dto.subject}</span>
                   </td>
              </tr>
              <tr><td colspan="2" height="1" bgcolor="#ccc"></td></tr>
              <tr height="30">
                   <td width="50%">&nbsp;</td>
                   <td width="50%" align="right">
                       ${dto.created}
                    </td>
              </tr>
              <tr>
                   <td colspan="2" style="padding: 10px;">
                       <img src="<%=cp%>/uploads/blog/${dto.blogId}/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
                   </td>
              </tr>
              <tr>
                  <td colspan="2" style="min-height: 30px; white-space: pre; padding: 10px;">${dto.content}</td>
              </tr>
              <tr><td colspan="2" height="1" bgcolor="#ccc"></td></tr>
              <tr height="30">
                   <td width="50%">
                       <c:if test="${dto.blogId==sessionScope.member.userId}">
                          <span class="item-click"
                                      onclick="updateFormView('${dto.num}');">수정</span>&nbsp;
                           <span class="item-click"
                                      onclick="deletePhoto('${dto.num}', '${dto.imageFilename}');">삭제</span>   &nbsp; 
                       </c:if>
                   </td>
                   <td width="50%" align="right">
                        <c:if test="${empty preReadDto}">
                            <span class="item-title">이전글</span>&nbsp;
                        </c:if>
                        <c:if test="${not empty preReadDto }">
                            <span class="item-click"
                                      onclick="articleView('${preReadDto.num}');">이전글</span>&nbsp;
                        </c:if>
                        <c:if test="${empty nextReadDto}">
                            <span class="item-title">다음글</span>
                        </c:if>
                        <c:if test="${not empty nextReadDto }">
                            <span class="item-click"
                                      onclick="articleView('${nextReadDto.num}');">다음글</span>
                        </c:if>
                    </td>
              </tr>
          </tbody>
          </table>
          
</div>
