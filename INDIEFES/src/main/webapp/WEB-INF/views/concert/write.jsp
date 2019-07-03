<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	// set input today to show_date
	var today = new Date().toISOString().slice(0,16);
	$("input[id=show_date]").val(today);
	$("input[name=concert_date]").val(today.replace("T", " "));
	
	$("input[id=show_date]").on("change", function() {
		var show_date = $("input[id=show_date]").val();
		$("input[id=show_date]").val(show_date);
		
		$("input[name=concert_date]").val(show_date.replace("T", " "));
		console.log($("input[name=concert_date]").val());
		var nowDate = new Date().toISOString().slice(0,10);
		var concertDate = replaceAll(nowDate, "-", "/");
		formData.append("concertDate", concertDate);
	});
	
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	
	// 홍보파일업로드버튼(인포 목록용)
	$("#btnInfoFile").click(function(e) {
		$("#info_file").trigger("click");
	});
	$("#info_file").change(function(e) {
		$("#spanInfoFile").text(this.files[0].name);
		
		formData.append("infoFile", this.files[0]);
	});
	
	var files; // 파일 받는용
	var formData = new FormData();
	
	// 포스터 파일 업로드 버튼(내부 상세정보용)
	$("#btnFiles").click(function() {
		$("#poster_file").trigger("click");
	});
	$("#poster_file").change(function() {
		files = $("#poster_file").prop("files");
        
		uploadPosterFiles(files);
	});
	
	// 포스터 파일 드래그앤드롭 영역(내부 상세정보용)
	$("#filePosterList").on("dragenter dragover", function(e) {
		e.preventDefault ? e.preventDefault() : (e.returnValue = false);
	});
	$("#filePosterList").on("drop", function(e) {
		e.preventDefault ? e.preventDefault() : (e.returnValue = false);
		
		files = e.originalEvent.dataTransfer.files;
		// -> 드롭 영역에 드롭한 파일
		// enctype="multipart/form-data"
		// enctype 의 기본값 : application/x-www-form-urlencoded

		uploadPosterFiles(files);
	});
	
	
	function uploadPosterFiles(files) {
		console.log("files : " + files);
		
		// 파일이 아무것도 없을경우 초기화
		if ($("#filePosterList").text().trim() == "첨부할 파일을 끌어다 놓으세요") {
        	$("#filePosterList").text("");
        }
		
       	for (var i = 0; i < files.length; i++) {
   			$("#filePosterList").append("<div>" + files[i].name + "</div>");
   			console.log("fileName : " + files[i].name);

   			formData.append("posterFile[" + i + "]", files[i]); // <input type="text" name="files">
		}
		
	} // End of uploadPosterFiles();
	
	$("#btnCancel").click(function() {
		location.href = "/indiefes/concert/info";
	});
	
	$("#btnConfirm").click(function() {
		
// 		var formData = new FormData();
// 		formData.append("file_path", files); // <input type="text" name="files">
		
		var url = "/indiefes/concert/uploadAjax";
		
		$.ajax({
			"url" : url,
			"data" : formData,
			"processData" : false, // ?뒤의 데이터 보내지 않게
			"contentType" : false, // enctype="multipart/form-data"
			"type" : "post",
			"success" : function(receivedData) {
				if(receivedData != null) {
					console.log("receivedData : " + receivedData);
					
					var infoFilePath = "<input type='hidden' name='info_file_path' value='" + receivedData.info_file_path + "'>"; 
					$("#concertWriteForm").append(infoFilePath);
					
					var filePath = "<input type='hidden' name='file_path' value='" + receivedData.file_path + "'>"; 
		   			$("#concertWriteForm").append(filePath);
		   			
		   			console.log("infoFilePath : " + infoFilePath);
		   			console.log("filePath : " + filePath);

					$("#concertWriteForm").submit();
				}
			}
		}); // $.ajax({});
		
	}); // $("#btnConfirm").click(function(){});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 정보 등록</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			<!-- // move to new concert info write form -->
			<form role="form" action="/indiefes/concert/write" method="post" id="concertWriteForm" enctype="multipart/form-data">
				<div class="form-group">
					<!-- Session으로 유저 정보 받아오기 -->
<!-- 					<input type="hidden" name="user_id" value="indie1" /> -->
			
					<label id="subject">공연 제목</label>
					<input type="text" class="form-control" name="subject" id="subject" placeholder="공연명을 기입해주세요" required/><br>
					
					<label id="show_date">공연 일자</label>
					<input type="datetime-local" class="form-control" id="show_date" />
					<input type="hidden" name="concert_date" id="concert_date" /><br>
					
					<label id="summary">공연 요약 내용</label>
					<input type="text" class="form-control" name="summary" id="summary" placeholder="목록에 보여질 내용을 한줄로 요약해서 기입해주세요" /><br>
					
					<label id="info_file_path">목록에 보일 홍보 요약 포스터(크기는 최대 1200x350)</label>
					<input type="file" class="form-control" id="info_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" />
					<input type="button" value="파일찾기" id="btnInfoFile" class="btn btn-sm btn-success" />
					<span id="spanInfoFile"></span><br><br>
					
					<label id="file_path">홍보 포스터</label>
					<input type="file" class="form-control" id="poster_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" multiple />
					<input type="button" value="파일찾기" id="btnFiles" class="btn btn-sm btn-success" />
					<!-- file drag&drop area and show file list -->
					<div id="filePosterList" style="width:100%;height:100px;background-color:#ffffff;overflow:auto;">
						첨부할 파일을 끌어다 놓으세요
					</div><br>
					
					<label id="content">공연 내용</label>
					<textarea class="form-control" rows="10" cols="50" name="content"
					 id="content" style="resize:none;">! 허위 정보를 입력할 경우 불이익이 발생할 수 있습니다.
장소 : 
설명 :
참여팀 : 
입장료 :
공연날짜 :
주의사항 :
기타 : (주차, 보관소, 굿즈판매 안내 등)
					</textarea><br>
						
					<%@ include file="../include/search_map.jsp" %>
					
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<input type="Button" class="btn btn-primary" value="등록" id="btnConfirm"/>
						<input type="Button" class="btn btn-danger" value="취소" id="btnCancel"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>