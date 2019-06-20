<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function(){
	// 목록보기 버튼
	$("#btnList").click(function(){
		location.href="/indiefes/board/list";
	});

}); // $(document).ready
</script>
<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>수정하기</h1>
	<form role="form" method="post" action="/indiefes/board/update">
	<input type="hidden" name="board_number" 
			value="${param.board_number}">
			<div class="form-group">
				<label for=subject> 글제목 </label>
				<input type="text" class="form-control" id="subject" 
				name="subject"value="${boardVo.subject}" />
			</div>
			<div class="form-group">
				<label for="user_id">작성자</label> 
				<input type="text" class="form-control" id="user_id" 
						name="user_id" value="${boardVo.user_id}" readonly/>
			</div>
			<div class="form-group">
				<label for="content">글내용</label> 
				<textarea class="form-control" id="content" rows="10" cols="80"
					 	name="content" >${boardVo.content}</textarea>
			</div>
			<div class="form-group">
				<label for="view_count">조회수</label> 
				<input type="text" class="form-control" id="view_count" 
					value="${boardVo.view_count}" readonly/>
			</div>
			<div class="form-group">
				<label for="reg_date">작성일</label> 
				<input type="text" class="form-control" id="reg_date" 
					value='<fmt:formatDate value="${boardVo.reg_date}" 
					pattern="yyyy-MM-dd HH:mm:ss"/>' readonly/>
			</div>
			<div class="row">
				<div class="col-md-12">
					<input type="submit" class="btn btn-success" value="수정완료" id="btnUpdate"/>
					<button type="button" class="btn btn-warning" id="btnList">목록보기</button>
			   </div>
			</div>
			</form>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>