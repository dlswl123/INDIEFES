<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
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
$.fn.setPreview = function(opt){
    "use strict"
    var defaultOpt = {
        inputFile: $(this),
        img: null,
        w: 282,
        h: 282
    };
    $.extend(defaultOpt, opt);
 
    var previewImage = function(){
        if (!defaultOpt.inputFile || !defaultOpt.img) return;
 
        var inputFile = defaultOpt.inputFile.get(0);
        var img       = defaultOpt.img.get(0);
 
        // FileReader
        if (window.FileReader) {
            // image 파일만
            if (!inputFile.files[0].type.match(/image\//)) return;
 
            // preview
            try {
                var reader = new FileReader();
                reader.onload = function(e){
                    img.src = e.target.result;
                    img.style.width  = defaultOpt.w+'px';
                    img.style.height = defaultOpt.h+'px';
                    img.style.display = '';
                }
                reader.readAsDataURL(inputFile.files[0]);
            } catch (e) {
                // exception...
            }
        // img.filters (MSIE)
        } else if (img.filters) {
            inputFile.select();
            inputFile.blur();
            var imgSrc = document.selection.createRange().text;
 
            img.style.width  = defaultOpt.w+'px';
            img.style.height = defaultOpt.h+'px';
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";           
            img.style.display = '';
        // no support
        } else {
            // Safari5, ...
        }
    };
 
    // onchange
    $(this).change(function(){
        previewImage();
    });
};

$(document).ready(function() {
	var opt = {
	        img: $('#img_preview'),
	        w: 282,
	        h: 282
	    };
	 	
	    $('#art_cover').setPreview(opt);
	    
	getList();
	
	// 노래파일업로드버튼
	$("#btnMusicFile").click(function(e) {
		$("#inputMusicFile").trigger("click");
	});
	$("#inputMusicFile").change(function(e) {
		$("#spanMusicFile").text(this.files[0].name);
		
	});
	
	// 커버이미지 파일업로드버튼
// 	$("#btnImageFile").click(function(e) {
// 		$("#art_cover").trigger("click");
// 	});
// 	$("#art_cover").change(function(e) {
// 		console.log(e);
// 		var imageId="#art_cover";
// 		$("#spanImageFile").text(this.files[0].name);
// 	    $("#img_cover").css("display","none");
// 		$("#img_preview").css("display","");
// 		imgPreview();
// 	});
	
	// 앨범등록 버튼
	$("#btnArtAdd").click(function() {
		var file = $("#art_cover").val().split("\\");
		var art_cover = file[file.length-1]
		$("input[name=art_cover]").val(art_cover);
		var art_genre = $("#art_genre").val();
		$("input[name=art_genre]").val(art_genre);
		console.log(art_cover);
		console.log(file);
		// 폼을 전송
		$("#art_info_input").submit();
	});
	
	// 등록취소 버튼
	$("#btnCancel").click(function() {
		location.href="/indiefes/art/art_info?art_number=${artVo.art_number }&team_number=${artVo.team_number}";
	});
	
	// 음악 추가 버튼
	$("#btnMusicAdd").click(function() {
		var art_number = "${artVo.art_number}";
		var team_number = "${artVo.team_number}";
		var music_title = $("#songName").val();
		var tNum = $("#trackNumber").val();
		var track_number = Number(tNum) + 1;
		var file_path = $("#spanMusicFile").text();
		var data = {
				"art_number" : art_number,
				"team_number" : team_number,
				"music_title" : music_title,
				"track_number" : track_number,
				"file_path" : file_path
		};
		var url = "/indiefes/music/insert";
		$.ajax({
			"type" : "post",
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "post"
			},
			"data" : JSON.stringify(data),
			"success" : function(receivedData) {
				getList();
// 				console.log(receivedData);
			} // $.ajax
		});
			$("#trackNumber").attr("value", track_number);
			console.log("tNum:" + tNum);
	}); //$("#btnMusicAdd").click
	// 음악추가버튼 끝
	
	// 음악추가 취소 버튼
	$("#btnMusicCancel").click(function() {
		$("#spanMusicFile").text("");
		$("#songName").val("");
		$("#trackNumber").val("");
	});
	
	// 수정 버튼
	$("#trackList").on("click", ".btnMusicMod",function() {
		var music_number = $(this).attr("data-music_number");
		var art_number = $(this).attr("data-art_number");
		var td = $(this).parent().parent().children();
		var tNumStr = td.eq(1).text();
		td.eq(1).html("<input type='text' class='form-control' id='musicTitle' value='" + tNumStr + "'>");
		td.eq(4).html("<input type='button' class='btn btn-sm btn-primary' id='btnUpdate' value='확인'>");
		
		$("#btnUpdate").click(function() {
			var music_title = $("#musicTitle").val();
	 		var data = {
	 			"music_title" : music_title,
	 			"art_number" : art_number,
	 			"music_number" : music_number
	 		};
	 		
	 		var url = "/indiefes/music/update/" + music_number;
	 		$.ajax({
				"type" : "put",
				"url" : url,
				"headers" : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "put"
				},
				"dataType" : "text",
				"data" : JSON.stringify(data),
				"success" : function(receivedData) {
					$("#trackList").empty();
	 				getList();
					td.eq(2).html(music_title);
	 				td.eq(5).html("<Button type='button' class='btn btn-sm btn-warning btnMusicMod' id='btnMusicUpdate' data-track_number='" + this.track_number + "data-'>수정</Button>");
				} // "success"
			}); // $.ajax
	 		
		}); // $("#btnUpdate").click

	}); //$("#trackList").on("click", ".btnMusicMod",function()
	// 수정버튼 끝
	
	// 뮤직 삭제 버튼
	$("#trackList").on("click", "#btnMusicDelete", function() {
// 		console.log("삭제버튼 클릭됨");
		var art_number = $(this).attr("data-art_number");
		var music_number = $(this).attr("data-music_number");
		var team_number = $(this).attr("data-team_number");
// 		console.log(rno);
		var url = "/indiefes/music/delete/" + art_number + "/" + music_number + "/" + team_number;
		$.ajax({
			"type" : 'delete',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "delete"
			},
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if (receivedData.trim() == "success") {
					$("#trackList").empty();
	 				getList();
				}
			}
		}); // $.ajax
	});
	
	// 가사 등록 버튼
	$("#trackList").on("click", ".btnMusicLyric", function() {
		$("#modal-a").trigger("click");
		alert("가사를 이미 등록했을경우 이전에 등록된 가사가 삭제될수 있습니다.");
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
	
	
	// 뮤지션용 끝
	
	// 음악 트랙리스트 가져오기
	function getList() {
		var url = "/indiefes/music/list?art_number=${param.art_number}&team_number=${param.team_number}";
		$.getJSON(url, function(receivedData) {
			console.log(receivedData);
			var strHtml = "";
			var team_name = "${team_name}";
			$(receivedData).each(function(i) {
				strHtml += "<tr>"
			    	  + 	 "<td>" + this.track_number + "</td>"
			    	  + 	 "<td class='song_name'>" + this.music_title + "</td>"
			       	  + 	 "<td>" + this.file_path + "</td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-success btnMusicLyric' id='btnLyricAdd'  data-music_number='" + this.music_number + "' >등록</Button></td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-warning btnMusicMod' id='btnMusicUpdate' data-music_number='" + this.music_number + "' data-art_number='" + this.art_number + "'>수정</Button></td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-danger btnMusicDel'  id='btnMusicDelete' data-music_number='" + this.music_number + "' data-art_number='" + this.art_number + "'>삭제</Button></td>"
					  +  "</tr>";
			});
			$("#trackList").html(strHtml);
		}); // $.getJSON
	} // getReplyList()
});
</script>
	
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div class="row">
					<h1>앨범 수정</h1>
			</div>
