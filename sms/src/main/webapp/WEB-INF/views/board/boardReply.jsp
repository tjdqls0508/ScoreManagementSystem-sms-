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
				alert("내용을 입력하세요");
				return false;
			}
		})
		

	});
</script>

</head>
<body>
	<h1>답글 작성하기</h1>
	<br>
	<form action="${contextPath}/board/writeReply" method="post">
		<input type="hidden" name="memberId" value="${memberInfo }">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="70%">
			</colgroup>
			<tr>
				<td align="center"><label for="memberId">답변 게시물 제목</label></td>
				<td>${boardDto.boardSubject }</td>
			</tr>
			<tr>
				<td align="center"><label for="memberId">아이디</label></td>
				<td><input class="form-control" id="memberId" value="${memberInfo}" name="memberId" type="text" disabled /></td>
			</tr>
			<tr align="center">
				<td>구매 상품</td>
				<td><input class="form-control" id="goodsTitle" name="goodsTitle" type="text" value="${boardDto.goodsTitle }"/></td>
			</tr>
			<tr align="center">
				<td>제목</td>
				<td><input class="form-control" id="boardSubject" name="boardSubject" type="text" placeholder="제목을 입력하세요." /></td>
			</tr>
			<tr align="center">
				<td>답글 내용</td>
				<td><textarea rows="20" class="form-control" id="boardContent" name="boardContent" placeholder="답글을 입력하세요."></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="hidden" name="ref" value="${boardDto.ref}">
					<input type="hidden" name="reStep" value="${boardDto.reStep}">
					<input type="hidden" name="reLevel" value="${boardDto.reLevel}">
					<input type="reset"  class="btn btn-Light btn-sm" value="다시쓰기" />
					<input type="submit" class="btn btn-Light btn-sm" value="답글쓰기">
				</td>
			</tr>
		</table>
		<p align="center">
			<img src="${contextPath }/resources/image/sms_logo1.PNG" width=300>
		</p>
	</form>
</body>
</html>
