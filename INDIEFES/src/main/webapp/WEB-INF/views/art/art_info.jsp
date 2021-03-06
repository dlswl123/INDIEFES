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
	#logo font {
	font-family: blox;
	font-size: 3.5rem;
	margin-left: 30px;
	}
	#logo {
	margin-bottom: 30px;
	color: #292929;	
 	text-shadow: 1px 1px 0px lightgrey;
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
		var id = "${musicList}";
		for (var i = 1; i <= id.length ; i++) {
			$("#"+i).get(0).click();
// 			var chk = $("#"+i);
// 			console.log(chk);
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
// 				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
				} else if (receivedData.trim() == "login_check"){
					alert("로그인한 유저만 사용가능합니다.");
				}
			} // "success"
		}); // $.ajax
	}); // $("#btnAllListen").click
	
// 	전체 담기
	$("#btnAllCart").click(function() {
		var check = "${musicList}";
		 $('#musicTable tr').each(function(index, item) {
			 var result = "";
			 result += 	index + ":" + item;
			 console.log(result);
		  }); // $('#musicTable tr').each
	}); // $("#btnAllCart").click
		
	
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
		location.href="/indiefes/player/playInsert?artnumber=${artVo.art_number}&team_number={artVo.team_number}";
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
// 				console.log(receivedData); // success
				if(receivedData != "") {
					$("#txaLyrics").val(receivedData);
					$("#btnModalLyric").attr("data-modify_lyric", receivedData);
				} else {
					$("#txaLyrics").val("가사를 입력해주세요.");
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
// 		console.log("txaLyrics:" + txaLyrics);
// 		console.log("lyrics:" + lyrics);
// 		console.log(music_number);
		var url = "";
		var type = "";
		if (txaLyrics == "") {
			url = "/indiefes/music/lyrics";
			type = "post";
		} else {
			url = "/indiefes/music/updateLyrics/" + music_number;
			type = "put";
		}
// 		console.log("type:" + type);
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
// 				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					$("#txaLyrics").val(lyrics);
				} else if (receivedData.trim() == "login_check") {
					alert("로그인한 사용자만 사용가능합니다.");
				}
// 				console.log("lyrics" + lyrics);
			} // "success"
		}); // $.ajax
		$("#modal-lyrics").modal("hide");
	}); // $("#btnModalLyric").click
	
	// 음악리스트- 다운버튼
	$("#tblMusicList").on("click", ".spMusicDown",function() {
		var music_number = $(this).attr("data-music_number");
		var url = "/indiefes/music/payCount";
		var data = {
				"music_number" : music_number
			};
		$.ajax({
			"type" : 'get',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "get"
			},
			"dataType" : "text",
			"data" : data,
			"success" : function(receivedData) {
// 				console.log(receivedData); // success
				
			} // "success"
		});
// 		console.log(music_number);
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
		
// 		console.log(art_number);
		var url = "/indiefes/art/likedChange";
		var data = {
				"art_number" : art_number
			};
		$.ajax({
			"type" : 'get',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "get"
			},
			"dataType" : "text",
			"data" : data,
			"success" : function(receivedData) {
// 				console.log(receivedData); // success
				var artLikedCountSpan = $("#artLikedCountSpan");
				var likeCount = parseInt(artLikedCountSpan.text	().trim());
				if (receivedData.trim() == "likeInsert") {
					$("#iconLiked").attr("class", "fas fa-heart");
					artLikedCountSpan.text(likeCount + 1);
				} else if (receivedData.trim() == "likeDelete") {
					$("#iconLiked").attr("class", "far fa-heart");
					artLikedCountSpan.text(likeCount - 1);
				} else if (receivedData.trim() == "login_check") {
					alert("로그인한 유저만 사용가능합니다.");
				}
			} // "success"
		});
	});
	// 앨범정보- 추천버튼
	$(".spGoodCount").click(function() {
		var art_number = $(this).attr("data-art_number");
// 		console.log(art_number);
		var url = "/indiefes/art/goodChange";
		var data = {
				"art_number" : art_number
			};
		$.ajax({
			"type" : 'get',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "get"
			},
			"dataType" : "text",
			"data" : data,
			"success" : function(receivedData) {
// 				console.log(receivedData); // success
				var artGoodCountSpan = $("#artGoodCountSpan");
				var goodCount = parseInt(artGoodCountSpan.text().trim());
				if (receivedData.trim() == "goodInsert") {
					$("#iconGood").attr("class", "fas fa-thumbs-up");
					artGoodCountSpan.text(goodCount + 1);
				} else if (receivedData.trim() == "goodDelete") {
					$("#iconGood").attr("class", "far fa-thumbs-up");
					artGoodCountSpan.text(goodCount - 1);
				} else if (receivedData.trim() == "login_check") {
					alert("로그인한 유저만 사용가능합니다.");
				}
			} // "success"
		}); // $.ajax
	}); // $(".spGoodCount").click
	// 사용자용 끝
	
