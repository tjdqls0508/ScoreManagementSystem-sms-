<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath }/resources/css/cart.css">
</head>
<script type="text/javascript">
	$().ready(function() {

		$("#onePageViewCount").change(function() {

			var onePageViewCount = $("#onePageViewCount").val();
			var searchKeyword = $("#searchKeyword").val();
			var searchWord = $("#searchWord").val();

			var url = "${contextPath}/board/main?";
			url += "onePageViewCount=" + onePageViewCount;
			url += "&searchKeyword=" + searchKeyword;
			url += "&searchWord=" + searchWord;

			location.href = url;

		});

		$("#getSearchBoard").click(function() {

			var onePageViewCount = $("#onePageViewCount").val();
			var searchKeyword = $("#searchKeyword").val();
			var searchWord = $("#searchWord").val();

			var url = "${contextPath}/board/main?";
			url += "onePageViewCount=" + onePageViewCount;
			url += "&searchKeyword=" + searchKeyword;
			url += "&searchWord=" + searchWord;

			location.href = url;

		});

	});
</script>
<body>
	<h3>구매 후기</h3>
	<label>
		<select id="onePageViewCount">
			<option <c:if test="${onePageViewCount eq 5}"> selected</c:if>  value="5">5</option>
			<option <c:if test="${onePageViewCount eq 7}"> selected</c:if>  value="7">7</option>
			<option <c:if test="${onePageViewCount eq 10}"> selected</c:if> value="10">10</option>
		</select> 개씩 보기
	</label>
	<c:choose>
		<c:when test="${isLogOn == true and not empty memberInfo }">
			<div align="right">
				<input type="button" class="btn btn-Light btn-sm" value="후기 작성하기"
					onclick="location.href='${contextPath}/board/write'">
			</div>
		</c:when>
	</c:choose>

	<table class="list_view">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="40%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<tbody align=center>
			<tr align=center style="background: blue; color: #fff; height: 50px;">
				<td width=15%>회원아이디</td>
				<td width=15%>구매 상품</td>
				<td width=40%>제목</td>
				<td width=15%>조회수</td>
				<td width=15%>등록일</td>
			</tr>
			<c:choose>
				<c:when test="${empty boardDto}">
					<tr>
						<td colspan="5" class="fixed"><strong>조회된 후기가 없습니다.</strong>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:set var="order" value="${totalBoardCount - (currentPageNumber-1) * onePageViewCount}"/>
					<c:forEach var="boardDto" items="${boardDto}">
						<tr>
							<c:set var="order" value="${order - 1}"/>
							<td>
								<c:if test="${boardDto.reStep > 1 }">
									<c:forEach var="j" begin="0" end="${(boardDto.reLevel-1 ) * 5 }">
										&nbsp;
									</c:forEach>
								</c:if>
								<strong>${boardDto.memberId}</strong>
							</td>
							<td><strong>${boardDto.goodsTitle}</strong><br></td>
							<td><a
								href="${contextPath }/board/info?boardNum=${boardDto.boardNum}"><strong>${boardDto.boardSubject}</strong></a>
							</td>
							<td><strong>${boardDto.readCount}</strong><br></td>
							<td><strong><fmt:formatDate
										value="${boardDto.boardRegDate}" pattern="yyyy-MM-dd" /></strong></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="5" align="center">
					<select id="searchKeyword" style="width: 100px;">
						<option <c:if test="${searchKeyword eq 'total'}"> selected</c:if> 		 value="total">전체</option>
						<option <c:if test="${searchKeyword eq 'memberId'}"> selected</c:if> 	 value="memberId">아이디</option>
						<option <c:if test="${searchKeyword eq 'boardSubject'}"> selected</c:if> value="boardSubject">제목</option>
					</select> 
					<input type="text" style="width: 300px;"id="searchWord" name="searchWord" value="${searchWord}"> 
					<input type="button" value="검색" id="getSearchBoard">
				</td>
			</tr>
		</tbody>
	</table>
	<div style="display: table; margin-left: auto; margin-right: auto">
		<div class="dataTables_paginate paging_simple_numbers"
			id="dataTable_paginate">
			<c:if test="${totalBoardCount gt 0 }">
				<ul class="pagination">
					<c:if test="${startPage gt 10 }">
						<li class="paginate_button page-item previous"
							id="dataTable_previous"><a
							href="${contextPath }/board/main?currentPageNumber=${startPage - 10}&onePageViewCount=${onePageViewCount}&searchKeyword=${searchKeyword}&searchWord=${searchWord}"
							aria-controls="dataTable" data-dt-idx="0" tabindex="0"
							class="page-link">Previous</a></li>
					</c:if>
					<c:forEach var="i" begin="${startPage}" end="${endPage }">
						<li class="paginate_button page-item"><a
							href="${contextPath }/board/main?currentPageNumber=${i}&onePageViewCount=${onePageViewCount}&searchKeyword=${searchKeyword}&searchWord=${searchWord}"
							aria-controls="dataTable" data-dt-idx="1" tabindex="0"
							class="page-link">${i}</a></li>
					</c:forEach>
					<c:if test="${endPage le totalBoardCount && endPage ge 10}">
						<li class="paginate_button page-item next" id="dataTable_next">
							<a
							href="${contextPath }/board/main?currentPageNumber=${startPage + 10}&onePageViewCount=${onePageViewCount}&searchKeyword=${searchKeyword}&searchWord=${searchWord}"
							aria-controls="dataTable" data-dt-idx="7" tabindex="0"
							class="page-link">Next</a>
						</li>
					</c:if>
				</ul>
			</c:if>
		</div>
	</div>
</body>
</html>