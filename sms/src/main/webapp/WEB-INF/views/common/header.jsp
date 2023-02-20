<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="logo">
		<a href="${contextPath}/main/main"> <img width="176" height="80"
			alt="sms_logo" src="${contextPath}/resources/image/sms_logo2.PNG">
		</a>
	</div>
	<div id="head_link">
		<ul>
			<c:choose>
				<c:when test="${isLogOn == true and memberInfo == 'admin' }">
					<li><a href="${contextPath}/admin/goods/adminGoodsMain">관리자
							화면</a></li>
					<li><a href="${contextPath}/member/logout">로그아웃</a></li>
				</c:when>
				<c:when test="${isLogOn == true and not empty memberInfo }">
					<li><a href="${contextPath}/member/logout">로그아웃</a></li>
					<li><a href="${contextPath}/cart/main">장바구니</a></li><!-- 장바구니 기능 넣을거임 -->
					<li><a href="${contextPath}/order/orderList">주문 목록</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${contextPath}/member/loginForm">로그인</a></li>
					<li><a href="${contextPath}/member/memberForm">회원가입</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>

</body>
</html>