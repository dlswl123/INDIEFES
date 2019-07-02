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
	});
	
	// 홍보파일업로드버튼(인포 목록용)
	$("#btnInfoFile").click(function(e) {
		$("#info_file").trigger("click");
	});
	$("#info_file").change(function(e) {
		$("#spanInfoFile").text(this.files[0].name);
		
		var hiddenInput = "<input type='hidden' name='info_file_path' value='" + this.files[0].name + "'>"; 
		$("#concertWriteForm").append(hiddenInput);
	});
	
	// 포스터 파일 업로드 버튼(내부 상세정보용)
	$("#btnFiles").click(function() {
		$("#poster_file").trigger("click");
	});
	$("#poster_file").change(function() {
		var files = $("#poster_file").prop("files");
        
		uploadPosterFiles(files);
	});
	
	// 포스터 파일 드래그앤드롭 영역(내부 상세정보용)
	$("#filePosterList").on("dragenter dragover", function(e) {
		e.preventDefault ? e.preventDefault() : (e.returnValue = false);
	});
	$("#filePosterList").on("drop", function(e) {
		e.preventDefault ? e.preventDefault() : (e.returnValue = false);
		
		var files = e.originalEvent.dataTransfer.files;
		// -> 드롭 영역에 드롭한 파일
		// enctype="multipart/form-data"
		// enctype 의 기본값 : application/x-www-form-urlencoded

		uploadPosterFiles(files);
	});
	
	
	function uploadPosterFiles(files) {
		console.log("files : " + files);
		
		if ($("#filePosterList").text().trim() == "첨부할 파일을 끌어다 놓으세요") {
        	$("#filePosterList").text("");
        }
        	for (var i = 0; i < files.length; i++) {
    			$("#filePosterList").append("<div>" + files[i].name + "</div>");
//     			console.log("fileName : " + fileInput[i].name);

    			var hiddenInput = "<input type='hidden' name='file_path[" + i + "]' value='" + files[i].name + "'>"; 
    			$("#concertWriteForm").append(hiddenInput);
            }
		
// 		var formData = new FormData();
// 		formData.append("file", files); // <input type="text" name="file">
		

// 		var url = "/controller/upload/uploadAjax";
		
// 		$.ajax({
// 			"url" : url,
// 			"data" : formData,
// 			"processData" : false, // ?뒤의 데이터 보내지 않게
// 			"contentType" : false, // enctype="multipart/form-data"
// 			"type" : "post",
// 			"success" : function(receivedData) {
// 				if(receivedData != "fail") {
// 					console.log(receivedData);
// 					var startIndex = receivedData.indexOf("_");
// 					var fileName = receivedData.substring(startIndex + 1);
// 					console.log(fileName);
// 					var div = "";
// 					if (isImage(fileName)) {
// 						var slashIndex = receivedData.lastIndexOf("/");
// 		 				var front = receivedData.substring(0, slashIndex + 1); // 2019/5/17/
// 		 				var rear = receivedData.substring(slashIndex + 1); // fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
// 		 				var thumbName = front + "s_" + rear;

// 						div = "<div data-fileName='" + receivedData + "'>" + fileName 
// 							+ "<img src='/controller/upload/displayFile?fileName="
// 							+ thumbName + "'>" + "</div>";
// 					} else {
// 						div = "<div data-fileName='" + receivedData + "'>" + fileName 
// 							+ "<img src='/resources/images/file.png' width='20'>"
// 							+ "</div>";
// 					}
// 					$("#uploadedList").append(div);
// 				}
// 			}
// 		});
	} // End of uploadPosterFiles();
	
	
	$("#btnConfirm").click(function() {
		$("#concertWriteForm").submit();
	});
	
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
					<input type="text" class="form-control" name="subject" id="subject" placeholder="공연명을 기입해주세요" required/>
					
					<label id="show_date">공연 일자</label>
					<input type="datetime-local" class="form-control" id="show_date" />
					<input type="hidden" name="concert_date" id="concert_date" />
					
					<label id="summary">공연 요약 내용</label>
					<input type="text" class="form-control" name="summary" id="summary" placeholder="목록에 보여질 내용을 한줄로 요약해서 기입해주세요" />
					
					<label id="info_file_path">목록에 보일 홍보 요약 포스터(크기는 1200x300)</label><br>
					<input type="file" class="form-control" id="info_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" />
					<input type="button" value="파일찾기" id="btnInfoFile" class="btn btn-sm btn-success" />
					<span id="spanInfoFile"></span><br>
					
					<label id="file_path">홍보 포스터</label>
					<input type="file" class="form-control" id="poster_file" accept=".jpg, .gif, .png, .bmp, .jpeg" style="display:none;" multiple />
					<input type="button" value="파일찾기" id="btnFiles" class="btn btn-sm btn-success" />
					<!-- file drag&drop area and show file list -->
					<div id="filePosterList" style="width:100%;height:100px;background-color:#ffffff;overflow:auto;">
						첨부할 파일을 끌어다 놓으세요
					</div>
					
					<label id="content">공연 내용</label>
					<textarea class="form-control" rows="10" cols="50" name="content"
					 id="content" style="resize:none;">! 허위 정보를 입력할 경우 불이익이 발생할 수 있습니다.
장소 : 
설명 :
참여팀 : 
입장료 :
공연날짜 :
주의사항 :
기타 : 
						</textarea>
						
					<%@ include file="../include/search_map.jsp" %>
					
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<input type="Button" class="btn btn-primary" value="등록" id="btnConfirm"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>