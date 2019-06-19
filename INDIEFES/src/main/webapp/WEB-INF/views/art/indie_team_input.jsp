<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>팀생성</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
<script>
$(document).ready(function() {
	
	// 작성완료 버튼
	$("#btnSubmit").click(function() {
		var upDiv = $("#uploadedList > div"); // 업로드 목록 div
		upDiv.each(function(index) { // 각각의 div에 대해서
			var filename = $(this).attr("data-filename"); // data-filename 속성의 값
			console.log("div, filename:" + filename);
			// <input type="hidden"> 을 만들어서 폼에 붙이고
			var hiddenInput = "<input type='hidden' name='files[" + index + "]'"
						    + " value='"+ filename + "'>";
			$("#registForm").append(hiddenInput);
		});
		
		// 폼을 전송
		$("#registForm").submit();
	});
});
</script>
<!-- localhost/board/regist -->
<br><br><br><br><br><br><br>
<h1>팀생성</h1>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" id="registForm">
				<div class="form-group">
					<label for="title">팀이름</label>
					<input type="text" class="form-control" id="title"
						name="title" />
				</div>
				<input type="button" id="btnSubmit" 
					class="btn btn-success" value="작성완료"/>
				<a href="">
				<input type="button" class="btn btn-danger" value="작성취소"/></a> 
			</form>
		</div>
<br><br><br><br><br><br><br>
<h1>팀가입</h1>		
		<div class="col-md-12">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" id="registForm">
				<div class="form-group">
					<label for="title">팀번호</label>
					<input type="number" class="form-control" id="title"
						name="title" />
				</div>
				<input type="button" id="btnSubmit" 
					class="btn btn-success" value="작성완료"/>
				<a href="">
				<input type="button" class="btn btn-danger" value="작성취소"/></a> 
			</form>
		</div>
	</div>
</div>
</body>
</html>