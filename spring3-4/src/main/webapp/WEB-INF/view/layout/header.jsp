<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
//엔터 처리
$(function(){
	   $("input").not($(":button")).keypress(function (evt) {
	        if (evt.keyCode == 13) {
	            var fields = $(this).parents('form,body').find('button,input,textarea,select');
	            var index = fields.index(this);
	            if ( index > -1 && ( index + 1 ) < fields.length ) {
	                fields.eq( index + 1 ).focus();
	            }
	            return false;
	        }
	     });
});

function dialogLogin() {
    $("#modalUserId").val("");
    $("#modalUserPwd").val("");
	$("#modalLogin").modal("show");	
    $("#modalUserId").focus();
}

function modalSendLogin() {
	var f=document.modalLoginForm;
	
    if(!f.userId.value) {
    	f.userId.focus();
    	return false;
    }	

    if(!f.userPwd.value) {
    	f.userPwd.focus();
    	return false;
    }	

   f.action="<%=cp%>/member/login"; 
   f.submit();
}
</script>

<div class="container">
    <div id="page-header">
        <div class="header-brand"><a href="<%=cp%>/"><span class="logo">SPRING</span></a></div>
				
        <div class="login header-login">
            <c:if test="${empty sessionScope.member}">
                <a href="javascript:dialogLogin();"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/member/member"><span class="glyphicon glyphicon-user"></span> 회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님 <i></i>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin">관리자</a> <i></i>
                </c:if>
                <a href="<%=cp%>/member/logout"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
        </div>

        <div class="header-search">
            <form method="post">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control input-sm keyword" placeholder="통합검색">
                    <span class="input-group-btn" >
                        <button type="button" class="btn btn-primary btn-sm"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div>
            </form>
        </div>

        <div class="clear"></div>
    </div>
</div>

<div class="container">
         <nav class="navbar navbar-default">
             <div class="container-fluid">
                  <div class="navbar-header">
                      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                          <span class="sr-only">Toggle navigation</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                      </button>
                      <a class="navbar-brand" href="<%=cp%>/"><span class="glyphicon glyphicon-apple"></span></a>
                </div>
                
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="<%=cp%>/company/info">회사소개</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">커뮤니티<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<%=cp%>/guest/guest">방명록</a></li>
                                <li><a href="<%=cp%>/bbs/list">게시판</a></li>
                                <li><a href="<%=cp%>/photo/list">포토갤러리</a></li>
                                <li><a href="#">자료실</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="<%=cp%>/chat/main">채팅</a></li>
                                <li><a href="<%=cp%>/nblog">블로그</a></li>
                            </ul>
                        </li>
                        <li><a href="#">스터디룸</a></li>
                        <li><a href="<%=cp%>/faq/faq">고객센터</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    
                        <c:if test="${not empty sessionScope.member}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">마이페이지<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="<%=cp%>/mypage/info">정보확인</a></li>
                                    <li><a href="#">다이어리</a></li>
                                    <li><a href="<%=cp%>/sch/sch">일정관리</a></li>
                                    <li><a href="<%=cp%>/friend/friend">친구관리</a></li>
                                    <li><a href="<%=cp%>/note/note">쪽지</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="<%=cp%>/member/pwd">정보수정</a></li>
                                    <c:if test="${sessionScope.member.userId!='admin'}">
                                        <li><a href="<%=cp%>/member/pwd?dropout">회원탈퇴</a></li>
                                    </c:if>
                                </ul>
                            </li>
                        </c:if>
                        <li><a href="#"><span class="glyphicon glyphicon-th"></span></a></li>
                    </ul>
                </div>
            </div>
        </nav>
</div>

<div id="modalLogin" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h2 id="myModalLabel" class="modal-title text-center fc-orange" style="font-family: sans-serif,나눔고딕, 맑은 고딕; font-weight: bold;">Log In</h2>
			</div>
			<div class="modal-body">
			    <form name="modalLoginForm" method="post">
			         <div class="form-group">
			            <label class="control-label" for="modalUserId">아이디</label>
			            <input class="form-control" id="modalUserId" name="userId" type="text" placeholder="아이디">
			        </div>
			         <div class="form-group">
			            <label class="control-label" for="modalUserPwd">패스워드</label>
			            <input class="form-control" id="modalUserPwd" name="userPwd" type="password" placeholder="패스워드">
			        </div>
			        
			        <div class="form-group">
			            <button class="btn btn-lg btn-primary btn-block" type="button" onclick="modalSendLogin();">로그인 <span class="glyphicon glyphicon-ok"></span></button>
                    </div>
                    
			         <div style="text-align: center;">
			                  <button type="button" class="btn btn-link" onclick="location.href='<%=cp%>/member/member';">회원가입</button>
			                   <button type="button" class="btn btn-link">아이디찾기</button>
			                   <button type="button" class="btn btn-link">패스워드찾기</button>
			        </div>
			    </form>
			</div>
		</div>
	</div>
</div>
