<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>

<style>
	th {
    height: 100px;
	}
  .song_name {
    width: 50%;
  }
  .btn {border-radius: 12px;}
</style>



<script>
$(document).ready(function() {
// 		사용자용
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
	// 사용자용 끝
	
// 		뮤지션용
	// 음악추가 버튼
	$("#btnMusicInput").click(function() {
		
	});
	
	// 파일업로드버튼
	$("#btnFile").click(function(e) {
		$("#inputFile").trigger("click");
	});
	$("#inputFile").change(function(e) {
// 		console.log(this.files[0].name);
		$("#txtFile").val(this.files[0].name);
		$("#spanFile").text(this.files[0].name);
		
	});
	
	
	
	// 앨범등록 버튼
	$("#btnArtAdd").click(function() {
		
	});
	
	// 등록취소 버튼
	$("#btnCancel").click(function() {
		
	});
	
	// 추가 버튼
	$("#btnMusicAdd").click(function() {
		
	});
	
	// 취소 버튼
	$("#btnMusicCancel").click(function() {
		$("#spanFile").text("");
		$("#songName").val("");
	});
	
	// 뮤직수정 버튼
	$("#btnMusicModify").click(function() {
		
	});
	// 뮤직 삭제 버튼
	$("#btnMusicDelete").click(function() {
		
	});
	// 가사등록 버튼
	$("#btnLyrics").click(function() {
		
	});
	// 뮤지션용 끝
	
// 		운영자용
	// 승인
	$("#btnAppro").click(function() {
		
	});
	
	// 반려
	$("#btnReturn").click(function() {
		
	});
	// 운영자용 끝
});
</script>
	
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div class="row">
					<h1>앨범 정보</h1>
			</div>
			<div class="row">
<!-- 				<div class="col-md-1"> -->
<!-- 				</div> -->
				<div class="col-md-3">
					<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-9">
					<p>
						<strong>${artVo.art_title}</strong><br>
<%-- 						<strong>${artVo.team_number}</strong><br> --%>
						<strong>${team_name}</strong><br>
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
						<button type="button" class="btn btn-outline-secondary" id="btnMusicInput">음악추가</button>
						<button type="button" class="btn btn-outline-secondary" id="btnArtAdd">앨범등록</button>
						<button type="button" class="btn btn-outline-secondary" id="btnCancel">등록취소</button>
						
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnAppro">승인</button>
						<button type="button" class="btn btn-outline-secondary" id="btnReturn">반려</button>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
				
				</div>
			</div>
<%-- 			<c:if test="userVo.user_level == 2"> --%>
			<div class="row">
				<div class="col-md-12 musicInput">
				<!-- 음악추가폼 -->
					<form name="fileForm" action="art/musicUpload" method="post" enctype="multipart/form-data">
						<div>
<!-- 							<label>트랙넘버</label> -->
<!-- 							<input type="text"> -->
							<label>노래제목</label>
							<input type="text" id="songName">
				        	<input type="file" name="file_path" id="inputFile" style="display:none;">
							<input type="button" value="파일찾기" id="btnFile" class="btn btn-sm btn-success">
							<span id="spanFile"></span>
							<button type="button" class="btn btn-sm btn-primary" id="btnMusicAdd">추가</button>
							<button type="button" class="btn btn-sm btn-danger" id="btnMusicCancel">취소</button>
						</div>
				    </form>
			    <!-- 음악추가폼 끝 -->
				</div>
			</div>
<%-- 			</c:if> --%>
			
			<div class="row">
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox" /></th>
								<th>번호</th>
								<th class="song_name">곡</th>
								<th>아티스트</th>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${userVo.user_level == 2}"> --%>
										<th>수정</th>
										<th>삭제</th>
										<th>가사</th>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
										<th>듣기</th>
										<th>담기</th>
										<th>가사</th>
										<th>다운</th>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${musicList}" var="musicInfoVo">
							<tr>
								<td><input type="checkbox" /></td>
								<td>${musicInfoVo.track_number}</td>
								<td class="song_name">${musicInfoVo.music_title}</td>
<%-- 								<td>${artVo.team_number}</td> --%>
								<td>${team_name}</td>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${userVo.user_level == 2}"> --%>
										<td><Button type="button" class="btn btn-sm btn-warning" id="btnMusicModify">수정</Button></td>
										<td><Button type="button" class="btn btn-sm btn-danger" id="btnMusicDelete">삭제</Button></td>
										<td><Button type="button" class="btn btn-sm btn-success" id="btnLyrics">등록</Button></td>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
										<td><span style="color:blue; size: 10px"><i class="fas fa-caret-square-right"></i></span></td>
										<td><span style="color:blue; size: 10px"><i class="fas fa-plus-square"></i></span></td>
										<td><span style="color:blue; size: 10px"><i class="far fa-list-alt"></i></span></td>
										<td><span style="color:blue; size: 10px"><i class="fas fa-file-download"></i></span></td>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
							<tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>