<!-- 			앨범 수정폼 -->
			<form role="form" method="post" id="art_info_input" enctype="multipart/form-data">
			<input type="hidden" name="art_genre" value="">
			<input type="hidden" name="art_cover" value="">
			<input type="hidden" name="art_number" value="${artVo.art_number }">
			<input type="hidden" name="team_number" value="${artVo.art_number }">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
								<h3 style="color: #ffffff;">앨범 이미지</h3>
								<input type="file" id="art_cover" accept=".jpg, .jpeg, .png" name="file"/>
								<br>
								<img id="img_preview" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" width="282" height="282" class="rounded" />	
						</div>
					</div>
					<div class="col-md-8">
						<div class="form-group">
								<label for="art_title" style="color: #ffffff;">앨범제목</label>
								<input type="text" class="form-control" id="art_title" name="art_title" value="${artVo.art_title}" />
								
						</div>
<!-- 						장르선택  -->
						<div class="form-group">
							<label for="art_genre" style="color: #ffffff;">장르</label>
							<select id="art_genre">
								<option value="발라드"<c:if test="${artVo.art_genre == '발라드'}">
								selected
								</c:if>>발라드</option>
								<option value="댄스"<c:if test="${artVo.art_genre == '댄스'}">
								selected
								</c:if>>댄스</option>
								<option value="랩/힙합"<c:if test="${artVo.art_genre == '랩/힙합'}">
								selected
								</c:if>>랩/힙합</option>
								<option value="R&B/Soul"<c:if test="${artVo.art_genre == 'R&B/Soul'}">
								selected
								</c:if>>R&B/Soul</option>
								<option value="재즈"<c:if test="${artVo.art_genre == '재즈'}">
								selected
								</c:if>>재즈</option>
								<option value="록/메탈"<c:if test="${artVo.art_genre == '록/메탈'}">
								selected
								</c:if>>록/메탈</option>
								<option value="포크/블루스"<c:if test="${artVo.art_genre == '포크/블루스'}">
								selected
								</c:if>>포크/블루스</option>
								<option value="기타"<c:if test="${artVo.art_genre == '기타'}">
								selected
								</c:if>>기타</option>
							</select>
						</div>
