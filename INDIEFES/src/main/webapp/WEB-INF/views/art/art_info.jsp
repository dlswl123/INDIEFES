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
  .btn {
  border-radius: 12px;
  }

  
</style>

<script>
$(document).ready(function() {
// 		사용자용
	// 듣기버튼
	$("#btnListen").click(function() {
		
	});
	
	// 다운버튼
	$("#btnDown").click(function() {
		
	});
	
	// 모두듣기버튼
	$("#btnAllListen").click(function() {
		
	});
	
	$("#allCheckbox").click(function() {
		if($("#allCheckbox").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});
	
	// 사용자용 끝
	
// 		뮤지션용
		// 앨범수정 버튼
	$("#btnArtModify").click(function() {
		location.href="/indiefes/art/art_modify?art_number=${artVo.art_number}";
	});	
	
	// 앨범삭제 버튼
	$("#btnArtDelete").click(function() {
		
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
				<div class="col-md-4">
					<img alt="${artVo.art_title} 앨범 대표이미지" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-8">
					<p>
						<strong>${artVo.art_title}</strong><br>
						<strong>${team_name}</strong><br>
						<small>${artVo.art_pr}</small>
					</p>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12"  align="right">
<!-- 				실행버튼 -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${userVo.user_level == 3}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnListen">듣기</button>
						<!-- 담기로 구매한 사용자만 다운로드 가능함 -->
						<button type="button" class="btn btn-outline-secondary" id="btnDown">다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnCart">담기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllListen">전체듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllDown">전체다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllCart">전체담기</button>
<%-- 					</c:when> --%>
<%-- 					<c:when test="${userVo.user_level == 2}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnArtModify">앨범수정</button>
						<button type="button" class="btn btn-outline-secondary" id="btnArtDelete">앨범삭제</button>
						
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
								<th><input type="checkbox" id="allCheckbox" /></th>
								<th>번호</th>
								<th class="song_name">곡</th>
								<th>아티스트</th>
								<th>듣기</th>
								<th>가사</th>
								<th>다운</th>
								<th>담기</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${musicList}" var="musicInfoVo">
							<tr>
								<td><input type="checkbox" /></td>
								<td>${musicInfoVo.track_number}</td>
								<td class="song_name">${musicInfoVo.music_title}</td>
								<td>${teamName}</td>
								<td><span style="color:blue; size: 10px"><i class="fas fa-caret-square-right"></i></span></td>
								<td><span style="color:yellow; size: 10px"><i class="far fa-list-alt"></i></span></td>
								<td><span style="color:green; size: 10px"><i class="fas fa-file-download"></i></span></td>
								<td><span style="color:red; size: 10px"><i class="fas fa-cart-plus"></i></span></td>
							<tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>