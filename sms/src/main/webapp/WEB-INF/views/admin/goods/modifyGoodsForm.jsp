<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script>

	function fn_modify_goods(goodsId, attribute){
		//여기 다 수정 해야되요
		var frm_mod_goods = document.frm_mod_goods;
		
		var value = "";
		
		if 	    (attribute == 'goodsSort')				 value = frm_mod_goods.goodsSort.value;
		else if (attribute == 'goodsTitle')				 value = frm_mod_goods.goodsTitle.value;
		else if (attribute == 'goodsSinger')			 value = frm_mod_goods.goodsSinger.value;   
		else if (attribute == 'goodsComposer')		 	 value = frm_mod_goods.goodsComposer.value;
		else if (attribute == 'goodsPrice')			 	 value = frm_mod_goods.goodsPrice.value;
		else if (attribute == 'goodsPoint')			 	 value = frm_mod_goods.goodsPoint.value;
		else if (attribute == 'goodsUploadDate')	{
			var temp1 = frm_mod_goods.goodsUploadDate.value;
			var temp2 = temp1.split("-");
			value = temp2[0] + temp2[1] + temp2[2];
		}
		else if (attribute == 'goodsTotalPage')		 	 value = frm_mod_goods.goodsTotalPage.value;
		else if (attribute == 'goodsDeliveryPrice')	 	 value = frm_mod_goods.goodsDeliveryPrice.value;
		else if (attribute == 'goodsDeliveryDate')	{
			var temp1 = frm_mod_goods.goodsDeliveryDate.value;
			var temp2 = temp1.split("-");
			value = temp2[0] + temp2[1] + temp2[2];
		}
		else if (attribute == 'goodsStatus')			 value = frm_mod_goods.goodsStatus.value;
		
		$.ajax({
			type : "post",
			url : "${contextPath}/admin/goods/modifyGoodsInfo",
			data : {
				"goodsId"   : goodsId,
				"attribute" : attribute,
				"value"     : value
			},
			success : function() {
				alert("정보를 수정했습니다.");
			}
		});
	 }

	 function fn_modify_goods_image(goodsId){
	  	
		 var form = $('form')[0];
	     var formData = new FormData(form);
	     
	     formData.append("goodsId" , goodsId);
	     formData.append("goodsFileName" , $("#goodsFileName").val());
	     
	     $.ajax({
	     	url: '${contextPath}/admin/goods/modifyGoodsImageInfo',
	     	processData: false,
	     	contentType: false,
	     	data: formData,
	     	type: 'POST',
	     	success: function(result){
	         	alert("이미지를 수정했습니다.");
	       	}
	     });
	     
	 }
	
</script>
<style>
	td:first-child {
		text-align: center;
		font-weight: bold;
	}
</style>
</head>
<body>
	<div class="clear"></div>
	<div id="container">
		<form name="frm_mod_goods" method=post>
			<ul class="tabs">
				<li><a href="#tab1">상품 정보</a></li>
			</ul>
			<div class="tab_container">
				<div class="tab_content" id="tab1">
					<table class="table table-bordered table-hover">
						<colgroup>
							<col width="25%">
							<col width="65%">
							<col width="10%">
						</colgroup>
						<tr>
							<td>상품 분류</td>
							<td>
								<select name="goodsGenre" class="form-control" style="height:30; padding:0">
									<option value="가요" <c:if test="${goods.goodsGenre=='가요' }">selected </c:if>> 가요</option>
									<option value="POP"  <c:if test="${goods.goodsGenre=='POP' }">selected </c:if>>POP</option>
									<option value="OST"  <c:if test="${goods.goodsGenre=='OST' }">selected </c:if>>OST</option>
									<option value="재즈"  <c:if test="${goods.goodsGenre=='재즈' }">selected </c:if>>재즈</option>
									<option value="클래식"  <c:if test="${goods.goodsGenre=='클래식' }">selected </c:if>>클래식</option>
									<option value="동요"  <c:if test="${goods.goodsGenre=='동요' }">selected </c:if>>동요</option>
									<option value="CCM"  <c:if test="${goods.goodsGenre=='CCM' }">selected </c:if>>CCM</option>
								</select>
							</td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goodsId }','goodsSort')" /></td>
						</tr>
						<tr>
							<td>상품 종류</td>
							<td>
								<select name="goodsStatus" class="form-control" style="height:30; padding:0">
									<option value="bestseller" <c:if test="${goods.goodsStatus eq 'bestsller'}"> selected</c:if> >인기 악보</option>
									<option value="newScore" <c:if test="${goods.goodsStatus eq 'newScore'}"> selected</c:if> >최신 업로드</option>
									<option value="recommend" <c:if test="${goods.goodsStatus eq 'recommend'}"> selected</c:if> >추천 악보</option>
								</select> 
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsStatus')" /></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input name="goodsTitle" id="goodsTitle" type="text" class="form-control" value="${goods.goodsTitle}" /></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goodsId}','goodsTitle')" /></td>
						</tr>
						<tr>
							<td>가수</td>
							<td><input name="goodsSinger" type="text" class="form-control" value="${goods.goodsSinger}" /></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goodsId}','goodsSinger')" /></td>
						</tr>
						<tr>
							<td>작곡가</td>
							<td><input name="goodsComposer" type="text" class="form-control" value="${goods.goodsComposer}" /></td>
							<td><input type="button" class="btn btn-outline-primary btn-sm" value="수정" onClick="fn_modify_goods('${goods.goodsId}','goodsComposer')" /></td>
						</tr>
						<tr>
							<td>상품 가격</td>
							<td><input name="goodsPrice" type="text" class="form-control" value="${goods.goodsPrice}" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsPrice')" /></td>
						</tr>
						<tr>
							<td>상품 구매 포인트</td>
							<td><input name="goodsPoint" type="text" class="form-control" value="${goods.goodsPoint}" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsPoint')" /></td>
						</tr>
						<tr>
							<td>악보 업로드 날짜</td>
							<td><input name="goodsUploadDate" type="date" class="form-control" value="<fmt:formatDate value='${goods.goodsUploadDate}' pattern='yyyy-MM-dd'/>" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsUploadDate')" /></td>
						</tr>
						<tr>
							<td>악보 총 페이지수</td>
							<td><input name="goodsTotalPage" type="text" class="form-control" value="${goods.goodsTotalPage}" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsTotalPage')" /></td>
						</tr>
						<tr>
							<td>상품 배송비</td>
							<td><input name="goodsDeliveryPrice" type="text" class="form-control" value="${goods.goodsDeliveryPrice}" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsDeliveryPrice')" /></td>
						</tr>
						<tr>
							<td>상품 도착 예정일</td>
							<td><input name="goodsDeliveryDate" type="date" class="form-control" value="<fmt:formatDate value='${goods.goodsDeliveryDate}' pattern='yyyy-MM-dd'/>" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods('${goods.goodsId}','goodsDeliveryDate')" /></td>
						</tr>
						<tr style="height: 100px">
							<td>이미지</td>
							<td>파일명 : ${goods.goodsFileName} / <input name="goodsFileName" id="goodsFileName" type="file" /></td>
							<td><input type="button" value="수정" class="btn btn-outline-primary btn-sm" onClick="fn_modify_goods_image('${goods.goodsId}')" /></td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
</body>
</html>