// 		뮤지션(리더)용
		// 앨범수정 버튼
	$("#btnArtModify").click(function() {
		location.href="/indiefes/art/art_modify?art_number=${artVo.art_number }&team_number=${artVo.team_number}";
	});	
	
	// 앨범삭제 버튼
	$("#btnArtDelete").click(function() {
		var check = confirm("삭제후 다시 복구할수 없습니다.");
		if (check == true) {
			location.href="/indiefes/art/art_delete/${artVo.art_number}";
		} else if (check == false) {
// 			alert("취소하셨습니다.");
		}
		
	});
	
	// 앨범 등록 요청 버튼
	$("#btnArtAppro").click(function() {
		var check = confirm("등록 요청할 경우 수정 및 삭제할수 없습니다. 그래도 진행하시겠습니까?");
		if (check == true) {
			location.href="/indiefes/art/artUploadApproReq/${artVo.art_number}";
		} else if (check == false) {
// 			alert("취소하셨습니다.");
		}
	}); // $("#btnArtAppro").click
	// 뮤지션용 끝
	
// 		운영자용
	// 승인
	$("#btnAppro").click(function() {
		location.href = "/indiefes/art/artUploadAppro/${artVo.art_number}";
	});
	
	// 반려
	$("#btnReturn").click(function() {
		location.href = "/indiefes/art/artUploadReturn/${artVo.art_number}";
	});
	// 운영자용 끝
	
}); // $(document).ready
</script>
		<div class="col-md-10">
		<section id="logo" style="padding:20px;width:100%;">
			<div class="row">
				<font>InDiEFeS</font>
				<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
				앨범정보</span>
			</div>
		</section><hr>
			<div style="background-color: #292929;color: #00ff00;font-family:dgm;">
			<div class="col-md-11" style="margin:auto;">
			<div class="row">

				<div class="col-md-4">
					<br>
					<img alt="${artVo.art_title} 앨범 대표이미지" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-8">
					<div>
						<h1 style="color:#fafafa;">${artVo.art_title}</h1>
						<label>아티스트 :</label> ${teamName}
					</div>
						<label>앨범 소개 :</label><br>
						<textarea rows="10" cols="80" readonly="readonly"
						 style="background-color: transparent;	 resize: none; color: #fafafa;font-family:dgm;">${artVo.art_pr}</textarea>
				</div>
			</div>
			
			<div class="row" style="padding-top: 20px;">
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
					<c:when test="${userInfoVo.user_level eq 0 or userInfoVo.user_level eq 1 and artVo.upload_check eq 99}">
						<button type="button" class="btn btn-outline-secondary" id="btnReturn">복구</button>
					</c:when>
					<c:otherwise>
					<c:choose>
						<c:when test="${empty likedCount || likedCount == null}">
							<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="padding-right: 15px; text-align: center;"><i class="far fa-heart" style="font-size: 20px; color: red;" id="iconLiked"></i></span>
						</c:when> 
						<c:otherwise>
							<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="padding-right: 15px; text-align: center;"><i class="fas fa-heart" style="font-size: 20px; color: red;" id="iconLiked"></i></span>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty goodCount || goodCount == null}">
							<span class="spGoodCount icon"  data-art_number="${artVo.art_number}" style="padding-right: 15px; text-align: center;"><i class="far fa-thumbs-up" style="font-size: 20px; color: green;" id="iconGood"></i></span>
						</c:when>
						<c:otherwise>
							<span class="spGoodCount icon"  data-art_number="${artVo.art_number}" style="padding-right: 15px; text-align: center;"><i class="fas fa-thumbs-up" style="font-size: 20px; color: green;" id="iconGood"></i></span>
						</c:otherwise>
					</c:choose>
					
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnListen">듣기</button> -->
						<!-- 담기로 구매한 사용자만 다운로드 가능함 -->
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnDown">다운</button> -->
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnCart">담기</button> -->
						<button type="button" class="btn btn-outline-secondary" id="btnAllListen">전체듣기</button>
						<button type="button" class="btn btn-outline-secondary" id="btnAllDown">전체다운</button>
