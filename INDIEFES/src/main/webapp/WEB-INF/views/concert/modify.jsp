<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	var cDate = "${vo.concert_date}";
	var concertDate = replaceAll(cDate.slice(0,10), "-", "/");
	var formData = new FormData();
	formData.append("concertDate", concertDate);
	
	// set input today to show_date
	$("input[id=show_date]").val(cDate.slice(0,16).replace(" ", "T"));
	$("input[name=concert_date]").val(cDate.slice(0,16));
	
	$("input[id=show_date]").on("change", function() {
		var show_date = $("input[id=show_date]").val();
		$("input[id=show_date]").val(show_date);
		
		$("input[name=concert_date]").val(show_date.slice(0,16).replace("T", " "));
		concertDate = replaceAll(show_date.slice(0,10), "-", "/");
		formData.delete("concertDate");
		formData.append("concertDate", concertDate);	
	});
	
	// 날짜바꾸기
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	
	var files; // 파일 받는용
	var i = 0;
	var newIndex;
	
	var uploadedInfoFile = "${vo.info_file_path}";
	var index = uploadedInfoFile.lastIndexOf("_");
	var uploadedInfoFileName = uploadedInfoFile.substring(index + 1);
	$("#spanInfoFile").text(uploadedInfoFileName);
	
	// 홍보파일업로드버튼(인포 목록용)
	$("#btnInfoFile").click(function(e) {
		$("#info_file").trigger("click");
	});
	$("#info_file").change(function(e) {
		$("#spanInfoFile").text(this.files[0].name);

		formData.append("infoFile", this.files[0]);
	});
	
	
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
	
	// 홍보 이미지 파일 목록출력 영역
	function uploadPosterFiles(files) {
		
		// 파일이 아무것도 없을경우 초기화
		if ($("#filePosterList").text().trim() == "첨부할 파일을 끌어다 놓으세요") {
        	$("#filePosterList").text("");
        }
		
       	for (var j = 0; j < files.length; j++) {
   			$("#filePosterList").append("<div class='uploadedFile'>" + files[j].name 
   				+ "<a href='#' class='deleteFile' data-fileIndex='" + i 
				+  "'>&times;</a></div>");
   			
   			formData.append("posterFile[" + j + "]", files[j]); // <input type="text" name="files">
   			console.log("formData : " + formData.get("posterFile[" + j + "]"));
   			i++;
		}
		
	} // End of uploadPosterFiles();
	
	var fileList = new Array();
	
	// 첨부 파일 목록 가져오기
	$.getJSON("/indiefes/concert/getFiles/${vo.concert_number}", function(list) {
		console.log(list);
		$(list).each(function() {
			var fullName = this; // 2019/5/21/0e6348d6-92d6-4f92-98e2-617ce4ba64ff_Chrysanthemum.jpg
			
			var underscoreIndex = fullName.lastIndexOf("_");
			var fName = fullName.substring(underscoreIndex + 1);
			
			fileList[i] = fullName;
			
			var divEl = "<div class='uploadedFile'>" + fName 
					+   "<a href='#' class='deleteFile' data-fileIndex='" + i 
					+   "'>&times;</a></div>";
			$("#filePosterList").append(divEl);
			i++;
			newIndex = i;
		}); // $(list).each
	}); // $.getJSON
	
	
	$("#filePosterList").on("click", ".deleteFile", function(e) {
		e.preventDefault();
		var that = $(this);
		var fileIndex = $(this).attr("data-fileIndex");
		if (fileIndex > newIndex) {
			formData.delete("posterFile[" + fileIndex + "]");	
			that.parents("div.uploadedFile").remove();
		} else {
			var url = "/indiefes/concert/deleteFile?fileName=" + fileList[fileIndex];
			$.get(url, function(result) {
				console.log(result);
				if (result == "success") {
					that.parents("div.uploadedFile").remove();
				}
			});
		}
	}); // 파일목록 리스트 지우기
	
	// 수정 취소
	$("#btnCancel").click(function() {
		location.href = "/indiefes/concert/read?concert_number=${vo.concert_number}";
	});
	
	// 수정 확인
	$("#btnConfirm").click(function() {
		
		if ($("#spanInfoFile").text() != uploadedInfoFileName) {
			$.get("/indiefes/concert/deleteFile?fileName=" + uploadedInfoFile, function(result) {
				if (result == "success") {
					alert("fileDeleteSuccess");
				}
			});
		}
		
		if($("input[id=subject]").val() == "" || $("input[id=subject]").val() == null) {
			alert("제목을 입력해 주세요.");
			$(this).focus();
		} else if ($("input[id=summary]").val() == "" || $("input[id=summary]").val() == null) {
			alert("요약정보를 입력해 주세요.");
			$(this).focus();
		} else if ($("input[id=place_x]").val() == "" || $("input[id=place_x]").val() == null || $("input[id=place_y]").val() == "" || $("input[id=place_y]").val() == null) {
			alert("장소를 선택해 주세요.");
		} else if ($("input[id=place_name]").val() == "" || $("input[id=place_name]").val() == null) {
			alert("장소명을 입력해 주세요.");
			$(this).focus();
		} else {
			
			var content = $("textarea[id=content]").val();
			var text = content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
			$("textarea[id=content]").val(text);
	
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
						
						console.log(typeof(receivedData.info_file_path));
						console.log(receivedData.info_file_path);
						
						console.log(typeof(receivedData.file_path));
						console.log(receivedData.file_path);
						
						if (receivedData.info_file_path != null) {
							var infoFilePath = "<input type='hidden' name='info_file_path' value='" + receivedData.info_file_path + "'>"; 
							$("#concertModForm").append(infoFilePath);
						} else {
							var infoFilePath = "<input type='hidden' name='info_file_path' value='" + uploadedInfoFile + "'>"; 
							$("#concertModForm").append(infoFilePath);
						}
						
						if (receivedData.file_path != null) {
							var filePath = "<input type='hidden' name='file_path' value='" + receivedData.file_path + "'>"; 
				   			$("#concertModForm").append(filePath);
						}
			   			
			   			$("#concertModForm").submit();
					}
				}
			}); // $.ajax({});
			
		} // else
		
	}); // $("#btnConfirm").click(function(){});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 정보 등록</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			<!-- // move to new concert info write form -->
			<form role="form" action="/indiefes/concert/modify" method="post" id="concertModForm" enctype="multipart/form-data">
				<div class="form-group">
