<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	<h3>회원 조회</h3>
	<div align="right">
		<input type="button" class="btn btn-Light btn-sm" value="Excel Export" onclick="location.href='${contextPath}/admin/member/memberExcelExport'" />
	</div>
	<table class="list_view">
	 <colgroup>
	 	<col width="15%">
	 	<col width="10%">
	 	<col width="15%">
	 	<col width="37%">
	 	<col width="13%">
	 	<col width="10%">
	 </colgroup>
	 <tbody align=center >
	  <tr align=center style="background:blue; color:#fff; height: 50px;">
		<td width=10%>회원아이디</td>
		<td width=10%>회원이름</td>
		<td width=10%>휴대폰번호</td>
		<td width=50%>주소</td>
		<td width=10%>가입일</td>
	   </tr>
	   <c:choose>
	     <c:when test="${empty memberList}">			
			<tr>
		       <td colspan="5" class="fixed">
				  <strong>조회된 회원이 없습니다.</strong>
			   </td>
		     </tr>
		 </c:when>
		 <c:otherwise>
		     <c:forEach var="member" items="${memberList}" >
	            <tr>       
					<td>
						<a href="${pageContext.request.contextPath}/admin/member/memberDetail?memberId=${member.memberId}"><strong>${member.memberId}</strong></a>
					</td>
					<td>
						<strong>${member.memberName}</strong><br>
					</td>
					<td>
						<strong>${member.hp1}-${member.hp2}-${member.hp3}</strong><br>
					</td>
					<td>
						<strong>${member.roadAddress}</strong><br>
						<strong>${member.jibunAddress}</strong><br>
						<strong>${member.namujiAddress}</strong><br>
					</td>
					<td>
						<strong><fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd"/></strong>
				    </td>
				</tr>
				</c:forEach>
			</c:otherwise>
		  </c:choose>	
	 </tbody>
	</table>
</body>
</html>