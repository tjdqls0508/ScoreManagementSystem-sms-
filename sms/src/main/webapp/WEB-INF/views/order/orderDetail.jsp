<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
</head>
<script>
	$().ready(function() {
		
		var deliveryState = $("#deliveryState").val();
		
		$("#btn_cancelOrder").click(function(){
			var delConfirm = confirm('정말 취소 하시겠습니까?.');
			if (delConfirm) {
				
				if(deliveryState != 'deliveryPrepared'){
					alert('주문 준비중 외에는 주문은 취소 할 수 없습니다.');
				}
				else{
					var orderId = $("#orderId").val();
					var uri="${contextPath}/order/modifyDeliveryState?orderId="+orderId;
					$(location).attr('href', uri);
				}
			} else {
				alert('주문취소 신청이 취소되었습니다.');
			}
		});
		
	
	});



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
				location.href = "${contextPath}/order/orderList";
			}
	
		});
	}
</script>
<body>
	<h1>1. 주문 상세정보</h1>
	<table class="list_view">
		<tbody align=center>
			<tr style="background: blue; color:#fff; height: 50px;">
			    <td>주문번호 </td>
				<td colspan=2 class="fixed">주문상품명</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>배송비</td>
				<td>예상적립금</td>
				<td>주문금액합계</td>
			</tr>
				<tr>
				    <td>${orderMap.orderId }</td>
					<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail?goodsId=${orderMap.goodsId }">
					  	<img width="75" alt="상품 이미지" src="${contextPath}/thumbnails?goodsFileName=${orderMap.goodsFileName}">
					  </a>
					</td>
					<td><h2><a href="${contextPath}/goods/goodsDetail?goodsId=${orderMap.goodsId }">${orderMap.goodsTitle}</a></h2></td>
					<td><h2>${orderMap.orderGoodsQty}개</h2></td>
					<td><h2>${orderMap.orderGoodsQty * orderMap.goodsPrice}원</h2></td>
					<td><h2>${orderMap.goodsDeliveryPrice}</h2></td>
					<td><h2>${15 * orderMap.orderGoodsQty }원</h2></td>
					<td><h2>${orderMap.orderGoodsQty * orderMap.goodsPrice + orderMap.goodsDeliveryPrice}원</h2></td>
				</tr>
		</tbody>
	</table>
	<div class="clear"></div>
	<br>
	<br>
	<h1>2.배송 정보</h1>
	<div class="detail_table">
		<table>
			<tbody>
			  <tr class="dot_line">
				<td class="fixed_join">이름</td>
				<td>${orderMap.memberName}</td>
			  </tr>
			  <tr class="dot_line">
				<td class="fixed_join">핸드폰</td>
				<td>${orderMap.hp1} - ${orderMap.hp2} - ${orderMap.hp3}</td>
			  </tr>
			  <tr class="dot_line">
				<td class="fixed_join">이메일</td>
				<td>${orderMap.email1}@${orderMap.email2}</td>
			  </tr>
				<tr class="dot_line">
					<td class="fixed_join">배송방법</td>
					<td>${orderMap.deliveryMethod }</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">받으실 분</td>
					<td>${orderMap.receiverName }</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td>${orderMap.receiverHp1}-${orderMap.receiverHp2}-${orderMap.receiverHp3}</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>${orderMap.deliveryAddress}</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">배송 메시지</td>
					<td>${orderMap.deliveryMessage}</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">선물 포장</td>
					<td>${orderMap.giftWrapping}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="clear"></div>
	<br>
	<br>
	<h1>3.결제정보</h1>
	<div class="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">결제방법</td>
					<td>${orderMap.payMethod } </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">결제카드</td>
					<td>${orderMap.cardComName}</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">할부기간</td>
					<td> ${orderMap.cardPayMonth }</td>
				</tr>
			</tbody>
		</table>
		<div>
			<input type="button" value="주문 취소" id="btn_cancelOrder">
		</div>
	</div>
	<input type="hidden" name="orderId" id="orderId" value="${orderMap.orderId }">
	<input type="hidden" name="deliveryState" id="deliveryState" value="${orderMap.deliveryState }">
</body>
</html>				