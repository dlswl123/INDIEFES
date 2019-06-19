<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>앨범정보입력</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
<script>
$.fn.setPreview = function(opt){
    "use strict"
    var defaultOpt = {
        inputFile: $(this),
        img: null,
        w: 200,
        h: 200
    };
    $.extend(defaultOpt, opt);
 
    var previewImage = function(){
        if (!defaultOpt.inputFile || !defaultOpt.img) return;
 
        var inputFile = defaultOpt.inputFile.get(0);
        var img       = defaultOpt.img.get(0);
 
        // FileReader
        if (window.FileReader) {
            // image 파일만
            if (!inputFile.files[0].type.match(/image\//)) return;
 
            // preview
            try {
                var reader = new FileReader();
                reader.onload = function(e){
                    img.src = e.target.result;
                    img.style.width  = defaultOpt.w+'px';
                    img.style.height = defaultOpt.h+'px';
                    img.style.display = '';
                }
                reader.readAsDataURL(inputFile.files[0]);
            } catch (e) {
                // exception...
            }
        // img.filters (MSIE)
        } else if (img.filters) {
            inputFile.select();
            inputFile.blur();
            var imgSrc = document.selection.createRange().text;
 
            img.style.width  = defaultOpt.w+'px';
            img.style.height = defaultOpt.h+'px';
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";           
            img.style.display = '';
        // no support
        } else {
            // Safari5, ...
        }
    };
 
    // onchange
    $(this).change(function(){
        previewImage();
    });
};
$(document).ready(function() {
		var opt = {
	        img: $('#img_preview'),
	        w: 200,
	        h: 200
	    };
	 
	    $('#art_cover').setPreview(opt);
	
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
<h1>앨범정보입력</h1>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" id="registForm">
			<div class="col-md-2">
				<div class="form-group">
						<h3>앨범 이미지</h3>
						<input type="file" id="art_cover" accept=".jpg, .jpeg, .png"/>
						<br>
						<img id="img_preview" style="display:none;"/>	
				</div>
			</div>
			<div class="col-md-10">
				<div class="form-group">
						<label for="art_title">앨범제목</label>
						<input type="text" class="form-control" id="art_title"
							name="art_title" />
				</div>
<!-- 발라드 댄스 랩/힙합 R&B/Soul 재즈 록/메탈 트로트 포크/블루스 기타 -->
				<div class="form-group">
					<label for="art_genre">장르</label>
					<select id="art_genre">
						<option value="발라드">발라드</option>
						<option value="댄스">댄스</option>
						<option value="랩/힙합">랩/힙합</option>
						<option value="R&B/Soul">R&B/Soul</option>
						<option value="재즈">재즈</option>
						<option value="록/메탈" selected >록/메탈</option>
						<option value="포크/블루스">포크/블루스</option>
						<option value="기타">기타</option>
					</select>
				</div>
				<div class="form-group">
					<label for="art_pr">앨범 소개</label>
					<textarea rows="10" cols="80" id="art_pr"
						class="form-control" name="art_pr"></textarea>
				</div>
			</div>
				<br>
				<input type="button" id="btnSubmit" 
					class="btn btn-success" value="작성완료"/>
				<a href="/board/list">
				<input type="button" class="btn btn-danger" value="작성취소"/></a> 
			</form>
		</div>
	</div>
</div>
</body>
</html>