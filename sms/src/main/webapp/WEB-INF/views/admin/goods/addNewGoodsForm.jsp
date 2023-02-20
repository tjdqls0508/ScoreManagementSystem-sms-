<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<meta charset="utf-8">
<head>
<script>

	function formValidationCheck(){
		
		var goodsTitle = document.f.goodsTitle;
		if (goodsTitle.value == ""){
			alert("곡 제목은 반드시 입력해야 합니다.");
			goodsTitle.focus();
			return false;
		}
		
		var goodsSinger = document.f.goodsSinger;
		if (goodsSinger.value == ""){
			alert("가수 이름은 반드시 입력해야 합니다.");
			goodsSinger.focus();
			return false;
		}
		
		var goodsComposer = document.f.goodsComposer;
		if (goodsComposer.value == ""){
			alert("작곡가는 반드시 입력해야 합니다.");
			goodsComposer.focus();
			return false;
		}
		
		var goodsPrice = document.f.goodsPrice;
		if (goodsPrice.value == ""){
			alert("상품 정가는 반드시 입력해야 합니다.");
			goodsPrice.focus();
			return false;
		}
		
		var goodsPoint = document.f.goodsPoint;
		if (goodsPoint.value == ""){
			alert("상품 구매 포인트는 반드시 입력해야 합니다.");
			goodsPoint.focus();
			return false;
		}
		
		var goodsUploadDate = document.f.goodsUploadDate;
		if (goodsUploadDate.value == ""){
			alert("상품 업로드 날짜는 반드시 입력해야 합니다.");
			goodsUploadDate.focus();
			return false;
		}
		
		var goodsTotalPage = document.f.goodsTotalPage;
		if (goodsTotalPage.value == ""){
			alert("제품 총 페이지수는 반드시 입력해야 합니다.");
			goodsTotalPage.focus();
			return false;
		}
		
		var goodsDeliveryPrice = document.f.goodsDeliveryPrice;
		if (goodsDeliveryPrice.value == ""){
			alert("배송비는 반드시 입력해야 합니다.");
			goodsDeliveryPrice.focus();
			return false;
		}
		
		var goodsDeliveryDate = document.f.goodsDeliveryDate;
		if (goodsDeliveryDate.value == ""){
			alert("상품 도착 예정일은 반드시 입력해야 합니다.");
			goodsDeliveryDate.focus();
			return false;
		}
		
		var goodsFileName = document.f.goodsFileName;
		if (document.f.goodsFileName.value == ""){
			alert("상품 이미지는 반드시 첨부해야 합니다.");
			goodsFileName.focus();
			return false;
		}
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
	<form action="${contextPath}/admin/goods/addNewGoods" name="f" method="post" enctype="multipart/form-data" onsubmit="return formValidationCheck()">
		<h1>새상품 등록창</h1>
		<div class="tab_container">
		<div class="tab_container" id="container">
			<ul class="tabs">
				<li><a href="#tab1">상품 정보</a></li>
			</ul>
			<div class="tab_container">
				<div class="tab_content" id="tab1">
					<table class="table table-bordered table-hover">			
						<tr>
							<td width=200>상품 장르</td>
							<td width=500>
								<select name="goodsGenre" class="form-control" style="padding-bottom:0; padding-top:0; height:35px">
									<option value="가요" selected> 가요</option>
									<option value="POP"  >POP</option>
									<option value="OST"  >OST</option>
									<option value="재즈" >재즈</option>
									<option value="클래식" >클래식</option>
									<option value="동요"  >동요</option>
									<option value="CCM"  >CCM</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>상품 종류</td>
							<td>
								<select name="goodsStatus" class="form-control" style="padding-bottom:0; padding-top:0; height:35px">
									<option value="bestseller">인기 악보</option>
									<option value="recommend">추천 악보</option>
									<option value="newScore" selected >최신 업로드</option>
								</select>
							</td>
						 </tr>
						<tr>
							<td>곡 제목</td>
							<td><input name="goodsTitle" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td >가수</td>
							<td><input name="goodsSinger" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>작곡가</td>
							<td><input name="goodsComposer" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 정가</td>
							<td><input name="goodsPrice" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 구매포인트</td>
							<td><input name="goodsPoint" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 업로드 날짜</td>
							<td><input  name="goodsUploadDate" type="date" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 총 페이지수</td>
							<td><input name="goodsTotalPage" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 배송비</td>
							<td><input name="goodsDeliveryPrice" type="text" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 도착 예정일</td>
							<td><input name="goodsDeliveryDate" type="date" class="form-control"/></td>
						</tr>
						<tr>
							<td>상품 이미지</td>
							<td><input name="goodsFileName" type="file" /></td>
						</tr>
					</table>	
				</div>
			</div>
			<p align="right">
				<input type="submit" value="등록하기" class="btn btn-outline-primary btn-sm">
			</p>
			</div>
		</div>
	</form>	
</body>
 