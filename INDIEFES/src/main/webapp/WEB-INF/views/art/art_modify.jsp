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
	
	getList();
	// 파일업로드버튼
	$("#btnFile").click(function(e) {
		$("#inputFile").trigger("click");
	});
	$("#inputFile").change(function(e) {
		$("#spanFile").text(this.files[0].name);
		
	});
	
	// 앨범등록 버튼
	$("#btnArtAdd").click(function() {
		location.href="/indiefes/art/art_info?art_number=${param.art_number}";
	});
	
	// 등록취소 버튼
	$("#btnCancel").click(function() {
		location.href="/indiefes/art/art_list";
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
	
	// 음악 트랙리스트 가져오기
	function getList() {
		var url = "/indiefes/music/list/${param.art_number}";
// 		var url = "/indiefes/music/list/1";
		$.getJSON(url, function(receivedData) {
			console.log(receivedData);
			var strHtml = "";
			$(receivedData).each(function(i) {
				strHtml += "<tr>"
			    	  + 	 "<td><input type='checkbox' /></td>"
			    	  + 	 "<td>" + this.track_number + "</td>"
			    	  + 	 "<td  class='song_name'>" + this.music_title + "</td>"
			       	  + 	 "<td>${team_name}</td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-success' >등록</Button></td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-warning' data-track_number='" + this.track_number + "'>수정</Button></td>"
			      	  + 	 "<td><Button type='button' class='btn btn-sm btn-danger' >삭제</Button></td>"
					  +  "</tr>";
			});
			$("#trackList").html(strHtml);
		}); // $.getJSON
	} // getReplyList()
});
</script>
	
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div class="row">
					<h1>앨범 정보</h1>
			</div>
			<div class="row">
				<div class="col-md-3">
					<!-- 앨범 표지-->
					<img alt="Bootstrap Image Preview" src="https://www.layoutit.com/img/sports-q-c-140-140-3.jpg" width="282" height="282" class="rounded" />
				</div>
				<div class="col-md-9">
					<p>
						<strong>${artVo.art_title}</strong><br>
						<strong>${team_name}</strong><br>
						<small>${artVo.art_pr}</small>
					</p>
				</div>
			</div>
			
			<div class="row">
				
				<!-- 음악추가폼 -->
				<div class="col-md-9">
					<form name="fileForm" action="art/musicUpload" method="post" enctype="multipart/form-data">
						<div>
							<label>노래제목</label>
							<input type="text" id="songName">
				        	<input type="file" name="file_path" id="inputFile" style="display:none;">
							<input type="button" value="파일찾기" id="btnFile" class="btn btn-sm btn-success">
							<span id="spanFile"></span>
							<button type="button" class="btn btn-sm btn-primary" id="btnMusicAdd">추가</button>
							<button type="button" class="btn btn-sm btn-danger" id="btnMusicCancel">취소</button>
						</div>
				    </form>
				</div>
			    <!-- 음악추가폼 끝 -->
			    <div class="col-md-3" align="right">
					<button type="button" class="btn btn-outline-success" id="btnArtAdd">수정완료</button>
					<button type="button" class="btn btn-outline-danger" id="btnCancel">등록취소</button>
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