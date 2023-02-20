<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="main_book">
		<h3>가요</h3>
		<c:forEach var="item" items="${gayo }">
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link"  src="${contextPath}/resources/image/1px.gif"></a> 
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
	  	</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book">
	 	<h3>POP</h3>
	 	<c:forEach var="item" items="${pop }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book" >
		<h3>OST</h3>
		<c:forEach var="item" items="${ost }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link"  src="${contextPath}/resources/image/1px.gif"> </a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber  value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book">
	 	<h3>재즈</h3>
	 	<c:forEach var="item" items="${jazz }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book">
	 	<h3>클래식</h3>
	 	<c:forEach var="item" items="${classic }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book">
	 	<h3>동요</h3>
	 	<c:forEach var="item" items="${dongyo }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	<div class="main_book">
	 	<h3>CCM</h3>
	 	<c:forEach var="item" items="${ccm }" >
			<div class="book">
				<a href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img class="link" src="${contextPath}/resources/image/1px.gif"></a>
				<img width="121" height="154" src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
				<div class="title">${item.goodsTitle }</div>
				<div class="price"><fmt:formatNumber value="${item.goodsPrice}" type="number" var="goodsPrice" />${goodsPrice}원</div>
			</div>
		</c:forEach>
	</div>
	
	<div class="clear"></div>
	
	
</body>
</html>