<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
<style>
	td:first-child {
		text-align: center;
		font-weight: bold;
	}
</style>
<script>
	
	function fn_order_each_goods(goodsId){
		
		var isLogOn = document.getElementById("isLogOn").value;
		var orderGoodsQty = document.getElementById("orderGoodsQty").value;
		
		if (isLogOn == "" || isLogOn == "false") {
			alert("로그인 후 주문이 가능합니다.");
			location.href = "${contextPath}/member/loginForm";
			return;
		} 
		
		location.href = "${contextPath}/order/orderEachGoods?goodsId=" + goodsId + "&orderGoodsQty=" + orderGoodsQty;
		
	}
	
	$().ready(function(){
		
		$("#btn_cart").on("click" , function(e){
			var isLogOn = document.getElementById("isLogOn").value;
			if (isLogOn == "" || isLogOn == "false") {
				alert("로그인 후 장바구니를 사용하실수 있습니다.");
				location.href = "${contextPath}/member/loginForm";
				return;
			} 
			
			var orderGoodsQty = document.getElementById("orderGoodsQty").value;
			
			$.ajax({
				type : "post",
				url: '${contextPath}/cart/addNewGoods',
				data : {
					"memberId" : '${memberInfo}',
					"goodsId" : '${goods.goodsId}',
					"goodsCount" : orderGoodsQty
				},
				success:function(result){
					if(result == '0'){
						alert("장바구니에 추가를 하지 못하였습니다.");
					} else if(result == '1'){
						alert("장바구니에 추가되었습니다.");
					} else if(result == '2'){
						alert("장바구니에 이미 추가되어져 있습니다.");
					}
				},
				error : function(a,b,c) {
					console.log(a);
					console.log("");
					console.log(b);
					console.log("");
					console.log(c);
					console.log("");
				}
				
			});
			
		});
		

		
	});

</script>
</head>
<body>
	<h1>${goods.goodsTitle }</h1>
	<h2>${goods.goodsSinger} &nbsp; 저| ${goods.goodsComposer}</h2>
	<div id="goods_image">
		<figure>
			<img alt="HTML5 &amp; CSS3" src="${contextPath}/thumbnails?goodsFileName=${goods.goodsFileName}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">가격</td>
					<td class="active">
					   <fmt:formatNumber value="${goods.goodsPrice}" type="number" var="goodsPrice" /> ${goodsPrice}원
					</td>
				</tr>
				<tr>
					<td class="fixed">포인트적립</td>
					<td class="active">${goods.goodsPoint}P 적립</td>
				</tr>
				<tr>
					<td class="fixed">업로드 날짜</td>
					<td class="fixed"><fmt:formatDate value="${goods.goodsUploadDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td class="fixed">페이지 수</td>
					<td class="fixed">${goods.goodsTotalPage}쪽</td>
				</tr>
				<tr>
					<td class="fixed">배송료</td>
					<c:choose>
						<c:when test="${goods.goodsDeliveryPrice == 0}">
							<td class="fixed"><strong>무료</strong></td>
						</c:when>
						<c:otherwise>
							<td class="fixed"><strong>${goods.goodsDeliveryPrice}원</strong></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td class="fixed">배송안내</td>
					<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br> <strong>[휴일배송]</strong>
						휴일에도 배송받는 Service</td>
				</tr>
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">
				      <select style="width: 80px;" id="orderGoodsQty">
					  	<option value="1">1</option>
					  	<option value="2">2</option>
					  	<option value="3">3</option>
					  	<option value="4">4</option>
					  	<option value="5">5</option>
				       </select>
					 </td>
				</tr>
			</tbody>
		</table>
		<ul>
			<li><a class="buy" href="javascript:fn_order_each_goods('${goods.goodsId}')">구매하기 </a></li>
		</ul>
		<div align="right">
			<input type="button" id="btn_cart" value="장바구니 추가">
		</div>
	</div>
	<div class="clear"></div>
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>