<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="blog-body-content" style="padding-bottom: 0px;">
      <div style="width:100%; height: 30px; line-height: 30px; border-bottom: 1px solid #212121;">
            <b>프롤로그</b>
      </div>
      
     <table style="width: 100%; margin: 0px auto 10px; border-spacing: 0px;">
          <tr height="35">
                <td colspan="2" align="center">
                      ${blogInfo.title}
                </td>
          </tr>
          <tr><td colspan="2" height="1" bgcolor="#ccc"></td></tr>
          <tr height="35">
                <td width="50%" align="left">
                      ${blogInfo.subject} / ${blogInfo.groupSubject}
                </td>
                <td width="50%" align="right">
                      방문 ${blogInfo.visitorCount} | ${blogInfo.created}
                </td>
          </tr>

          <tr>
             <td colspan="2" valign="top" style="height: 70px; white-space: pre;">${blogInfo.prologue}</td>
          </tr>
      </table>      

</div>
