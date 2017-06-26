<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<script>
	$(function() {
		$(".dropdown-toggle").click(function() {
			if ($(".dropdown-menu").is(":visible") == false) { 
				$(".dropdown-menu").show();
			} else {
				$(".dropdown-menu").hide();
			};
		});
		$(".dropdown-toggle").change(function() {
			$(".dropdown-menu").hide();
		});
	});
</script>

<style type="text/css">
body {
	background-color: #eaf1f1;
}
#headerMenutr {
	background-color: #f7f2e2;
}
#header th {
	width: 195.8px;
}

#header a {
	color: gray;
	font-size: 12px;
}

</style>
<div style="padding-bottom: 30px;" id="header">
	<div align="right" id="headerMember">
	<c:if test="${empty login}"><a href="<%=cp%>/member/login">로그인</a> | <a href="<%=cp%>/member/member">회원가입</a> | <a href="#">고객센터</a></c:if>
	<c:if test="${not empty login}"><a href="<%=cp%>/member/logout">로그아웃</a> | <a href="#">마이페이지</a> | <a href="#">고객센터</a></c:if>
	</div>
	<div align="center">
		<div style="width: 444px; height: 91px; line-height: 91px; font-size: 40px; background-image:url('<%=cp%>/resource/img/title_back.png');">배 달 행</div>
	</div>
</div>
 	
<nav class="navbar navbar-default" style="width: 445px; margin: 0 auto 50px;">
  <div class="container-fluid">
   <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2" style="padding: 0;" align="center">
    <form class="navbar-form navbar-center" role="search" style="line-height: 50px;">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
    </div>
  </div>
</nav>