<!-- 					Session으로 유저 정보 받아오기 -->
					<input type="hidden" name="concert_number" value="${vo.concert_number}" />
			
					<label id="subject">공연 제목</label>
					<input type="text" class="form-control" name="subject" id="subject" value="${vo.subject}" required/><br>
					
					<label id="show_date">공연 일자</label>
					<input type="datetime-local" class="form-control" id="show_date" />
					<input type="hidden" name="concert_date" id="concert_date" value="${vo.concert_date}" /><br>
					
					<label id="summary">공연 요약 내용</label>
					<input type="text" class="form-control" name="summary" id="summary" value="${vo.summary}" /><br>
					
					<label id="info_file_path">목록에 보일 홍보 요약 포스터(크기는 최대 1200x350)</label>
					<input type="file" class="form-control" id="info_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" />
					<input type="button" value="파일찾기" id="btnInfoFile" class="btn btn-sm btn-success" />
					<span id="spanInfoFile"></span><br><br>
					
					<label id="file_path">홍보 포스터</label>
					<input type="file" class="form-control" id="poster_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" multiple />
					<input type="button" value="파일찾기" id="btnFiles" class="btn btn-sm btn-success" />
					<!-- file drag&drop area and show file list -->
					<div id="filePosterList" style="width:100%;height:100px;background-color:#ffffff;overflow:auto;">
					<!-- 파일 목록 -->
					</div><br>
					
					<label id="content">공연 내용</label>
					<textarea class="form-control" rows="10" cols="50" wrap="hard" name="content"
					 id="content" style="resize:none;">${vo.content}</textarea><br>
						
					<%@ include file="../include/modify_map.jsp" %>
					
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<input type="Button" class="btn btn-primary" value="확인" id="btnConfirm"/>
						<input type="Button" class="btn btn-danger" value="취소" id="btnCancel"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>