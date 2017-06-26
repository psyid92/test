<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.guest-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>

<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/blog/${blogSeq}/guestList";
	$.post(url, {pageNo:page}, function(data){
		printGuest(data);
	}, "json");
}

function sendGuest() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		alert("로그인이 필요 합니다.");
		return false;
	}
	
	var content=$.trim($("#content").val());
	
	var query="content="+encodeURIComponent(content);
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/blog/${blogSeq}/guestCreated"
		,data:query
		,dataType:"JSON"
		,success:function(data) {
			var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return false;
			}
			
			printGuest(data);
			$("#content").val("");
		}
		,beforeSend:check
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

function check() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return false;
	}
	
	return true;
}

function deleteGuest(num, page) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		alert("로그인이 필요 합니다.");
		return;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/blog/${blogSeq}/guestDelete";
		$.post(url, {num:num, pageNo:page}, function(data){
			var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}

			printGuest(data);

		}, "json");
	}
}

function printGuest(data) {
	var uid="${sessionScope.member.userId}";
	var total_page=data.total_page;
	var dataCount=data.dataCount;
	var pageNo=data.pageNo;
	var paging=data.paging;
	var owner=data.owner;
	
	var out="<table style='width: 100%; margin: 15px 0px 0px; border-spacing: 0px; border-collapse: collapse;'>";
	out+="    <tr height='40'>";
	out+="       <td width='50%' style='padding-left: 5px;'>";
	out+="           <span style='color: #3EA9CD; font-weight: bold;'>방명록 "+dataCount+"개</span>";
	out+="           <span>[목록, "+pageNo+"/"+total_page+" 페이지]</span>";
	out+="       </td>";
	out+="       <td width='50%' align='right' style='padding-right: 5px;'>&nbsp;</td>"
	out+="    </tr>";
	if(dataCount!=0) {
		for(var idx=0; idx<data.list.length; idx++) {
			var num=data.list[idx].num;
			var userName=data.list[idx].userName;
			var userId=data.list[idx].userId;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			
			out+="    <tr height='30'  style='border: 1px solid #c3c3c3;'>";
			out+="      <td width='50%' style='padding-left: 5px;'>"+ userName+"</td>";
			out+="      <td width='50%' align='right' style='padding-right: 5px;'>" + created;
			if(uid==userId || uid=="admin" || owner==1) {
				out+=" | <a onclick='deleteGuest(\""+num+"\", \""+pageNo+"\");'>삭제</a></td>" ;
			} else {
				out+=" | <a href='#'>신고</a></td>" ;
			}
			out+="    </tr>";
			out+="    <tr style='height: 50px;'>";
			out+="      <td colspan='2' style='padding: 10px 5px;' valign='top'>"+content+"</td>";
			out+="    </tr>";
		}
		out+="    <tr style='height: 50px;'>";
		out+="      <td colspan='2' style='text-align: center;'>";
		out+=paging;
		out+="      </td>";
		out+="    </tr>";
	}
	out+="  </table>";
	
	$("#listGuest").html(out);
}
</script>

<div class="blog-body-content" style="padding-bottom: 0px;">
      <div style="width:100%; height: 30px; line-height: 30px; border-bottom: 1px solid #212121;">
            <b>방명록</b>
      </div>
      
      <div class="guest-write" style="margin-top: 15px;">
                 <div style="clear: both;">
           	           <span style="font-weight: bold;">방명록 쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
                 </div>
                 <div style="clear: both; padding-top: 10px;">
                      <textarea id="content" class="boxTF" rows="3" style="display:block; width: 100%; padding: 6px 12px; box-sizing:border-box;"></textarea>
                 </div>
                 <div style="text-align: right; padding-top: 10px;">
                      <button type="button" class="btn1" onclick="sendGuest();" style="padding:8px 25px;"> 등록하기 </button>
                 </div>           
      </div>
          
      <div id="listGuest" style="width:100%; margin: 0px 0px 10px;"></div>

</div>
