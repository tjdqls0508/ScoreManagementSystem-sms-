<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/cart.css">
</head>
<script>
	
	function fn_order_each_goods(goodsId, goodsCount){
		location.href = "${contextPath}/order/orderEachGoods?goodsId=" + goodsId + "&orderGoodsQty=" + goodsCount;
	
	}
	function fn_remove_cart_goods(cartId){
		location.href = "${contextPath}/cart/delete?cartId=" + cartId;
	
	}
	$(document).ready(function() {
		
		
		/* 종합 정보 섹션 정보 삽입 */
		setTotalInfo();	
		
		$("#btn_remove_cart").click(function(){
			var delConfirm = confirm('정말 삭제 하시겠습니까?.');
			if (delConfirm) {
				var cartId = $("#cartId").val();
				var uri="${contextPath}/cart/delete?cartId="+cartId;
				$(location).attr('href', uri);
			} else {
				alert('삭제가 취소되었습니다.');
			}
		});
		/* 체크여부에따른 종합 정보 변화 */
		$(".individual_cart_checkbox").on("change", function(){
			/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
			setTotalInfo($(".cart_info_td"));
		});
		var chkAllList = $("tbody#cartTbody tr input[type='checkbox']");  // 전체 체크박스
		/* 체크여부에따른 종합 정보 변화 */
		chkAllList.change(function(){
			var allChk = $(".individual_cart_checkbox");
			if($(this).prop('checked')) { // 체크 - 전체체크 확인 후 전체선택 체크 안되어 있을 경우에만 전체선택 체크
				var checked = $("tbody#cartTbody tr input[type='checkbox']:checked");  // 체크박스
				if(allChk.prop('checked') && chkAllList.length === checked.length) {
					$(".all_check_input:first").prop('checked', true);
				}
			} else { // 해제 - 전체선택도 해제
				if(!allChk.prop('checked')){
					$(".all_check_input:first").prop('checked', false);
				}
			}
			
			
		});
		
		/* 체크박스 전체 선택 */
		$(".all_check_input").on("click", function(){
			/* 체크박스 체크/해제 */
			if($(".all_check_input").prop("checked")){
				$(".individual_cart_checkbox").prop('checked',true);
			} else{
				$(".individual_cart_checkbox").prop('checked',false);
			}
			
			/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
			setTotalInfo($(".cart_info_td"));	
			
		});
				/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
		function setTotalInfo(){
			
			let totalPrice = 0;				// 총 가격
			let totalCount = 0;				// 총 갯수
			let totalKind = 0;				// 총 종류
			let deliveryPrice = 0;			// 배송비
			let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)
			
			$(".cart_info_td").each(function(index, element){
				
				if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
					// 총 가격
					totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
					// 총 갯수
					totalCount += parseInt($(element).find(".individual_goodsCount_input").val());
					// 총 종류
					totalKind += 1;
				}
			});
			
			/* 배송비 결정 */
			if(totalPrice >= 30000){
				deliveryPrice = 0;
			} else if(totalPrice == 0){
				deliveryPrice = 0;
			} else {
				deliveryPrice = 3000;	
			}
			
				finalTotalPrice = totalPrice + deliveryPrice;
			
			/* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
			
			// 총 가격
			$(".totalPrice_span").text(totalPrice.toLocaleString());
			// 총 갯수
			$(".totalCount_span").text(totalCount);
			// 총 종류
			$(".totalKind_span").text(totalKind);
			// 배송비
			$(".delivery_price").text(deliveryPrice);
			// 최종 가격(총 가격 + 배송비)
			$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());		
		}
	});
	
	
			

</script>
<body>
	<h1>${memberInfo }님의 장바구니</h1>
	<!-- 체크박스 전체 여부 -->
	<div class="all_check_input_div">
		<input type="checkbox" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span>
	</div>	
	<table class="list_view">
		<tbody id="cartTbody" align=center>
			<tr style="background: blue; color:#fff; height: 50px;">
				<th class="td_width_1"></th>
				<td colspan=2 class="fixed">주문상품명</td>
				<td>가수</td>
				<td>작곡가</td>
				<td>수량</td>
				<td>상품 금액</td>
				<td>주문/삭제</td>
			</tr>
			<c:choose>
				<c:when test="${empty cartInfo }">
					<tr>
						<td colspan="8" class="fixed"><strong>장바구니가 비어 있습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${cartInfo }">
						<input type="hidden" id="goodsId" value="${item.goodsId}">
						<input type="hidden" id="goodsCount" value="${item.goodsCount}">
						<input type="hidden" id="totalPrice" value="${item.goodsPrice * item.goodsCount}">
						
						<tr>
							<td class="cart_info_td">
									<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
									<input type="hidden" class="individual_goodsPrice_input" value="${item.goodsPrice}">
									<input type="hidden" class="individual_goodsCount_input" value="${item.goodsCount}">
									<input type="hidden" class="individual_totalPrice_input" value="${item.goodsPrice * item.goodsCount}">
									<input type="hidden" class="individual_goodsId_input" value="${item.goodsId}">								
							</td>
							<td class="goods_image"><a
								href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }">
									<img width="75" alt="상품 이미지"
									src="${contextPath}/thumbnails?goodsFileName=${item.goodsFileName}">
							</a></td>
							<td><h2>
									<a
										href="${contextPath}/goods/goodsDetail?goodsId=${item.goodsId }">${item.goodsTitle}</a>
								</h2></td>
							<td><h2>${item.goodsSinger }</h2></td>
							<td><h2>${item.goodsComposer}</h2></td>
							<td><h2>${item.goodsCount }</h2></td>
							<td><h2>${item.goodsPrice * item.goodsCount}원</h2></td>
							<td>
								<input type="button" value="주문" onclick="fn_order_each_goods(${item.goodsId},${item.goodsCount })">
								<input type="button" value="삭제" id="btn_remove_cart">
								<input type="hidden" value="${item.cartId }" id="cartId">
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>총 상품 가격</td>
										<td>
											<span class="totalPrice_span">70000</span> 원
										</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>
											<span class="delivery_price">3000</span>원
										</td>
									</tr>									
									<tr>
										<td>총 주문 상품수</td>
										<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>권</td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="boundary_div">구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 결제 예상 금액</strong>
											</td>
											<td>
												<span class="finalTotalPrice_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 수량 조정 form -->
			<form action="${contextPath}/cart/update" method="post" class="quantity_update_form">
				<input type="hidden" name="cartId" class="update_cartId">
				<input type="hidden" name="goodsCount" class="update_goodsCount">
				<input type="hidden" name="memberId" value="${memberInfo}">
			</form>	
			
</body>
</html>				