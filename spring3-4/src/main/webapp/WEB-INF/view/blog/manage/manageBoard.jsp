<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.category-list-layout{
    float: left;
}
.category-list {
    clear:both;
	width:200px;
	height:300px;
	text-align:left;
	padding:7px 7px 7px 7px;
	overflow-y:scroll;
    border:1px solid #ccc;
}
.category-list li{
	font-family: "Malgun Gothic", "Nanum Gothic", "Dotum";
	cursor: pointer;
	height: 22px;
	line-height: 22px;
	margin: 0px;
}
.category-list li:hover{
	background: #eee;
}
.category-list .li-active{
	background:#ddd;
}

.category-add {
    clear:both;
	width:210px;
	padding:7px 0 7px;
}

.category-update-form{
    float: left;
    padding-left: 20px;
    min-height: 350px;
}

.category-form {
	width:500px;
	overflow: visible;
	border-top:1px solid #ccc;
	text-align:left;
}
.form-bottomLine {
	height:40px;
	line-height:40px;
	border-bottom:1px solid #ccc;
	clear:both;
	text-align:left;
}
.form-noLine {
	height:40px;
	line-height:40px;
	clear:both;
	text-align:left;
}
.category-form dt {
	padding-left:20px;
	float:left;
	width:80px;
	height:40px;
	line-height:40px;
	text-align:left;
	background-color:#EEEEEE;
}
.category-form dd {
	padding-left:10px;
	float:left;
	width:390px;
	height:40px;
	line-height:40px;
	text-align:left;
}

.theme-list-update{
  border:1px solid #2f3741;
  clear: both;
  background-color:#F6F6F6;
  width: 570px;
  min-height: 250px;
  position: absolute;
  z-index: 1000;
}
.theme-list{
  clear:both;
}
.theme-list-item{
  float: left;
  width:120px;
  padding:10px;
}
.theme-group{
	font-weight: bold;
	padding: 3px;
}
.theme-data{
	cursor: pointer;
	padding: 3px;
	padding-left: 10px;
}
.theme-data:hover{
	background: #D8D8D8;
}
</style>

<script type="text/javascript">
// 왼쪽 카테고리를 선택한 경우
$(function(){
    $("body").on("click", ".category-list li", function(){
        $(".category-list li").each(function(){
        	$(this).removeClass("li-active");
        });
    	
    	$(this).addClass("li-active");
    	
    	var categoryNum=$(this).attr("data-categoryNum");
    	// 우측 수정 화면에 표시 
    	readCategory(categoryNum);
    });
});

$(function(){
	listCategory();
});

// 카테고리 리스트
function listCategory() {
	// 우측 수정 화면의 대분류 카테고리
	$("#f-groupClassify option").each(function() {
		$("#f-groupClassify option:eq(0)").remove();
	});
	$("#f-groupClassify").append("<option value='0'>지정하지 않음</option>");
	
	var blogSeq="${blogSeq}";
	var url="<%=cp%>/blog/"+blogSeq+"/categoryAllList";
	var bid="${blogInfo.userId}";

	$.post(url, {bid:bid, tmp:new Date().getTime()}, function(data){
        var count=data.count;
        var str="<ul>";
        str+="<li data-categoryNum='0' data-parent='0'><b>카테고리</b> <span id='categoryCount'>("+count+")</span></li>";
        for(var idx=0; idx<data.listCategory.length; idx++) {
        	var categoryNum=data.listCategory[idx].categoryNum;
        	var classify=data.listCategory[idx].classify;
        	var parent=data.listCategory[idx].parent;
        	
        	if(categoryNum==1) // 공지
        		continue;
        	
        	if(parent==0) {
        		str+="<li style='padding-left: 10px;' data-categoryNum='"+categoryNum+"'  data-parent='"+parent+"'>";
        		// 우측 수정화면
        		$("#f-groupClassify").append("<option value='"+categoryNum+"'>"+classify+"</option>");
        	} else {
        		str+="<li style='padding-left: 20px;' data-categoryNum='"+categoryNum+"'  data-parent='"+parent+"'>";
        	}
        	str+="<img src='<%=cp%>/resource/images/icon_list.gif' border='0'>&nbsp;";
        	str+=classify;
        	str+="</li>";
        }
    	str+="</ul>";
        $(".category-list").html(str);
        
   }, "json");

}

