<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
// 동적으로 추가된 태그도 이벤트 처리 가능
$(function(){
  	$("body").on("change", "form[name='boardForm'] input[name=upload]", function(){
  		if(! $(this).val()) {
  			return;	
  		}
  		
  		var b=false;
  		$("input[name=upload]").each(function(){
  			if(! $(this).val()) {
  				b=true;
  				return;
  			}
  		});
  		if(b)
  			return;

  		var $tr, $td, $input;
  		
  	    $tr=$("<tr height='40'>");
  	    $td=$("<td>", {width:"100", style:"text-align: left;", html:"첨&nbsp;&nbsp;&nbsp;&nbsp;부"});
  	    $tr.append($td);
  	    $td=$("<td>");
  	    $input=$("<input>", {type:"file", name:"upload", class:"boxTF", style:"width: 98%; height: 25px;"});
  	    $td.append($input);
  	    $tr.append($td);
  	    
  	    $("#tb").append($tr);
  	});
});
  
function sendBoard() {
        var f = document.boardForm;

    	var str = f.categoryNum.value;
        if(!str) {
            alert("카테고리를 선택 하세요. ");
            f.categoryNum.focus();
            return;
        }
        
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
        if(mode=="created")
            f.action = "<%=cp%>/blog/${blogSeq}/postInsert";
        else if(mode=="update")
            f.action = "<%=cp%>/blog/${blogSeq}/postUpdate";
            
       f.submit();
}
  
<c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="<%=cp%>/blog/${blogSeq}/postDeleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			if(data.state=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;
			}
			$("#f"+fileNum).remove();

		}, "json");
  }
</c:if>
</script>

<div class="blog-body-content" style="padding-bottom: 0px;">

<form name="boardForm" method="post" enctype="multipart/form-data">
    <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <thead>
            <tr height="30">
                <td colspan="2">
                      <span style="font-weight: bold;">${mode=="created"?"포스트 글쓰기":"포스트 글수정"}</span>
                </td>
            </tr>
            <tr><td colspan="2" height="1" bgcolor="#212121"></td></tr>
		 </thead>
		  
		 <tbody id="tb"> 
		    <tr height="40"> 
			      <td width="90" style="text-align: left;">카테고리</td>
			      <td> 
			          <select name="categoryNum" class="selectField" style="width: 210px;">
			              <option value="">:: 카테고리 선택 ::</option>
			              <c:forEach var="vo" items="${listCategory}">
			                  <option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.parent!=0?"&nbsp;&nbsp;&nbsp;":""} ${vo.classify}</option>
			              </c:forEach>
			          </select>
			      </td>
			  </tr>
            
		      <tr height="40"> 
			      <td width="90" style="text-align: left;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 98%;" value="${dto.subject}">
			      </td>
			  </tr>
            
			  <tr> 
			      <td width="90" style="text-align: left; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 0px;">
			        <textarea id="content" name="content" cols="100" rows="15" style="width: 98%; height: 270px;">${dto.content}</textarea>
			      </td>
			  </tr>
			
			  <tr height="40" >
			      <td width="90" style="text-align: left;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td> 
                      <input type="file" name="upload" class="boxTF" style="width: 98%; height: 25px;">			           
			       </td>
			  </tr>
         </tbody>
         
<c:if test="${mode=='update'}">
   <c:forEach var="vo" items="${listFile}">
                        <tr height="40"  id="f${vo.fileNum}"> 
                            <td width="90" style="text-align: left;">첨부파일</td>
                            <td> 
                                ${vo.originalFilename}
                                | <a href="javascript:deleteFile('${vo.fileNum}');">삭제</a>	        
                            </td>
                        </tr>
   </c:forEach>
</c:if>			
         
         <tfoot>
             <tr align="center" height="50" >
                 <td colspan="2">
					   <button type="button" class="btn1" onclick="sendBoard();"> ${mode=="created"?"등록완료":"수정완료"} </button>
                       <button type="button" class="btn1" onclick="javascript:location.href='<%=cp%>/blog/${blogSeq}';"> ${mode=="created"?"등록취소":"수정취소"} </button>
                 
                       <input type="hidden" name="blogSeq" value="${blogSeq}">
 			         <c:if test="${mode=='update' }">
			            <input type="hidden" name="num" value="${dto.num}">
			            <input type="hidden" name="category" value="${categoryNum}">
			            <input type="hidden" name="page" value="${page}">
			            <input type="hidden" name="menu" value="${menu}">
			        </c:if>

                 </td>
             </tr>
         </tfoot>
         
    </table>
</form>    
</div>