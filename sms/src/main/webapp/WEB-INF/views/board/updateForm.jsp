<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	$().ready(function() {

		var memberId = $("#memberId").val();
		
		$("form").submit(function(){
			
			var goodsTitle 		= $("#memberId").val();
			var boardSubject 	= $("#boardSubject").val();
			var boardContent	= $("#boardContent").val();
			
			if (goodsTitle == '') {
				alert("구매 상품을 입력하세요");
				return false;
			}
			if (boardSubject == '') {
				alert("제목을 입력하세요");
				return false;
			}
			if (boardContent == '') {
				alert("후기를 입력하세요");
				return false;
			}
		})
		

	});
</script>

</head>
<body>
	<h1>구매 후기 수정하기</h1>
	<br>
	<form action="${contextPath}/board/modifyBoard" method="post">
		<input type="hidden" name="boardNum" value="${boardDto.boardNum }">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="70%">
			</colgroup>
			<tr>
				<td align="center"><label for="memberId">아이디</label></td>
				<td><input class="form-control" id="memberId" value="${boardDto.memberId}" name="memberId" type="text" disabled /></td>
			</tr>
			<tr align="center">
				<td>구매 상품</td>
				<td><input class="form-control" id="goodsTitle" name="goodsTitle" type="text" value="${boardDto.goodsTitle }"/></td>
			</tr>
			<tr align="center">
				<td>조회수</td>
				<td align="left">${boardDto.readCount }</td>
			</tr>
			<tr align="center">
				<td>제목</td>
				<td><input class="form-control" id="boardSubject" name="boardSubject" type="text" value="${boardDto.boardSubject }" /></td>
			</tr>
			<tr align="center">
				<td>후기 작성</td>
				<td><textarea rows="20" class="form-control" id="boardContent" name="boardContent" >${boardDto.boardContent }</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" class="btn btn-primary btn-sm" value="수정하기"></td>
			</tr>
		</table>
		<p align="center">
			<img src="${contextPath }/resources/image/sms_logo1.PNG" width=300>
		</p>
	</form>
</body>
</html>
