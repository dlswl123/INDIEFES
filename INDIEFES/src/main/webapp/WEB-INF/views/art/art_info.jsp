<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>  
<style>
	th {
    height: 100px;
    text-align: center;
	}
	td {
	text-align: center;
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
		location.href="/indiefes/player/playInsertAll/${artVo.art_number}";
	});
	// 전체 다운
	$("#btnAllDown").click(function() {
		var id = 3;
		for (var i = 1; i <= id ; i++) {
			$("#"+i).get(0).click();
		}
// 		location.href="";
	});
	
	// 모두듣기버튼
	$("#btnAllListen").click(function() {
		var art_number = "${artVo.art_number}";
		var url = "/indiefes/player/playInsertAll/" + art_number;
		$.ajax({
			"type" : 'post',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "post"
			},
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
				} // if
			} // "success"
		}); // $.ajax
	}); // $("#btnAllListen").click
	
// 	// 체크박스 전체 선택, 전체 선택 해제
// 	$("#allCheckbox").click(function() {
// 		if($("#allCheckbox").prop("checked")) {
// 			$("input[type=checkbox]").prop("checked",true);
// 		} else {
// 			$("input[type=checkbox]").prop("checked",false);
// 		}
// 	});
	
	// 음악리스트- 듣기버튼
	$("#tblMusicList").on("click", ".spMusicPlay",function() {
		
	});
	
	// 음악리스트- 가사버튼
	$("#tblMusicList").on("click", ".spMusicLyrics", function() {
		$("#modal-a").trigger("click");
		var music_number = $(this).attr("data-music_number");
		var music_title = $(this).attr("data-music_title");
		$("#myModalLabel").text(music_title + "가사");
		$("#btnModalLyric").attr("data-music_number", music_number);
		var url = "/indiefes/music/getLyrics/" + music_number
		$.ajax({
			"type" : 'get',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/text",
				"X-HTTP-Method-Overried" : "get"
			},
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if(receivedData != "") {
					$("#txaLyrics").val(receivedData);
					$("#btnModalLyric").attr("data-modify_lyric", receivedData);
				} else {
					$("#txaLyrics").val("");
					$("#btnModalLyric").attr("data-modify_lyric", "");
				}
			} // "success"
		}); // $.ajax({
	}); // $("#tblMusicList").on
	
	// 모달 수정 버튼
	$("#btnModalLyric").click(function() {
		var music_number = $(this).attr("data-music_number");
		var txaLyrics = $(this).attr("data-modify_lyric");
		var lyrics = $("#txaLyrics").val();
		console.log("txaLyrics:" + txaLyrics);
		console.log("lyrics:" + lyrics);
		console.log(music_number);
		var url = "";
		var type = "";
		if (txaLyrics == "") {
			url = "/indiefes/music/lyrics";
			type = "post";
		} else {
			url = "/indiefes/music/updateLyrics/" + music_number;
			type = "put";
		}
		console.log("type:" + type);
		var data = {
			"music_number" : music_number,
			"lyrics" : lyrics
		};
		$.ajax({
			"type" : type,
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : type
			},
			"dataType" : "text",
			"data" : JSON.stringify(data),
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					$("#txaLyrics").val(lyrics);
				} // if
				console.log("lyrics" + lyrics);
			} // "success"
		}); // $.ajax
		$("#modal-lyrics").modal("hide");
	}); // $("#btnModalLyric").click
	
	// 음악리스트- 다운버튼
	$("#tblMusicList").on("click", ".spMusicDown",function() {
		var music_number = $(this).attr("data-music_number");
		console.log(music_number);
		
	});
	// 음악리스트- 담기버튼
	$("#tblMusicList").on("click", ".spMusicCart",function() {
		var music_number = $(this).attr("data-music_number");
		var music_title = $(this).attr("data-music_title");
		location.href="/indiefes/art/cart?art_number=${artVo.art_number }&team_number=${artVo.team_number}&music_number="+music_number+"&music_title="+music_title;
		alert(music_title+" 카트에 담기");
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
	
	// 앨범 등록 요청 버튼
	$("#btnArtAppro").click(function() {
		var check = confirm("등록 요청할 경우 수정 및 삭제할수 없습니다. 그래도 진행하시겠습니까?");
		if (check == true) {
			location.href="/indiefes/art/artUploadApproReq/${artVo.art_number}";
		} else if (check == false) {
// 			alert("취소하셨습니다.");
		}
	});
	
	// 뮤지션용 끝
	
// 		운영자용
	// 승인
	$("#btnAppro").click(function() {
// 		location.href="/indiefes/art/music_input?art_number=${artVo.art_number }&team_number=${artVo.team_number}&track_number=${musicInfoVo.track_number}";
		location.href = "/indiefes/art/artUploadAppro/${artVo.art_number}";
	});
	
	// 반려
	$("#btnReturn").click(function() {
// 		var track_number = $("#track_number").length;
		location.href = "/indiefes/art/artUploadReturn/${artVo.art_number}";
		console.log(track_number);
	});
	// 운영자용 끝
	
	// 뮤직 플레이어
	function musicPlayer() {
		window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
	}
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
						<strong><label>곡 제목 :</label> ${artVo.art_title}</strong><br>
						<label>아티스트 :</label> ${teamName}<br>
					</p>
						<small><label>앨범 소개 :</label></small><br>
						<textarea rows="10" cols="80" readonly="readonly" style="background-color: transparent; border:0;">${artVo.art_pr}</textarea>
								
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12"  align="right">
<!-- 				실행버튼 -->
				<c:choose>
					<c:when test="${userInfoVo.user_level eq 0 or userInfoVo.user_level eq 1 and artVo.upload_check eq 2}">
						<button type="button" class="btn btn-outline-secondary" id="btnAppro">승인</button>
						<button type="button" class="btn btn-outline-secondary" id="btnReturn">반려</button>
					</c:when>
					<c:when test="${userInfoVo.user_level eq 2 and artVo.user_id eq userInfoVo.user_id and artVo.upload_check eq 0}">
						<button type="button" class="btn btn-outline-secondary" id="btnArtModify">앨범수정</button>
						<button type="button" class="btn btn-outline-secondary" id="btnArtDelete">앨범삭제</button>
						<button type="button" class="btn btn-outline-secondary" id="btnArtAppro">앨범등록</button>
					</c:when>
					<c:otherwise>
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnListen">듣기</button> -->
						<!-- 담기로 구매한 사용자만 다운로드 가능함 -->
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnDown">다운</button> -->
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnCart">담기</button> -->
						<button type="button" class="btn btn-outline-secondary" id="btnAllListen">전체듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllDown">전체다운</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllCart">전체담기</button>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" align="right">
				<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="padding-right: 30px;"><i class="far fa-heart fa-2x"></i></span>
<!-- 					<i class="fas fa-heart"></i> -->
				<span class="spGoodCount icon"  data-art_number="${artVo.art_number}" style="padding-right: 30px;"><i class="far fa-thumbs-up fa-2x"	></i></span>
<!-- 					<i class="fas fa-thumbs-up"></i> -->
				
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
<!-- 								<th><input type="checkbox" id="allCheckbox" /></th> -->
								<th>트랙</th>
								<th class="song_name">곡제목</th>
								<th>아티스트</th>
								<th>듣기</th>
								<th>가사</th>
								<th>다운</th>
								<th>담기</th>
							</tr>
						</thead>
						<tbody id="tblMusicList">
						<c:forEach items="${musicList}" var="musicInfoVo" varStatus="i">
						<c:if test="${musicInfoVo.upload_check != 99 }">
							
							<tr>
<!-- 								<td><input type="checkbox" /></td> -->
								<td>${i.count}</td>
								<td class="song_name" style="text-align: left;">${musicInfoVo.music_title}</td>
								<td>${teamName}</td>
								<td><a onclick="musicPlayer();" href="/indiefes/player/playInsert?music_number=${musicInfoVo.music_number}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" ><span class="spMusicPlay icon" style="color:blue;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-play"></i></span></a></td>
								<td><span class="spMusicLyrics icon" style="color:yellow;, size: 10px;" data-music_number="${musicInfoVo.music_number}" data-music_title="${musicInfoVo.music_title}"><i class="far fa-file-alt"></i></span></td>
<%-- 								<td><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td> --%>
								<td><a id="${count = count+1}" href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" download="${musicInfoVo.music_title}"><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></a></td>
<%-- 								<c:choose> --%>
<%-- 									<c:when test=""> --%>
<%-- 										<td><a href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" download="${musicInfoVo.music_title}"><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></a></td> --%>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
	<%-- 								<td><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td> --%>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
								<td><span class="spMusicCart icon" style="color:red;, size: 10px;" data-music_number="${musicInfoVo.music_number}" data-music_title="${musicInfoVo.music_title}"><i class="fas fa-cart-plus"></i></span></td>
							<tr>
<%-- 							<a href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}"></a> --%>
						</c:if>
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
										
									</h5> 
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">×</span>
									</button>
								</div>
								<div class="modal-body">
								<textarea  rows="10" cols="80" id="txaLyrics" class="form-control" name="lyrics">
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