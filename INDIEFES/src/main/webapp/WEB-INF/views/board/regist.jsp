<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function(){
	// 목록보기 버튼
	$("#btnList").click(function(){
		console.log("btnList");
		location.href="/indiefes/board/list"
	});
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
			<h1>글 쓰기<h1>
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
				<input type="button" id="btnSubmit" class="btn btn-success" value="작성완료"/>
				<input type="button" id="btnList" class="btn btn-warning" value="목록보기"/>
			</form>
		</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>