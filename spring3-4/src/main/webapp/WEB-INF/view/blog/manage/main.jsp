<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

 <div class="bodyFrame4">
       <div class="blog-body-content"  id="manage-content" style="min-height: 600px;">
       
           <div style="width: 100%; height: 30px; line-height: 30px; border-bottom: 1px solid #212121;">
              <b>블로그 정보</b>
           </div>
           
        <div style="width: 100%; clear: both;">
			  <table style="width: 100%; border-spacing: 0px;">

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">이름</label></td>
			      <td> 
						${sessionScope.member.userName} (${blogInfo.isUserName=="1"?"공개":"비공개" })
				  </td>
				  <td rowspan="5" width="110" style="padding: 5px; padding-left: 10px;">
				       <div style="border: 1px solid #ccc; width: 100px; height: 100px; padding: 5px;">
                          <c:if test="${empty  blogInfo.photoFilename}">
                                 <img src="<%=cp%>/resource/images/noimage.png" width="100" height="100">
                          </c:if>
                          <c:if test="${not empty  blogInfo.photoFilename}">
                                 <img src="<%=cp%>/uploads/blog/${blogInfo.userId}/${blogInfo.photoFilename}" width="100" height="100">
                          </c:if>				       
				       </div>
				  </td>
			  </tr>
			  <tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">닉네임</label></td>
			      <td> 
						${blogInfo.nickName}
			      </td>
			  </tr>
			   <tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>
			
			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">성별</label></td>
			      <td> 
			            ${blogInfo.gender} (${blogInfo.isGender=="1"?"공개":"비공개" })
				  </td>
  			  </tr>
			   <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40"> 
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">블로그주제</label></td>
			      <td colspan="2"> 
			          ${blogInfo.subject} / ${blogInfo.groupSubject} 
			      </td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>
			
			  <tr height="40"> 
			      <td width="100" style="text-align:left; padding-right: 5px;"><label style="font-weight: 700;">제목</label></td>
			      <td colspan="2"> 
			           ${blogInfo.title}
			      </td>
			  </tr>
			   <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>
			
			  <tr> 
			      <td width="100" style="text-align:left; padding-top: 5px;" valign="top"><label style="font-weight: 700;">블로그 소개</label></td>
			      <td colspan="2" valign="top" style="padding:5px 0px 5px 0px; height: 30px; white-space:pre;">${blogInfo.introduce}</td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>
		
			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">지역</label></td>
			      <td colspan="2"> 
			            ${blogInfo.city} (${blogInfo.isCity=="1"?"공개":"비공개" })
				  </td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">취미</label></td>
			      <td colspan="2"> 
						${blogInfo.hobby} (${blogInfo.isHobby=="1"?"공개":"비공개" })
				  </td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">생성일자</label></td>
			      <td colspan="2"> 
						${blogInfo.created}
			      </td>
			  </tr>
		      <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">방문자수</label></td>
			      <td colspan="2"> 
						${blogInfo.visitorCount}
			      </td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr height="40">
			      <td width="100" style="text-align:left;"><label style="font-weight: 700;">블로그공개</label></td>
			      <td colspan="2"> 
			            ${blogInfo.closed=="0"?"공개":"비공개" }
			      </td>
			  </tr>
		      <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>

			  <tr> 
			      <td width="100" style="text-align:left; padding-top:5px; height: 50px;" valign="top"><label style="font-weight: 700;">프롤로그</label></td>
			      <td colspan="2" valign="top" style="padding:5px 0px 5px 0px; white-space:pre;">${blogInfo.prologue}</td>
			  </tr>
			  <tr><td colspan="3" height="1" bgcolor="#cccccc"></td></tr>
			  </table>

		</div>           

     </div>
 </div>