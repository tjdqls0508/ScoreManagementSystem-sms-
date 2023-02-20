<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script>
	
	$().ready(function(){
		
		$("#sortKeyword").change(function(){
			var sortKeyword = $("#sortKeyword").val();
			var url = "${contextPath}/goods/goodsStatus?goodsStatus=${goodsStatus}";
				url += "&sortKeyword=" + sortKeyword;
			
			location.href = url;	
		});
		
	});
	
</script>
<body>
	<c:choose>
		<c:when test="${goodsStatus == 'bestseller' }">
			<div class="main_book">
				<div align="right">
					<select id="sortKeyword">
						<option <c:if test="${sortKeyword eq lowPrice}"> selected</c:if>  value="lowPrice">낮은 가격순</option>
						<option <c:if test="${sortKeyword eq highPrice}"> selected</c:if> value="highPrice">높은 가격순</option>
						<option <c:if test="${sortKeyword eq hitsNum}"> selected</c:if>   value="hitsNum">조회수 순</option>
						<option <c:if test="${sortKeyword eq recent}"> selected</c:if>    value="recent">최신 순</option>
					</select>
				</div>
				<h3>인기 악보</h3>
				<c:forEach var="item" items="${goodsList }">
					<div class="book">
						<a
							href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img
							class="link" src="${contextPath}/resources/image/1px.gif"></a>
						<img width="121" height="154"
							src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
						<div class="title">${item.goodsTitle }</div>
						<div class="price">
							<fmt:formatNumber value="${item.goodsPrice}" type="number"
								var="goodsPrice" />${goodsPrice}원</div>
					</div>
				</c:forEach>
			</div>
			<div class="clear"></div>
		</c:when>
		<c:when test="${goodsStatus == 'newScore' }">
			<div class="main_book">
				<div align="right">
					<select id="sortKeyword">
						<option <c:if test="${sortKeyword eq lowPrice}"> selected</c:if> value="lowPrice">낮은 가격순</option>
						<option <c:if test="${sortKeyword eq highPrice}"> selected</c:if> value="highPrice">높은 가격순</option>
						<option <c:if test="${sortKeyword eq hitsNum}"> selected</c:if> value="hitsNum">조회수 순</option>
						<option <c:if test="${sortKeyword eq recent}"> selected</c:if> value="recent">최신 순</option>
					</select>
				</div>
				<h3>최신 악보</h3>
				<c:forEach var="item" items="${goodsList }">
					<div class="book">
						<a
							href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img
							class="link" src="${contextPath}/resources/image/1px.gif"></a>
						<img width="121" height="154"
							src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
						<div class="title">${item.goodsTitle }</div>
						<div class="price">
							<fmt:formatNumber value="${item.goodsPrice}" type="number"
								var="goodsPrice" />${goodsPrice}원</div>
					</div>
				</c:forEach>
			</div>
			<div class="clear"></div>
		</c:when>
		<c:when test="${goodsStatus == 'recommend' }">
			<div class="main_book">
				<div align="right">
					<select id="sortKeyword">
						<option <c:if test="${sortKeyword eq lowPrice}"> selected</c:if> value="lowPrice">낮은 가격순</option>
						<option <c:if test="${sortKeyword eq highPrice}"> selected</c:if> value="highPrice">높은 가격순</option>
						<option <c:if test="${sortKeyword eq hitsNum}"> selected</c:if> value="hitsNum">조회수 순</option>
						<option <c:if test="${sortKeyword eq recent}"> selected</c:if> value="recent">최신 순</option>
					</select>
				</div>
				<h3>추천 악보</h3>
				<c:forEach var="item" items="${goodsList }">
					<div class="book">
						<a
							href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }"><img
							class="link" src="${contextPath}/resources/image/1px.gif">
						</a> <img width="121" height="154"
							src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
						<div class="title">${item.goodsTitle }</div>
						<div class="price">
							<fmt:formatNumber value="${item.goodsPrice}" type="number"
								var="goodsPrice" />${goodsPrice}원</div>
					</div>
				</c:forEach>
			</div>
		</c:when>
	</c:choose>

</body>
</html>