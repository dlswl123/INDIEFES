<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function() {
	var message = "${message}";
	console.log("message:" + message);
	
	if (message == "success_insert") {
		alert("글이 성공적으로 저장되었습니다")
	} else if (message == "success_delete") {
		alert("글이 성공적으로 삭제되었습니다")
	}
	
	// 글쓰기버튼
	$("#btnRegist").click(function(){
		console.log("regist");
		location.href="/indiefes/board/regist";
	});
	
	// 검색버튼
	$("#btnSearch").click(function(){
		console.log("btnSearch");
// 		setPage();
//		setSearch();
// 		$("input[name=page]").val(1); // 검색시 페이지1로가기
// 		$("#pageForm").submit();
	});
	
	// 제목클릭
	$(".click_subject").click(function(e){
			e.preventDefault(); // 브라우저기능막기, a -링크 기능막기 
			var board_number = $(this).attr("data-board_number");
			$("input[name=board_number]").val(board_number);
			console.log("제목클릭" + board_number);
			
			var href = $(this).attr("href");
			$("#pageForm").attr("action",href).submit();
			
		
	}); // $(".click_subject")
}); // $(document)
</script>

<form id="pageForm" action="/indiefes/board/list">
	<input type="hidden" name="board_number" 
			value="${param.board_number}">
	<input type="hidden" name="page" 
			value="${pagingDto.page}">
	<input type="hidden" name="perPage" 
			value="${pagingDto.perPage}">
	<input type="hidden" name="searchType" 
			value="${pagingDto.searchType}">
	<input type="hidden" name="keyword" 
			value="${pagingDto.keyword}">
</form>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
<h1>Indiefes 게시판</h1>

	<select id="searchType">
		<option value="subject"
		<c:if test="${pagingDto.searchType == 'subject'}">
			selected
		</c:if>
		>제목</option>
		<option value="content"
		<c:if test="${pagingDto.searchType == 'content'}">
			selected
		</c:if>
		>내용</option>
		<option value="user_id"
		<c:if test="${pagingDto.searchType == 'user_id' }">
			selected
		</c:if>
		>작성자</option>
	</select>
		<input type="text" id = "keyword"
				placeholder="검색어를 입력하세요"value="${pagingDto.keyword}"/>
			<input type="button" value="검색버튼"id= "btnSearch"
				class= "btn btn-danger"/>
			<input type="button" class="btn btn-success"
		  		value="글쓰기" id="btnRegist">
		  	<div class="row">
			<div class="col-md-12">
				<table class="table">
					<thead>
						<tr>
							<td>글번호</td>
							<td>글제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${list}" var="boardVo">
						<tr>
							<!-- 글번호 -->
							<td>${boardVo.board_number}</td>
							<td>
								<a href="/indiefes/board/read?board_number=${boardVo.board_number}">
								<!-- class="click_subject" 
								data-board_number="${boardVo.board_number}" -->
								${boardVo.subject}</a>
								<c:if test="${boardVo.reply_count != 0 }">
								<span style="color: red;">[${ boardVo.reply_count }]</span>
								</c:if>
								<c:if test="${boardVo.view_count >= 100 }">
								<img src="<c:url value='/resources/images/heart_fill.png'/>" width="15">
								<!-- <span style="color: red;">hot</span> -->
								</c:if>
							</td>		
							<!-- 회원 -->
							<td>${boardVo.user_id}</td>
							<!-- 작성일 -->
							<td>
							<%-- <fmt:formatDate value=" --%>
							${boardVo.reg_date}
	
							<!-- pattern="yyyy/mm/dd HH:mm/ss"/> -->
							</td>
							<td>${boardVo.view_count}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</div>
			</div>
		</div>
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>