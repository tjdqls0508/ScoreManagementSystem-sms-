<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<h3>주문 조회</h3>
	<div class="clear"></div>
	<table class="list_view">
		<tbody align=center>
			<tr style="background: blue; color: #fff; height: 50px">
				<td class="fixed">주문번호</td>
				<td class="fixed">주문시간</td>
				<td>주문내역</td>
				<td>배송상태</td>
			</tr>
			<c:choose>
				<c:when test="${empty orderList}">
					<tr>
						<td colspan="6" class="fixed"><strong>주문 내역이 없습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${orderList}" varStatus="i">
						<tr>
							<td width=10%><strong>${item.orderId}</strong></td>
							<td width=20%><strong><fmt:formatDate
										value="${item.payOrderTime}" pattern="yyyy-MM-dd HH:mm" /> </strong></td>
							<td width=50% align="left"><a
								href="${contextPath}/order/orderDetail?orderId=${item.orderId}">
									<strong>주문자 : ${item.ordererName}</strong><br> <strong>주문자
										연락처 : ${item.ordererHp}</strong><br> <br> <strong>수령자
										: ${item.receiverName}</strong><br> <strong>수령자 전화번호 :
										${item.receiverHp1}-${item.receiverHp2}-${item.receiverHp3}</strong><br>
									<strong>주문상품명(수량) :
										${item.goodsTitle}(${item.orderGoodsQty})</strong><br>
							</a></td>
							<td width=10%><c:if
									test="${item.deliveryState == 'deliveryPrepared'}">
									<div class="badge badge-info badge-pill">배송준비중</div>
								</c:if> <c:if test="${item.deliveryState == 'delivering'}">
									<div class="badge badge-secondary badge-pill">배송중</div>
								</c:if> <c:if test="${item.deliveryState == 'finishedDelivering'}">
									<div class="badge badge-primary badge-pill">배송완료</div>
								</c:if> <c:if test="${item.deliveryState == 'cancelOrder'}">
									<div class="badge badge-danger badge-pill">주문취소</div>
								</c:if> <c:if test="${item.deliveryState == 'returningGoods'}">
									<div class="badge badge-yellow badge-pill">반품</div>
								</c:if></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>