// 카테고리 추가 하기
function addCategory() {
	var blogSeq="${blogSeq}";
	var classify=$("#a-classify").val().trim();
	if(! classify) {
		$("#a-classify").focus();
		return;
	}
	
	var categoryNum="0";
	var parent="0";
	var flag=true;
    $(".category-list li").each(function(){
    	if($(this).is(".li-active")==true) {
    		categoryNum=$(this).attr("data-categoryNum");
    		parent=$(this).attr("data-parent");
    		if(parent=="0") {
    	    	parent=categoryNum;
    		} else {
    			flag=false;
    		}
    		
    		return false; // break;
    	}    	
    });
    
    if(! flag) {
    	alert("카테고리는 2단계 까지만 추가가 가능합니다.");
    	return;
    }
    
    var url="<%=cp%>/blog/"+blogSeq+"/categoryAdd";
    var query="parent="+parent+"&classify="+classify;
    
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				$("#a-classify").val("");
				listCategory();
			} else if(state=="false") {
				alert("카테고리를 추가하지 못했습니다.");
			} else if(state=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;
			} else if(state=="addFail") {
				location.href="<%=cp%>/nblog";
				return;
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

//  수정폼의 주제를 선택 한 경우
$(function(){
    $("body").on("click", ".theme-list-update .theme-data", function(){
      	$("#f-themeSubject").val($(this).text());
    	$("#f-themeNum").val($(this).attr("data-themeNum"));
    	
    	$(".theme-list-update").fadeOut(500);
    });
    
    $("#btnThemeUpdate").blur(function(){
    	$(".theme-list-update").fadeOut(500);
    });
});

function themeChange() {
	if($(".theme-list-update").is(':visible'))
		$(".theme-list-update").fadeOut(500);
	else
		$(".theme-list-update").fadeIn(500);
}

// 우측 수정 폼 초기화
function initUpdateForm() {
	$("#f-classify").val("");
	$("#f-categoryNum").val("0");
	$("#f-groupClassify").val("0");
	$("#f-groupClassify").val("0");
	$("#f-themeSubject").val("");
	$("#f-themeNum").val("0");
	$("#f-closed-no").prop("checked", false);
	$("#f-closed-yes").prop("checked", false);
}

// 해당 카테고리 정보 불러오기
function readCategory(categoryNum) {
	var blogSeq="${blogSeq}";
	var url="<%=cp%>/blog/"+blogSeq+"/categoryRead";

	initUpdateForm();
	if(categoryNum=="0") {
		return;
	}

	$.post(url, {categoryNum:categoryNum}, function(data){
		if(data.state=="true") {
        	var categoryNum=data.category.categoryNum;
        	var classify=data.category.classify;
        	var parent=data.category.parent;
        	var closed=data.category.closed;
        	var groupClassify=data.category.groupClassify;
        	var themeNum=data.category.themeNum;
        	var themeSubject=data.category.themeSubject;

        	if(groupClassify==null || groupClassify=="") {
        		groupClassify="지정하지 않음";
        		// 1차 분류는 대분류를 변경하지 못하게
        		$("#f-groupClassify").prop("disabled", true);
        	} else {
        		$("#f-groupClassify").prop("disabled", false);
        	}
        	if(themeSubject==null || themeSubject=="")
        		themeSubject="지정하지 않음";

        	$("#f-classify").val(classify);
        	$("#f-categoryNum").val(categoryNum);
        	$("#f-groupClassify").val(parent);
        	$("#f-themeSubject").val(themeSubject);
        	$("#f-themeNum").val(themeNum);
        	if(closed=="0")
        		$("#f-closed-no").prop("checked", true);
        	else
        		$("#f-closed-yes").prop("checked", true);
			
		} else if(data.state=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;
		}
	}, "json");
}

// 카테고리 정보 수정하기
function updateCategory() {
	var blogSeq="${blogSeq}";
	var url="<%=cp%>/blog/"+blogSeq+"/categoryUpdate";
	
    var categoryNum = $("#f-categoryNum").val();
    if(categoryNum==""||categoryNum=="0") {
    	alert("수정할 카테고리를 먼저 선택 하세요...");
    	return;
    }
	
	var classify=$("#f-classify").val();
	var parent=$("#f-groupClassify").val();
	var closed="0";
	if($('#f-closed-yes').is(':checked'))
		closed="1";
	var themeNum=$("#f-themeNum").val();
    
    var query="categoryNum="+categoryNum+"&classify="+classify;
    query+="&parent="+parent+"&closed="+closed+"&themeNum="+themeNum;
    
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			if(data.state=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;
			}
			
			listCategory();
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
	
}

// 카테고리 지우기
function deleteCategory() {
/*	
	var categoryNum="0";
    $(".category-list li").each(function(){
    	if($(this).is(".li-active")==true) {
    		categoryNum=$(this).attr("data-categoryNum");
    		return false; // break;
    	}    	
    });
*/

    var categoryNum = $("#f-categoryNum").val();
    if(categoryNum==""||categoryNum=="0") {
    	alert("삭제할 카테고리를 먼저 선택 하세요...");
    	return;
    }
    
    if(confirm("카테고리를 삭제하면 카테고리의 모든 게시물도 삭제 됩니다.\n카테고리를 삭제 하시겠습니까 ? ")) {
    	var blogSeq="${blogSeq}";
    	var url="<%=cp%>/blog/"+blogSeq+"/categoryDelete";
    	$.post(url, {categoryNum:categoryNum}, function(data){
    		if(data.state=="loginFail") {
    			location.href="<%=cp%>/member/login";
    			return;
    		}
    		
    		listCategory();
    		initUpdateForm();
    		
    	}, "json");
    }
}
</script>

<div>
         <div style="width: 100%; height: 30px; line-height: 30px; border-bottom: 1px solid #212121; margin-bottom: 20px;">
              <b>게시판 관리</b>
         </div>
         
         <div class="category-list-layout">
             <div class="category-list"></div>
             <div class="category-add">
                  <input type="text" id="a-classify" class="boxTF" style="width: 140px;" maxlength="30">
                  <button type="button" class="btn1" onclick="addCategory()">추가</button>
             </div>
             <div style="font-size: 8pt; width: 210px;  word-break:break-all;">
                 - 카테고리는 2단계까지 만들수 있으며,  1단계 카테고리를 선택하고 만들면 2단계로 만들어 집니다.
             </div>
         </div>
         
         <div class="category-update-form">
               <div class="category-form">
                   <div class="form-bottomLine">
                      <dl>
                         <dt>카테고리</dt>
                         <dd>
                             <input type="text" id="f-classify" style="width: 200px;" maxlength="30"  class="boxTF">
                             <input type="hidden" id="f-categoryNum">
                         </dd>
                      </dl>
                   </div>

                   <div class="form-bottomLine">
                      <dl>
                         <dt>대분류</dt>
                         <dd>
                             <select id="f-groupClassify" class="selectField" style="width: 210px;" >
                                 <option value="0">지정하지 않음</option>
                             </select>
                         </dd>
                      </dl>
                   </div>

                   <div class="form-bottomLine">
                      <dl>
                         <dt>공개여부</dt>
                         <dd>
                             <input type="radio" name="f-closed" id="f-closed-no"> 공개 &nbsp;&nbsp;
                             <input type="radio" name="f-closed" id="f-closed-yes"> 비공개
                         </dd>
                      </dl>
                   </div>

                   <div class="form-bottomLine">
                      <dl>
                         <dt>주제</dt>
                         <dd>
                             <input type="text" id="f-themeSubject" style="width: 200px;"
                                       maxlength="30"  class="boxTF" readonly="readonly">
                              <button type="button" class="btn1" onclick="themeChange();" id="btnThemeUpdate"> 변경 </button>
                              <input type="hidden" id="f-themeNum">
                         </dd>
                      </dl>
                   </div>
                   
                   <div class="theme-list-update" style="display: none;">
                        <div style="clear: both; height:25px; padding-top:10px; padding-left: 5px;">
                                <span style="display: block;" data-themeNum="0" class='theme-data'>지정하지 않음</span>
                        </div>
                        <div class="theme-list">
                           <c:forEach var="vo" items="${listTheme}" varStatus="status">
                               <c:if test="${status.index!=0 && vo.parent==0}">
                                   <c:out value="</div>" escapeXml="false"/>
                               </c:if>
                               <c:if test="${status.index==0 || (status.index!=0 && vo.parent==0)}">
                                   <c:out value="<div class='theme-list-item'>" escapeXml="false"/>
                               </c:if>
                               <span style="display: block;" data-themeNum="${vo.themeNum}" ${vo.parent!=0?" class='theme-data' ":" class='theme-group' "}>${vo.subject}</span>
                           </c:forEach>
                           <c:if test="${listTheme.size()!=0}">
                                <c:out value="</div>" escapeXml="false"/>
                           </c:if>
                        </div>
                   </div>
                   
                   <div style="clear: both; text-align: center; height: 40px; padding: 10px;">
                            <button type="button" class="btn1" onclick="updateCategory()">  수정 완료  </button>
                            <button type="button" class="btn1" onclick="deleteCategory()">  삭 제  </button>
                   </div>
                   
               </div>
         </div>
</div>