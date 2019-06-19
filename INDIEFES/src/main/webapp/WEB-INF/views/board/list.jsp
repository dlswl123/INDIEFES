<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function(){
	var message = "${message}";
	console.log("message:" + message);
	
	if (message == "success_insert") {
		alert("글이 성공적으로 저장되었습니다")
	} else if (message == "success_delete") {
		alert("글이 성공적으로 삭제되었습니다")
	}
	
	// 글쓰기
	$("#btnRegist").click(function(){
		console.log("regist");
		location.href="/indiefes/board/regist";
		
	});
});
</script>
<h1>Indiefes 게시판</h1>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
		  <input type="button" class="btn btn-danger"
		  		value="글쓰기" id="btnRegist">
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
						<td>${boardVo.board_number}</td>
						<td>${boardVo.subject}</td>
						<td>${boardVo.user_id}</td>
						<td>${boardVo.reg_date}</td>
						<td>${boardVo.view_count}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>