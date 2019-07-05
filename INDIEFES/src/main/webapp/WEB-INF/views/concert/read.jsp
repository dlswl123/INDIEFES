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
	
	
	$("#btnList").click(function() {
		location.href = "/indiefes/concert/info";		
	}); // $("#btnList").click(function(){});
	
	
	$("#btnDel").click(function() {
		location.href = "/indiefes/concert/delete?concert_number=${vo.concert_number}";
	});
	
	$("#btnMod").click(function() {
		location.href = "/indiefes/concert/modify?concert_number=${vo.concert_number}";
	});
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 상세 정보</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			
			<!-- // move to new concert info write form -->
			<form role="form" action="/indiefes/concert/write" method="post" id="concertWriteForm" enctype="multipart/form-data">
				<div class="form-group">
					<!-- Session으로 유저 정보 받아오기 -->
<!-- 					<input type="hidden" name="user_id" value="indie1" /> -->
			
					<label id="subject">공연 제목</label>
					<div>${vo.subject}</div><br>
					
					<label id="show_date">공연 일자</label>
					<div>${vo.concert_date}</div><br>
					
					<label id="summary">공연 요약 내용</label>
					<div>${vo.summary}</div><br>
					
					<label id="file_path">홍보 포스터</label>
					<c:forEach var="image" items="${list}">
					<div>
						<img src="/indiefes/concert/displayFile?fileName=${image}" style="max-width:100%;">
					</div><br>
					</c:forEach>
					
					<label id="content">공연 내용</label>
					<div>${vo.content}</div><br>
						
					<%@ include file="../include/show_map.jsp" %>
					
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<c:if test="${vo.user_id == user_id || user_level < 2}">
							<input type="button" class="btn btn-danger" value="삭제" id="btnDel"/>
							<input type="button" class="btn btn-warning" value="수정" id="btnMod"/>
						</c:if>
						<input type="button" class="btn btn-primary" value="목록보기" id="btnList"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>