<!-- 						장르선택 END -->

						<div class="form-group" >
							<label for="art_pr" style="color: #ffffff;">앨범 소개</label>
							<textarea rows="10" cols="80" id="art_pr"
								class="form-control" name="art_pr">${artVo.art_pr }</textarea>
						</div>
						<div class="form-group" >
						</div>
					</div>
				</div>
			</form>
<!-- 			앨범수정폼 END -->
			<div class="row">
				
				<!-- 음악추가폼 -->
				<div class="col-md-12">
					<form name="fileForm" action="art/musicUpload" method="post" enctype="multipart/form-data" class="form-inline">
					<input type="hidden" name="track_number" value="${track_number}"  id="trackNumber" >
						<div class="col-md-9 form-group">
							<div class="col-md-12  form-group row">
								<div class="col-xs-7">
									<label for="songName">노래제목</label>
									<input type="text" id="songName" name="music_title" class="form-control">
								</div>
								<div  class="col-xs-5">
								<label>&nbsp; &nbsp;</label>
						        	<input type="file" name="file_path" id="inputMusicFile" accept=".mp3, .flac, .wav, .aac" style="display:none;">
									<input type="button" value="파일찾기" id="btnMusicFile" class="btn btn-sm btn-success">
									<span id="spanMusicFile"></span>
									<button type="button" class="btn btn-sm btn-primary" id="btnMusicAdd">추가</button>
									<button type="button" class="btn btn-sm btn-danger" id="btnMusicCancel">취소</button>
								</div>
							</div>
						</div>
					    <div class="col-md-3 form-group" align="right">
							<button type="button" class="btn btn-outline-success" id="btnArtAdd">수정완료</button>
							<button type="button" class="btn btn-outline-danger" id="btnCancel">등록취소</button>
						</div>
				    </form>
				</div>
			    <!-- 음악추가폼 끝 -->
			</div>
			
			<!-- Modal -->
	<div class="row" >
		<div class="col-md-12">
			<a id="modal-a" href="#modal-lyrics" role="button" class="btn" data-toggle="modal"></a>
			
			<div class="modal fade" id="modal-lyrics" role="dialog" >
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">
								가사 입력
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
						<textarea  rows="10" cols="80" id="lyrics" class="form-control" name="lyrics">
							<c:choose>
								<c:when test="${musicLysicsVo.lysics == null}">가사를 입력해 주세요.</c:when>
								<c:otherwise> ${musicLysicsVo.lysics} </c:otherwise>
							</c:choose>
						</textarea>
						</div>
						<div class="modal-footer">
							 
							<button type="button" class="btn btn-primary" id="btnModalLyric"
								data-music_number="" data-add-lyric="">
								등록
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
	<!-- // Modal -->
			
			
			
			<div class="row">
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th class="song_name">곡</th>
								<th>노래파일</th>
								<th>가사</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="trackList">
						<!-- JSON으로 받을 음악 트랙목록 -->
						</tbody>
					</table>
				</div>
			</div>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>