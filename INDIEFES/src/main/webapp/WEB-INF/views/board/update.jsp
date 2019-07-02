<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script src="/indiefes/resources/js/myscript.js"></script> 
<script>
$(document).ready(function(){
	// 목록보기 버튼
	$("#btnList").click(function(){
		location.href="/indiefes/board/list";
	});
	//첨부파일 목록 가져오기
	$.getJSON("/indiefes/board/getAttach/${boardVo.board_number}", function(list) {
		
		
		$(list).each(function(){
			var fullName = this; // 2019/5/21/b7b9f598-0187-4071-a030-cda86bef5c4f_Lighthouse.jpg
			
			var underscoreIndex = fullName.lastIndexOf("_");
			var fName = fullName.substring(underscoreIndex + 1);
			
			var divEl = "<div class='img-thumbnail'>";
			
			
			if (isImage(fullName)) { // 이미지인 경우
				var slashIndex = fullName.lastIndexOf("/");
				var front = fullName.substring(0, slashIndex + 1); // // 2019/5/21/
				var rear = fullName.substring(slashIndex + 1); // b7b9f598-0187-4071-a030-cda86bef5c4f_Lighthouse.jpg
				var thumbnailName = front + "s_" + rear;
				var href="";
				console.log(fName);
				
				
				divEl   += "<img src='/indiefes/upload/displayFile?fileName="  + thumbnailName + "'>"
						
			} else { // 이미지가 아닌 경우
				
				divEl  += "<img src='/indiefes/resources/images/file_image.png'>";
				
			}
			
				divEl	+= "<br><a target='blank' href='/indiefes/upload/displayFile?fileName="
						+ fullName + "'>" + fName 
						+ "</a>&nbsp;&nbsp;<span><a href='#' class='deleteFile' data-fileName='" + fullName
						+ "'>&times;</a></span>"
						+ "</div>";
				 		
				 $("#uploadedList").append(divEl);
		});	// $(list).each(function()	
	}); // $.getJSON
	
	// 첨부파일 삭제
	$("#uploadedList").on("click", " .deleteFile", function(e) {
		e.preventDefault();
		var that = $(this);
		var fileName = $(this).attr("data-fileName");
		var url = "/indiefes/upload/deleteFile?fileName=" + fileName;
		$.get(url, function(result){
			if (result == "success") {
				that.parents("div.img-thumbnail").remove();
			}
		}); // $.get(url, function(result)
		
	}); // $("#uploadedList").on("click", " .deleteFile", function(e)
}); // $(document).ready
</script>
<form id="pageForm" action="/indiefes/board/read">
<input type="hidden" name="board_number" value="${param.board_number}">
<input type="hidden" name="page" value="${param.page}">
<input type="hidden" name="perPage" value="${param.perPage}">
<input type="hidden" name="searchType" value="${param.searchType}">
<input type="hidden" name="keyword" value="${param.keyword}">
</form>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>글 수정</h1>
	<form role="form" method="post" action="/indiefes/board/update">
	<input type="hidden" name="board_number" 
			value="${param.board_number}">
			<div class="form-group">
				<label for=subject> 글제목 </label>
				<input type="text" class="form-control" id="subject" 
				name="subject"value="${boardVo.subject}" />
			</div>
			<div class="form-group">
				<input type="hidden" class="form-control" id="user_id" 
						name="user_id" value="${boardVo.user_id}" readonly/>
			</div>
			<div class="form-group">
				<label for="content">글내용</label> 
				<textarea class="form-control" id="content" rows="10" cols="80"
					 	name="content" >${boardVo.content}</textarea>
			</div>
			<div class="form-group">
				<label for="view_count">조회수</label> 
				<input type="text" class="form-control" id="view_count" 
					value="${boardVo.view_count}" readonly/>
			</div>
			<div class="form-group">
				<label for="reg_date">작성일</label> 
				<input type="text" class="form-control" id="reg_date" 
					value="${boardVo.reg_date}" readonly/>
			<div class="row">
					<div class="col-md-12">
						<label for="regdate">첨부파일</label> 
						<div id="uploadedList">
						
						</div>
					</div>
				</div>
					<input type="submit" class="btn btn-success" value="수정완료" id="btnUpdate"/>
					<button type="button" class="btn btn-warning" id="btnList">목록보기</button>
			   </div>
		</form>
	</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>