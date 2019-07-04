<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %> 
<script>
$(document).ready(function() {
	// 노래파일업로드버튼
	$("#btnMusicFile").click(function(e) {
		$("#inputMusicFile").trigger("click");
	});
	$("#inputMusicFile").change(function(e) {
		$("#spanMusicFile").text(this.files[0].name);
		var file = $("input[name='file_path']");
		console.log(file);
	});
	// 음악 추가 버튼
	$("#btnMusicAdd").click(function() {
		var tNum = $("#trackNumber").val();
		var track_number = Number(tNum) + 1;
		$("#trackNumber").attr("value", track_number);
		$("#music_input").submit();
	}); //$("#btnMusicAdd").click
	// 음악추가버튼 끝
	
	// 음악추가 취소 버튼
	$("#btnMusicCancel").click(function() {
// 		$("#spanMusicFile").text("");
// 		$("#songName").val("");
// 		$("#trackNumber").val("");
	});
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
		<form  id="music_input"  method="post" enctype="multipart/form-data">
		<input type="hidden" name="track_number" value="${track_number}"  id="trackNumber" >
		<input type="hidden" name="art_number" value="${param.art_number}"  id="artNumber" >
		<input type="hidden" name="team_number" value="${param.team_number}"  id="teamNumber" >
			<div class="col-md-9 form-group">
				<div class="col-md-12  form-group row">
					<div class="col-xs-7">
						<label for="songName">노래제목</label>
						<input type="text" id="songName" name="music_title" class="form-control">
					</div>
					<div  class="col-xs-5">
					<label>&nbsp; &nbsp;</label>
			        	<input type="file" name="fileSong" id="inputMusicFile" accept=".mp3, .flac, .wav, .aac" style="display:none;">
						<input type="button" value="파일찾기" id="btnMusicFile" class="btn btn-sm btn-success">
						<span id="spanMusicFile" style="color: white;"></span>
						<input type="button" class="btn btn-sm btn-primary" id="btnMusicAdd" value="추가"/>
						<input type="button" class="btn btn-sm btn-danger" id="btnMusicCancel"value="취소"/>
					</div>
				</div>
			</div>
		    <div class="col-md-3 form-group" align="right">
			</div>
		   </form>
<%@ include file="../include/footer.jsp" %>