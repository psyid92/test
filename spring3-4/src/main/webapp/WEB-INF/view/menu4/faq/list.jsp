<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<c:forEach var="dto" items="${list}">
    <div class="panel-group" id="accordion${dto.num}" role="tablist" aria-multiselectable="true" style="margin-bottom:5px;">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="heading${dto.num}">
                <h4 class="panel-title" style="font-size: 14px;">
                    <span style="display: inline-block; width: 80px; ">${dto.classify}</span> | 
                    <a data-toggle="collapse" data-parent="#accordion${dto.num}" href="#collapse${dto.num}" aria-expanded="true" aria-controls="collapse${dto.num}">
                         ${dto.subject}
                    </a>
                </h4>
            </div>
            <div id="collapse${dto.num}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${dto.num}">
                <div class="panel-body">
                        ${dto.content}
                        <c:if test="${sessionScope.member.userId=='admin'}">
                            <div style="padding-top: 5px;">
                                <hr>
			                    <a href="<%=cp%>/faq/update?num=${dto.num}&pageNo=${pageNo}&category=${category}">수정</a>&nbsp;|
			                    <a href="<%=cp%>/faq/delete?num=${dto.num}&pageNo=${pageNo}&category=${category}">삭제</a>
                            </div>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
</div>        