<!-- 						<button type="button" class="btn btn-outline-secondary" id="btnAllCart">전체담기</button> -->
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-12">
					<table class="table" style="color: #fafafa;" id="musicTable">
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
						<c:if test="${musicInfoVo.upload_check != 99}">
							<tr>
<!-- 								<td><input type="checkbox" /></td> -->
								<td>${i.count}</td>
								<td class="song_name" style="text-align: left;">${musicInfoVo.music_title}</td>
								<td>${teamName}</td>
								<td><a onclick="musicPlayer();" href="/indiefes/player/playInsert?music_number=${musicInfoVo.music_number}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" ><span class="spMusicPlay icon" style="color:blue;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-play"></i></span></a></td>
								<td><span class="spMusicLyrics icon" style="color:yellow;, size: 10px;" data-music_number="${musicInfoVo.music_number}" data-music_title="${musicInfoVo.music_title}"><i class="far fa-file-alt"></i></span></td>
<%-- 								<td><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td> --%>
<%-- 								<td><a id="${count = count+1}" href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" download="${musicInfoVo.music_title}"><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></a></td> --%>
<%-- 								<c:if test="${artVo.upload_check eq 1 }"> --%>
								<c:set var="flag" value="0" />
								<c:if test="${userVo != null}">
									<c:forEach items="${payList}" var="PayLogVo">
										<c:choose>
											<c:when test="${(musicInfoVo.music_number == PayLogVo.music_number) && PayLogVo.pay_ok eq 1}">
												<c:set var="flag" value="1" />
											</c:when>
											<c:when test="${(musicInfoVo.music_number == PayLogVo.music_number) && PayLogVo.pay_ok ne 1}">
												<c:set var="flag" value="2" />
											</c:when>
										</c:choose>
									</c:forEach>
								</c:if>
								<c:choose>
									<c:when test="${flag == 1}">
										<td><a id="${count = count+1}" href="/indiefes/player/Song?file_path=${musicInfoVo.file_path}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" download="${musicInfoVo.music_title}"><span class="spMusicDown icon" style="color:green;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></a></td>
										<td><span style="color:gray;, size: 10px;"><i class="fas fa-cart-plus"></i></span></td>
									</c:when>
									<c:when test="${artVo.upload_check ne 1 || flag == 2}">
										<td><span style="color:gray;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td>
										<td><span style="color:gray;, size: 10px;"><i class="fas fa-cart-plus"></i></span></td>
									</c:when>
									<c:otherwise>
										<td><span style="color:gray;, size: 10px;" data-music_number="${musicInfoVo.music_number}"><i class="fas fa-download"></i></span></td>
										<td><span class="spMusicCart icon" style="color:red;, size: 10px;" data-music_number="${musicInfoVo.music_number}" data-music_title="${musicInfoVo.music_title}"><i class="fas fa-cart-plus"></i></span></td>
									</c:otherwise>
								</c:choose>
<%-- 								</c:if> --%>
							<tr>
						</c:if>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
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
								<textarea  rows="10" cols="80" id="txaLyrics" class="form-control" name="lyrics"></textarea>
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
<!-- style="line-height:25px" -->
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>