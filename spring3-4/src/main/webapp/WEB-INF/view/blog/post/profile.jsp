<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="blog-body-content" style="padding-bottom: 0px;">
      <div style="width:100%; height: 30px; line-height: 30px; border-bottom: 1px solid #212121;">
            <b>프로필</b>
      </div>

     <table style="width: 100%; margin: 0px auto 10px; border-spacing: 0px;">
			<tr height="40">
			     <td width="100" style="text-align:left;"><label style="font-weight: 700;">이름</label></td>
			     <td> 
						${blogInfo.isUserName=="1"?blogInfo.userName:"비공개" }
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
			     <td width="100" style="text-align:left; padding-top: 5px;" valign="top"><label style="font-weight: 700;">소개</label></td>
			     <td colspan="2" valign="top" style="white-space: pre; padding: 5px 0 5px 0;">${blogInfo.introduce}</td>
			</tr>
			<tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>

			<tr height="40">
			     <td width="100" style="text-align:left;"><label style="font-weight: 700;">성별</label></td>
			     <td> 
						${blogInfo.isGender=="1"?blogInfo.gender:"비공개" }
				 </td>
			</tr>
			<tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>

			<tr height="40">
			     <td width="100" style="text-align:left;"><label style="font-weight: 700;">지역</label></td>
			     <td> 
						${blogInfo.isCity=="1"?blogInfo.city:"비공개" }
				 </td>
			</tr>
			<tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>

			<tr height="40">
			     <td width="100" style="text-align:left;"><label style="font-weight: 700;">취미</label></td>
			     <td> 
						${blogInfo.isHobby=="1"?blogInfo.hobby:"비공개" }
				 </td>
			</tr>
			<tr><td colspan="2" height="1" bgcolor="#cccccc"></td></tr>
     </table>      

</div>
