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
$(window).unload(function(){
	return "unload";
});

$(document).ready(function(){
	

	$("#fileDrop").on("drop", function(e) {
		e.preventDefault();
		var file = e.originalEvent.dataTransfer.files[0];
		console.log(e);
		// -> 드롭 영역에 드롭한 파일
		var formData = new FormData();
		formData.append("file", file); // <input type="text" name="file">
		
		var url = "/upload/uploadAjax";
		
	$.ajax({
		"url" : url,
		"data" : formData,
		"processData" : false,  // ?뒤의 데이터를 보내지 않게
		"contentType" : false,  // enctype="multipart/form-data"
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
			
			}
		}); // $.ajax()
	});		// $("#fileDrop")
	
	// 작성완료버튼
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
});
</script>

<h1>글쓰기<h1>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" id="registForm">
				<div class="form-group">
					<label for="subject">제목</label>
					<input type="text" class="form-control" id="subject"
						name="subject" />
				</div>
			<div class="form-group">
				<label for="user_id">회원</label>
				<input type="text" class="form-control" id="user_id"
					name="user_id" value="${BoardVo.user_id}"/>
			</div>
				<div class="form-group">
					<label for="content">글내용</label>
					<textarea rows="10" cols="80" id="content"
						class="form-control" name="content"></textarea>	
					</div>
					
					<input type="button" id="btnSubmit" class="btn btn-success" value="작성완료"/>
				</form>
			</div>
		</div>
	</div>	

<%@ include file="../include/footer.jsp" %>