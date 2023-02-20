<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<h3>상품 조회</h3>
	<div align="right">
		<input type="button" class="btn btn-Light btn-sm" value="Excel Export" onclick="location.href='${contextPath}/admin/goods/goodsExcelExport'" />
	</div>
	<table class="list_view">
		<tbody align="center">
			<tr style="background:blue; color:#fff; height: 50px;">
				<td>상품번호</td>
				<td>곡 제목</td>
				<td>가수</td>
				<td>작곡가</td>
				<td>상품가격</td>
				<td>업로드 날짜</td>
			</tr>
  				<c:choose>
    				<c:when test="${empty newGoodsList }">			
					<tr>
				       <td colspan="8" class="fixed"><strong>조회된 상품이 없습니다.</strong></td>
				    </tr>
			 	</c:when>
			 	<c:otherwise>
     				<c:forEach var="goods" items="${newGoodsList}">
						<tr>       
							<td><strong>${goods.goodsId}</strong></td>
							<td><a href="${contextPath}/admin/goods/modifyGoodsForm?goodsId=${goods.goodsId}"><strong>${goods.goodsTitle} </strong></a> </td>
							<td><strong>${goods.goodsSinger}</strong></td>
							<td><strong>${goods.goodsComposer}</strong></td>
							<td><strong>${goods.goodsPrice}</strong></td>
							<td><strong><fmt:formatDate value="${goods.goodsUploadDate}" pattern="yyyy-MM-dd"/> </strong></td>
						</tr>
					</c:forEach>
				</c:otherwise>
  			</c:choose>	        
		</tbody>
	</table>
	<br>
	<div align="right">
		<input class="btn btn-primary btn-sm" type="button" onclick="location.href='${contextPath}/admin/goods/addNewGoods'" value="상품 등록">
	</div>
</body>
</html>