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
	
	// 글쓰기
	$("#btnRegist").click(function(){
		console.log("regist");
		location.href="/indiefes/board/regist";
		
	// 제목클릭
	$(".click_subject").click(function(e){
			e.preventDefault(); // 브라우저기능막기, a -링크 기능막기 
			var board_number = $(this).attr("data-board_number");
			$("input[name=board_number]").val(board_number);
			console.log("제목클릭" + board_number);
			
			var href = $(this).attr("href");
			$("#pageForm").attr("action",href).submit();
			
		}); // $(".click_subject")
	}); // $("#btnRegist").click
}); // $(document)
</script>
<form id="pageForm" action="/board/list">
	<input type="hidden" name="board_number" 
				value="${param.board_number}">
</form>
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
		<h1>Indiefes 게시판</h1>
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
						<!-- 글번호 -->
						<td>${boardVo.board_number}</td>
						<td>
							<a href="/indiefes/board/read?board_number=${boardVo.board_number}">
							<!-- class="click_subject" 
							data-board_number="${boardVo.board_number}" -->
							${boardVo.subject}</a>
							<span style="color: red;">[${ boardVo.reply_count }]</span>
							<c:if test="${boardVo.view_count >= 10 }">
							<img src="../../../resources/bg_images/heart_fill.png" width="15">
							<!-- 조회수 10 이상표시<span style="color: red;">hot</span> -->
							</c:if>
						</td>		
						<!-- 회원 -->
						<td>${boardVo.user_id}</td>
						<!-- 작성일 -->
						<td><fmt:formatDate value="${boardVo.reg_date}"
							pattern="yyyy/mm/dd HH:mm/ss"/></td>
							<td>${boardVo.view_count}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>