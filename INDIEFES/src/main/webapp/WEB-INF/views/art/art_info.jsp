<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>앨범정보 - INDIEFES</title>
<style>
	th {
    height: 100px;
	}
  .song_name {
    width: 50%;
  }
  .btn {border-radius: 12px;}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/9d5a98c207.js"></script>

<script>
$(document).ready(function() {
	$("#btnListen").click(function() {
		
	});
	$("#btnPut").click(function() {
		
	});
	$("#btnDown").click(function() {
		
	});
	$("#btnAllListen").click(function() {
		
	});
	$("#btnAllPut").click(function() {
		
	});
	$("#btnMusicAdd").click(function() {
		
	});
	$("#btn").click(function() {
		
	});
	$("#btn").click(function() {
		
	});
	$("#btnAppro").click(function() {
		
	});
	$("#btnReturn").click(function() {
		
	});
});
</script>
</head>
<body>
<h1>앨범 정보</h1>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-1">
				</div>
				<div class="col-md-3">
					<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-8">
					<p>
						<strong>앨범이름</strong><br>
						<strong>가수이름</strong><br>
						<small>앨범설명</small>
					</p>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
<!-- 				실행버튼 -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${userVo.user_level == 3}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnListen">듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnPut">담기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnDown">다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllListen">전체듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllPut">전체담기</button>
<%-- 					</c:when> --%>
<%-- 					<c:when test="${userVo.user_level == 2}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnMusicAdd">음악추가</button>
						<button type="button" class="btn btn-outline-secondary" id="btnSuccese">완료</button>
						<button type="button" class="btn btn-outline-secondary" id="btnCancle">취소</button>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnAppro">승인</button>
						<button type="button" class="btn btn-outline-secondary" id="btnReturn">반려</button>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
				
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox" /></th>
								<th>번호</th>
								<th class="song_name">곡</th>
								<th>아티스트</th>
								<th>듣기</th>
								<th>담기</th>
								<th>가사</th>
								<th>다운</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox" /></td>
								<td>1</td>
								<td class="song_name">곡</td>
								<td>아티스트블라블라</td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-caret-square-right"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-plus-square"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="far fa-list-alt"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-file-download"></i></span></td>
							<tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>


</body>
</html>