<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	#fileDrop {
		width : 80%;
		height : 100px;
		border : 1px dashed green;	
		background-color : #FF8C00;
		margin : auto;
	}
</style> 
<script>
$(document).ready(function(){
	
	// 목록보기 버튼
	$("#btnList").click(function(){
		console.log("btnList");
		location.href="/indiefes/board/list"
	});
	// 파일첨부 
	$("#fileDrop").on("dragenter dragover", function(e) {
// 		console.log("dragenter dragover");
		e.preventDefault();
	});
	$("#fileDrop").on("drop", function(e) {
		console.log(e);
		e.preventDefault();
		var file = e.originalEvent.dataTransfer.files[0];
		console.log(file);

		var formData = new FormData();
		formData.append("file", file); // <input type="file" name"file_path">
		
		var url= "/indiefes/upload/uploadAjax";

		$.ajax({
			"url" : url,
			"data" : formData,
			"processData" : false, // ?뒤의 데이터를 보내지않게
			"contentType" : false, // enctype="multipart/form-data"
			"type" : "post",
			"success" : function(fullName) { // /2019/5/17/asdad-adsa-ada_a.jpg
				
				console.log(fullName);
				var slashIndex = fullName.lastIndexOf("/");
				var front = fullName.substring(0, slashIndex + 1);
//				console.log(front); 2019/6/27
				var rear = fullName.substring(slashIndex + 1);
//				console.log(rear); 0ed9f524-3287-419c-b75b-f141e9ece760_Desert.jpg
				var thumbnailName = front + "s_" + rear; // 2019/6/27/s_97ae61f1-d8d4-4613-ae29-3eb14b7dcaed_Desert.jpg
//				console.log(thumbnailName);
				
				
				var startIndex = fullName.indexOf("_");
 				var fileName = fullName.substring(startIndex + 1);
				var div = "";
				if (isImage(fileName)) {
					div = "<div data-filename='" + fullName + "'>" + fileName
						+ 	"<img src='/indiefes/upload/displayFile?fileName=" + thumbnailName + "'>"
						+ "</div>";
				} else {
					div = "<div data-filename='" + fullName + "'>" + fileName
						+	"<img src='/indiefes/resources/images/file_image.png' width='20'>"
						+ "</div>";
				}
						
				$("#uploadedList").append(div);
			} // success" : function(fullName)
			
		}); // $.ajax
 	}); // $("#file_path").click

	// 작성완료 버튼
	$("#btnSubmit").click(function(){
		var upDiv = $("#uploadedList > div"); // 업로드 목록 div
		upDiv.each(function(index){ // 각각의 div에 대해서
			var filename = $(this).attr("data-filename"); // data-filename 속성의 값
			console.log('div, filename:' + filename);
			// <input type="hidden"> 을 만들어서 폼에 붙이고
			var hiddenInput =  "<input type='hidden' name='files[" + index + "]'" 
							+  " value='" + filename + "'>";
			$("#registForm").append(hiddenInput);				
		
		});
		// 폼을 전송
		$("#registForm").submit();
		
	}); // $("#btnSubmit").click(function()
}); // $(document).ready
</script>
<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<h1>글 쓰기</h1>
			<form role="form" method="post" id="registForm">
			<div class="form-group">
				<label for="subject">제목</label>
				<input type="text" class="form-control" id="subject"
					name="subject" />
			</div>
			<div class="form-group">
				<label for="user_id">작성자</label>
				<input type="text" class="form-control" id="user_id"
					name="user_id" value="${BoardVo.user_id}"/>
			</div>
			<div class="form-group">
				<label for="content">글내용</label>
				<textarea rows="10" cols="80" id="content"
					class="form-control" name="content"></textarea>	
			</div>
			<!-- 파일 첨부 -->
			<div class="form-grop">
				<label for="content">첨부할 파일을 드래그 &amp; 드롭하세요.</label>
				<!-- 드롭 영역 -->
				<div id="fileDrop"></div>
			</div>
			<!--  첨부파일 목록 -->
			<div class="form-group" id="uploadedList">
			</div>
				<div id="file_path_div">
					<input type="button" id="btnSubmit" class="btn btn-success" value="작성완료"/>
					<input type="button" id="btnList" class="btn btn-warning" value="목록보기"/>
				</div>
			</form>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>