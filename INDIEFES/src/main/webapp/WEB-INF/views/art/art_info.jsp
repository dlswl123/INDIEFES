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
 .icon {
  cursor: pointer;
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
	
	// 음악리스트- 듣기버튼
	$("#tblMusicList").on("click", ".spMusicPlay",function() {
		var music_number = $(this).attr("data-music_number");
		console.log(music_number);
		
	});
	// 음악리스트- 가사버튼
	$("#tblMusicList").on("click", ".spMusicLyrics", function() {
		$("#modal-a").trigger("click");
		var music_number = $(this).attr("data-music_number");
		$("#btnModalLyric").attr("data-music_number", music_number);
	});
	
	// 모달 수정 버튼
	$("#btnModalLyric").click(function() {
		var music_number = $(this).attr("data-music_number");
		var lyrics = $("#lyrics").val().trim();
		console.log(music_number);
		console.log(lyrics);
		var url = "/indiefes/music/lyrics";
		var data = {
			"music_number" : music_number,
			"lyrics" : lyrics
		};
		$.ajax({
			"type" : 'post',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "post"
			},
			"dataType" : "text",
			"data" : JSON.stringify(data),
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					$("#trackList").empty();
	 				getList();
				}
			}
		}); // $.ajax
		$("#modal-lyrics").modal("hide");
	});
	
	// 음악리스트- 다운버튼
	$("#tblMusicList").on("click", ".spMusicDown",function() {
		var music_number = $(this).attr("data-music_number");
		console.log(music_number);
		
	});
	// 음악리스트- 담기버튼
	$("#tblMusicList").on("click", ".spMusicCart",function() {
		var music_number = $(this).attr("data-music_number");
		console.log(music_number);
		
	});
	// 앨범정보- 좋아요버튼
	$(".spLikedCount").click(function() {
		var art_number = $(this).attr("data-art_number");
		console.log(art_number);
		
	});
	// 앨범정보- 추천버튼
	$(".spGoodCount").click(function() {
		var art_number = $(this).attr("data-art_number");
		console.log(art_number);
		
	});
	
	// 사용자용 끝
	
// 		뮤지션(리더)용
		// 앨범수정 버튼
	$("#btnArtModify").click(function() {
		location.href="/indiefes/art/art_modify?art_number=${artVo.art_number }&team_number=${artVo.team_number}";
	});	
	
	// 앨범삭제 버튼
	$("#btnArtDelete").click(function() {
		location.href="/indiefes/art/art_delete/${artVo.art_number}";
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
					<img alt="${artVo.art_title} 앨범 대표이미지" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-8">
					<p>
						<strong>${artVo.art_title}</strong><br>
						<strong>${teamName}</strong><br>
						<small>${artVo.art_pr}</small>
					</p>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12"  align="right">
<!-- 				실행버튼 -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${userInfoVo.user_level eq 0 or userInfoVo.user_level eq 1}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnAppro">승인</button>
						<button type="button" class="btn btn-outline-secondary" id="btnReturn">반려</button>
<%-- 					</c:when> --%>
<%-- 					<c:when test="${userInfoVo.user_level eq 2 and artVo.user_id eq userInfoVo.user_id}"> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnArtModify">앨범수정</button>
						<button type="button" class="btn btn-outline-secondary" id="btnArtDelete">앨범삭제</button>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
						<button type="button" class="btn btn-outline-secondary" id="btnListen">듣기</button>
						<!-- 담기로 구매한 사용자만 다운로드 가능함 -->
						<button type="button" class="btn btn-outline-secondary" id="btnDown">다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnCart">담기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllListen">전체듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllDown">전체다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllCart">전체담기</button>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
				</div>
			</div>
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-12" align="right"> -->
<%-- 				<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="padding-right: 30px;"><i class="far fa-heart fa-2x"></i></span> --%>
<!-- 					<i class="fas fa-heart"></i> -->
<%-- 				<span class="spGoodCount icon"  data-art_number="${artVo.art_number}" style="padding-right: 30px;"><i class="far fa-thumbs-up fa-2x"	></i></span> --%>
<!-- 					<i class="fas fa-thumbs-up"></i> -->
				
<!-- 				</div> -->
<!-- 			</div> -->
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
						<tbody id="tblMusicList">
						<c:forEach items="${musicList}" var="musicInfoVo">
							<tr>
<!-- 								<td><input type="checkbox" /></td> -->
								<td>${musicInfoVo.track_number}</td>
								<td class="song_name">${musicInfoVo.music_title}</td>
								<td>${teamName}</td>
								<td><span class="spMusicPlay icon" style="color:blue;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-play"></i></span></td>
								<td><span class="spMusicLyrics icon" style="color:yellow;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="far fa-file-alt"></i></span></td>
<%-- 								<td><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td> --%>
								<td><a href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" download="${musicInfoVo.music_title}"><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></a></td>
								<td><span class="spMusicCart icon" style="color:red;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-cart-plus"></i></span></td>
							<tr>
<%-- 							<a href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}"></a> --%>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
<!-- 			Modal -->
			<div class="row" >
				<div class="col-md-12">
					<a id="modal-a" href="#modal-lyrics" role="button" class="btn" data-toggle="modal"></a>
					
					<div class="modal fade" id="modal-lyrics" role="dialog" >
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="myModalLabel">
										${artVo.art_title }가사
									</h5> 
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">×</span>
									</button>
								</div>
								<div class="modal-body">
								<textarea  rows="10" cols="80" id="lyrics" class="form-control" name="lyrics">
								</textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" id="btnModalLyric"
										data-music_number="" data-modify_lyric="">
										수정
									</button> 
									<button type="button" class="btn btn-secondary" data-dismiss="modal">
										닫기
									</button>
								</div>
							</div>
							
						</div>
						
					</div>
					
				</div>
			</div>
<!-- 			 Modal End -->
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>