<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../include/header.jsp" %>  

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>글 삭제</h1>
	<br>
	<!-- /board/delete-run = 절대경로 -->
	<!-- => http://localhost/board/delete-run -->
	<!-- board/delete-run = 상대경로 -->
	<!-- => http://localhost/board(현재 내가있는 디렉토리)/board/delete-run -->
	<!-- => /indiefes/board/delete-run -->
	
	<form role="form" action="/indiefes/board/delete-run" method="post">
	삭제를 계속진행하시겠습니까?
	<input type="hidden" name="board_number" value="${param.board_number}">
	<input type="submit" class="btn btn-danger"  value="확인" />
	</form>
</div>
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>