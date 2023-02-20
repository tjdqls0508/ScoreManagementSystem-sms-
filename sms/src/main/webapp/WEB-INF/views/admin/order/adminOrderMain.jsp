<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="utf-8">
<script>
	function fn_modify_order_state(orderId, selectId) {

		$.ajax({
			type : "get",
			url : "${contextPath}/admin/order/modifyDeliveryState",
			data : {
				"orderId" : orderId,
				"deliveryState" : document.getElementById(selectId).value
			},
			success : function() {
				alert("주문 정보를 수정했습니다.");
				location.href = "${contextPath}/admin/order/adminOrderMain";
			}

		});
	}
</script>
</head>
<body>
	<h3>주문 조회</h3>
	<div align="right">
		<input type="button" class="btn btn-Light btn-sm" value="Excel Export"
			onclick="location.href='${contextPath}/admin/order/orderExcelExport'" />
	</div>
	<div class="clear"></div>
	<table class="list_view">
		<tbody align=center>
			<tr style="background: blue; color: #fff; height: 50px">
				<td class="fixed">주문번호</td>
				<td class="fixed">주문시간</td>
				<td>주문내역</td>
				<td>배송상태</td>
				<td>배송수정</td>
			</tr>
			<c:choose>
				<c:when test="${empty newOrderList}">
					<tr>
						<td colspan=5 class="fixed"><strong>주문한 상품이 없습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${newOrderList}" varStatus="i">
						<tr>
							<td width=10%><strong>${item.orderId}</strong></td>
							<td width=20%><strong><fmt:formatDate
										value="${item.payOrderTime}" pattern="yyyy-MM-dd HH:mm" /> </strong></td>
							<td width=50% align="left"><a
								href="${contextPath}/admin/order/orderDetail?orderId=${item.orderId}">
									<strong>주문자 : ${item.ordererName}</strong><br> <strong>주문자
										연락처 : ${item.ordererHp}</strong><br>
								<br> <strong>수령자 : ${item.receiverName}</strong><br> <strong>수령자
										전화번호 :
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
							<td width=10%><select id="deliveryState${i.index }">
									<option value="deliveryPrepared"
										<c:if test="${item.deliveryState=='deliveryPrepared' }"> selected </c:if>>배송준비중</option>
									<option value="delivering"
										<c:if test="${item.deliveryState=='delivering' }"> selected </c:if>>배송중</option>
									<option value="finishedDelivering"
										<c:if test="${item.deliveryState=='finishedDelivering' }"> selected </c:if>>배송완료</option>
									<option value="cancelOrder"
										<c:if test="${item.deliveryState=='cancelOrder' }"> selected </c:if>>주문취소</option>
									<option value="returningGoods"
										<c:if test="${item.deliveryState=='returningGoods' }"> selected </c:if>>반품</option>
							</select> <input type="button" value="배송수정"
								class="btn btn-outline-blue btn-xs"
								onclick="fn_modify_order_state('${item.orderId}' ,'deliveryState${i.index}')" />
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>