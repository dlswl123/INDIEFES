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
	// 파일첨부 버튼
	$("#file_path").click(function(e){
		e.preventDefault();
		var file_path = e.originalEvent.dataTransfer.files[0];
		console.log(e);
		// -> 첨부한파일목록 구현
		var formDate = new FormData();
		formData.append("file_path",file_path); // <input type="file" name"file_path">
		
		var url= "/upload/uploadAjax";

		$.ajax({
			"url" : url,
			"data" : formData,
			"processData" : false, // ?뒤의 데이터를 보내지않게
			"contentType" : false, // enctype="multipart/form-data"
			"type" : "post",
			"success" : function(fullName) { // /2019/5/17/asdad-adsa-ada_a.jpg
				var slashIndex = fullName.lastIndexOf("/");
				var front = fullName.substring(0, slashIndex + 1);
				var rear = fullName.substring(slashIndex + 1);
				var thumbnailName = front + "s_" + rear; // /2019/5/17/s-asdad-adsa-ada_a.jpg
				console.log(fullName);
				var startIndex = fullName.indexOf("_");
				var fileName = fullName.substring(startIndex + 1);
				var div = "";
				if (isImage(fileName)) {
					div = "<div data-filename='" + fullName + "'>" + fileName
						+ 	"<img src='/upload/displayFile?fileName=" + thumbnailName + "'>"
						+ "</div>";
				} else {
					div = "<div data-filename='" + fullName + "'>" + fileName
						+	"<img src='/resources/images/file_image.png' width='20'>"
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
			<!-- 파일첨부영역 -->
				<div class="form-grop">
				<div id="file_path"></div>
			</div>
			<!--  첨부파일 목록 -->
			<div class="form-group" id="uploadedList">
			</div>
			
				<input type="button" id="btnSubmit" class="btn btn-success" value="작성완료"/>
				<input type="button" id="btnList" class="btn btn-warning" value="목록보기"/>
				<!-- multiple 여러개 파일을 올릴수있도록구현 -->
				<input type="file" 	 id="file_path" class="btn btn-warning" multiple="multiple" value="파일첨부"/>
			</form>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>