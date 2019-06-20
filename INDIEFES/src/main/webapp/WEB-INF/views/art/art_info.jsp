<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
	// 듣기버튼
	$("#btnListen").click(function() {
		
	});
	
	// 담기버튼
	$("#btnPut").click(function() {
		
	});
	
	// 다운버튼
	$("#btnDown").click(function() {
		
	});
	
	// 모두듣기버튼
	$("#btnAllListen").click(function() {
		
	});
	
	// 모두담기버튼
	$("#btnAllPut").click(function() {
		
	});
	
	// 뮤지션 전용 - 음악추가 버튼
	$("#btnMusicAdd").click(function() {
		
	});
	
	// 뮤지션 전용 - 완료버튼
	$("#btnSuccess").click(function() {
		
	});
	
	// 뮤지션 전용 - 취소버튼
	$("#btnCancel").click(function() {
		
	});
	
	// 운영자 전용 - 승인
	$("#btnAppro").click(function() {
		
	});
	
	// 운영자 전용 - 반려
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
						<strong>${artVo.art_title}</strong><br>
						<strong>${artVo.team_number}</strong><br>
						<small>${artVo.art_pr}</small>
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
						<button type="button" class="btn btn-outline-secondary" id="btnSuccess">완료</button>
						<button type="button" class="btn btn-outline-secondary" id="btnCancel">취소</button>
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
						<c:forEach items="${musicList}" var="musicInfoVo">
							<tr>
								<td><input type="checkbox" /></td>
								<td>${musicInfoVo.track_number}</td>
								<td class="song_name">${musicInfoVo.music_title}</td>
								<td>${artVo.team_number}</td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-caret-square-right"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-plus-square"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="far fa-list-alt"></i></span></td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-file-download"></i></span></td>
							<tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>


</body>
</html>