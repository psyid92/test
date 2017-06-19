<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function sendPhoto() {
    var f = document.photoForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

	str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

	var mode="${mode}";
	if(mode=="created"||mode=="update"&& f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			alert('이미지 파일만 가능합니다. !!!');
			f.upload.focus();
			return;
		}
	}
    
	var url;
    if(mode=="created") {
    	photoPage=1;
        url = "<%=cp%>/blog/${blogSeq}/photoCreated";
    } else if(mode=="update") {
        url = "<%=cp%>/blog/${blogSeq}/photoUpdate";
    }
    
   // var f=$("form")[0];
    var formData = new FormData(f); // IE는 10이상에서
    
	  $.ajax({
			 type:"post"
			 ,url:url
			 ,processData: false  // file 전송시 필수
	         ,contentType: false   // file 전송시 필수
	         ,data: formData
			 ,dataType:"json"
			 ,success:function(data) {
				var state=data.state;
				if(state=="loginFail") {
					location.href="<%=cp%>/member/login";
					return;
				}
				listPagePhoto(photoPage);
			}
			,error:function(e) {
				alert(e.responseText);
			}
		});
}
</script>

<div class="blog-body-content" style="padding-bottom: 0px;">
<form name="photoForm" method="post" enctype="multipart/form-data">
         <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
          <thead>
              <tr height="30">
                  <td colspan="2">
                      <span style="font-weight: bold;">${mode=="created"?"포토 등록":" 포토 수정"}</span>
                  </td>
              </tr>
              <tr><td colspan="2" height="1" bgcolor="#212121"></td></tr>
          </thead>
          
          <tbody>
		      <tr height="40">
			      <td width="90" style="text-align: left;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 98%;" value="${dto.subject}">
			      </td>
			  </tr>
            
			  <tr> 
			      <td width="90" style="text-align: left; padding-top:5px;" valign="top">설&nbsp;&nbsp;&nbsp;&nbsp;명</td>
			      <td valign="top" style="padding:5px 0px 5px 0px;">
			        <textarea name="content" cols="100" class="boxTA" style="width: 98%; height: 200px;">${dto.content}</textarea>
			      </td>
			  </tr>
			
			  <tr height="40">
			      <td width="90" style="text-align: left;">사&nbsp;&nbsp;&nbsp;&nbsp;진</td>
			      <td> 
                      <input type="file" name="upload" class="boxTF" style="width: 98%; height: 25px;">
			       </td>
			  </tr>
          
<c:if test="${mode=='update'}">			
			  <tr height="40">
			      <td width="90" style="text-align: left;">등록이미지</td>
			      <td> 
				        <img src="<%=cp%>/uploads/blog/${dto.blogId}/${dto.imageFilename}"
				                 width="30" height="30" border="0"
				                 style="cursor: pointer;">
			       </td>
			  </tr> 
</c:if>		          
          </tbody>
          
          <tfoot>
             <tr align="center" height="50" >
                 <td colspan="2">
					   <button type="button" class="btn1" onclick="sendPhoto();"> ${mode=="created"?"등록완료":"수정완료"} </button>
                       <button type="button" class="btn1" onclick="photoView();"> ${mode=="created"?"등록취소":"수정취소"} </button>
                 
 			         <c:if test="${mode=='update' }">
			            <input type="hidden" name="num" value="${dto.num}">
			        </c:if>

                 </td>
             </tr>
          </tfoot>
          </table>
</form>
</div>
