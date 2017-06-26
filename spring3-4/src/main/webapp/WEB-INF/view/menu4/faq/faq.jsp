<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
var category="${category}";
var searchValue="${searchValue}";

$(function(){
	var page="${pageNo}";
	if(page=="") page="0";
	
	$('a[data-toggle="tab"]').each(function(){
		var c=$(this).attr("aria-controls");
		
		if(category==c) {
			$(this).parent().addClass("active");
			$("#tabContent"+c).addClass("active");
		} else {
			$(this).parent().removeClass("active");
		}
	});

	listPage(page);
});

// 탭을 선택 한 경우
$(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		category=$(this).attr("aria-controls");
		searchValue="";
		$("#searchValue").val("");
		
		$("[id^=tabContent]").each(function(){
			$(this).html(""); // 전체를 출력하는 부분과 카테고리별 출력하는부분의 id가 같으므로 기존 정보 지움
		});
		
		listPage(1);
	});	
});

function listPage(page) {
    var url="<%=cp%>/faq/list";

	var query="pageNo="+page+"&category="+category+"&searchValue="+searchValue;
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			var id="#tabContent"+category;
			$(id).html(data);
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});

}

function searchList() {
	searchValue=$("#searchValue").val();
	listPage(1);
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-search"></span> 자주하는 질문 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 궁금한 문의 사항을 확인 해 보세요.
    </div>

    <div>
	    <div role="tabpanel">
			  <ul class="nav nav-tabs" role="tablist">
			      <li role="presentation" class="active"><a href="#tabContent0" aria-controls="0" role="tab" data-toggle="tab">전체</a></li>
		          <c:forEach var="dto" items="${listFaqCategory}">
			          <li role="presentation"><a href="#tabContent${dto.categoryNum}" aria-controls="${dto.categoryNum}" role="tab" data-toggle="tab">${dto.classify}</a></li>
			      </c:forEach>
			  </ul>
			
			  <div class="tab-content" style="padding: 5px; margin-top: 15px;">
			      <div role="tabpanel" class="tab-pane active" id="tabContent0"></div>
			      <c:forEach var="dto" items="${listFaqCategory}">
			          <div role="tabpanel" class="tab-pane" id="tabContent${dto.categoryNum}"></div>
			      </c:forEach>
			  </div>
	    </div>
        
        <div style="clear: both; margin-top: 20px;">
        		<div style="float: left; width: 20%; min-width: 85px;">&nbsp;</div>
        		<div style="float: left; width: 60%; text-align: center;">
        		     <form name="searchForm" method="post" class="form-inline">
        		         <div class="input-group col-xs-6">
        		             <input type="text" name="searchValue" id="searchValue" class="form-control input-sm input-search" placeholder="검색 단어">
        		             <span class="input-group-btn" >
          		                 <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchList();"><i class="glyphicon glyphicon-search"></i> 검색 </button>
        		             </span>
        		         </div>
        		     </form>
        		</div>
        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
<c:if test="${sessionScope.member.userId=='admin'}">
        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/faq/created';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기 </button>
</c:if>        		    
        		</div>
        </div>
    </div>
    
</div>