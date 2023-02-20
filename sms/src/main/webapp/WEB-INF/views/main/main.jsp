<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="main_book">
		<h3>인기 악보</h3>
		<c:forEach var="item" items="${bestseller }">
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link"  src="${contextPath}/resources/image/1px.gif"></a> 
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
	  	</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div id="ad_sub_banner">
		<img width="770" height="117" src="${contextPath}/resources/image/music_banner01.jpg">
	</div>
	
	<div class="main_book">
	 	<h3>최신 업로드</h3>
	 	<c:forEach var="item" items="${newScore }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div id="ad_sub_banner">
		<img width="770" height="117" src="${contextPath}/resources/image/music_banner02.jpg">
	</div>
	
	<div class="main_book" >
		<h3>추천 악보</h3>
		<c:forEach var="item" items="${recommend }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link"  src="${contextPath}/resources/image/1px.gif"> </a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber  value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>