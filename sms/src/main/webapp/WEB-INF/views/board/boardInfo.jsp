<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script>
	$().ready(function() {
		$("#btn_remove").click(function(){
			var delConfirm = confirm('정말 삭제 하시겠습니까?.');
			if (delConfirm) {
				var num = $("#aa").val();
				var uri="${contextPath}/board/removeBoard?boardNum="+num;
				$(location).attr('href', uri);
			} else {
				alert('삭제가 취소되었습니다.');
			}
		});
		
	
	});
</script>
<body>
	<!-- hidden으로 boardNum 보내기 -->
	<input type="hidden" id="aa" value="${boardDto.boardNum }" />
	<div>
		<h1>구매 후기 상세보기</h1>
	</div>
	<br>
	<table class="table table-hover">
		<colgroup>
			<col width="20%">
			<col width="70%">
		</colgroup>
		<tr>
			<td align="center"><label for="memberId">아이디</label></td>
			<td>${boardDto.memberId }</td>
		</tr>
		<tr>
			<td align="center">구매 상품</td>
			<td align="left">${boardDto.goodsTitle }</td>
		</tr>
		<tr align="center">
			<td>조회수</td>
			<td align="left">${boardDto.readCount }</td>
		</tr>
		<tr align="left">
			<td align="center">제목</td>
			<td align="left">${boardDto.boardSubject }</td>
		</tr>
		<tr align="left">
			<td align="center">내용</td>
			<td><textarea rows="20" class="form-control" id="boardContent" disabled>${boardDto.boardContent }</textarea></td>
		</tr>
		</table>
		<div align="right">
			<input type="button" class="btn btn-Light btn-sm" value="답글 작성하기" onclick="location.href='${contextPath}/board/writeReply?boardNum=${boardDto.boardNum }'">	
			<br><br>
			<c:choose>
				<c:when test="${isLogOn == true and memberInfo eq boardDto.memberId}">
					<div align="right">
						<input type="button" class="btn btn-Light btn-sm" value="수정하기" onclick="location.href='${contextPath}/board/modifyBoard?boardNum=${boardDto.boardNum }'">
						<input type="button" id="btn_remove"class="btn btn-Light btn-sm" value="삭제하기">
					</div>
				</c:when>
			</c:choose>
		</div>
		<p align="center">
	  		<img src="${contextPath }/resources/image/sms_logo1.PNG" width=300>
  		</p>
</body>
</html>
