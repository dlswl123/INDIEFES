<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function(){
	// 글수정버튼
	$("#btnUpdate").click(function(){
//		console.log(btnUpdate);
		location.href = "/indiefes/board/update?board_number=${boardVo.board_number}";
	});
	// 목록보기버튼
	$("#btnList").click(function(){
//		console.log(btnList);
		location.href = "/indiefes/board/list";
	});
	
}); // $(document).ready
</script>
<form id="pageForm" action="board/list">
	<input type="hidden" name=board_number
	 		value="${param.board_number}">
</form>	 		

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<h1>글조회</h1>
			<form role="form" method="post">
				<div class="form-group">
					<label for="subject">글제목</label>
					<input type="text" class="form-control" id="subject"
					name="subject" value="${boardVo.subject}" readonly/>
				</div>
				<div class="form-group">
					<label for="user_id">작성자</label>
					<input type="text" class="form-control" id="user_id"
					name="user_id" value="${boardVo.user_id}" readonly/>
				</div> 
				<div class="form-group">
					<label for="content">글내용</label>
					<textarea class="form-control" id="content" rows="10" cols="80"
					name="content" readonly>${boardVo.content}</textarea>
				</div>
				<div class="form-group">
					<label for="view_count">조회수</label>
					<input type="text" class="form-control" id="view_count"
						value="${boardVo.view_count}" readonly/>
				</div>
				<div class="form-group">
					<label for="reg_date">작성일</label>
					<input type="text" class="form-control"	id="reg_date"
						value="${boardVo.reg_date}" readonly/>
				</div>
				</form>
			<div class="row">
				<div class="col-md-12">
					<input type="button" class="btn btn-success" value="글수정" id="btnUpdate"/>
					<input type="button" class="btn btn-danger" value="글삭제" id="btnDelete"/>
					<input type="button" class="btn btn-warning" value="목록보기" id="btnList"/>
					
				</div> <!-- class="col-md-12"-->
		 	</div> <!-- class="row"> -->
		</div> <!-- class="col-md-10" -->
	
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>