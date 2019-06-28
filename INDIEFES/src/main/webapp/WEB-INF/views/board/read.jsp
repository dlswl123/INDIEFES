<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<script src="/indiefes/resources/js/myscript.js"></script> 
<script>
$(document).ready(function(){
	// 수정하기버튼
	$("#btnUpdate").click(function(){
//		console.log(btnUpdate);
		location.href = "/indiefes/board/update?board_number=${boardVo.board_number}";
	});
	// 목록보기버튼
	$("#btnList").click(function(){
//		console.log(btnList);
		location.href = "/indiefes/board/list";
	});
	// 삭제하기버튼
	$("#btnDelete").click(function(){
//		console.log(btnDelete);
		location.href = "/indiefes/board/delete?board_number=${boardVo.board_number}";
	});
	//첨부파일 목록 가져오기
	$.getJSON("/indiefes/board/getAttach/${boardVo.board_number}", function(list) {
		console.log(list);
		
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
				
				
				divEl   += "<img src='/indiefes/upload/displayFile?fileName="  + thumbnailName + "'><br>"
						+ "<a target='blank' href='/upload/displayFile?fileName="
						+ fullName + "'>" + fName + "</a>";
						
			} else { // 이미지가 아닌 경우
				 divEl	+= "<img src='/indiefes/resources/images/file_image.png'><br>"
				 		+ "<a href='/indiefes/upload/displayFile?fileName=" + fullName + "'>" 
				 		+	fName + "</a>";
				 		
				
			}
			
			divEl += "</div>";
			
			$("#uploadedList").append(divEl);
		
		});	// $(list).each(function()	
	}); // $.getJSON
}); // $(document).ready
</script>
<form id="pageForm" action="/indiefes/board/list">
	<input type="hidden" name=board_number
	 		value="${param.board_number}">
	<input type="hidden" name=page
	 		value="${param.page}">
	<input type="hidden" name=perPage
	 		value="${param.perPage}">
	<input type="hidden" name=searchType
	 		value="${param.searchType}">
	<input type="hidden" name=keyword
	 		value="${param.keyword}">
</form>	 	
<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<h1>글 조회</h1>
			데이터확인 = ${param.board_number}
			<form role="form" method="post">
				<div class="form-group">
					<label for="subject">글제목</label>
					<input type="text" class="form-control" id="subject"
					name="subject" value="${boardVo.subject}" readonly/>
				</div>
				<div class="form-group">
					<label for="user_id">작성자</label>
					<input type="text" class="form-control" id="user_id"
					name="user_id" value="${boardVo.user_id}" readonly/>
				</div> 
				<div class="form-group">
					<label for="content">글내용</label>
					<textarea class="form-control" id="content" rows="10" cols="80"
					name="content" readonly>${boardVo.content}</textarea>
				</div>
				
				<!-- 조회수 미해결 -->
				<!-- 새로고침 할 시 현재 갖고 있는 페이지(board_number)정보와
				 새로고침한 페이지(board_number)가 같으면
				조회수를 올리지 않게 설정 -->
				<div class="form-group">
					<label for="view_count">조회수</label>
					<input type="text" class="form-control" id="view_count"
						value="${boardVo.view_count}" readonly/>
				</div>
				<div class="form-group">
					<label for="reg_date">작성일</label>
					<input type="text" class="form-control"	id="reg_date"
						value="${boardVo.reg_date}" readonly/>
				</div>
				<div class="form-group">
					<label for="regdate">첨부파일</label>
					<div id="uploadedList">
						
					</div>
				</div>	
				</form>
			<div class="row">
				<div class="col-md-12">
					<input type="button" class="btn btn-success" value="수정하기" id="btnUpdate"/>
					<input type="button" class="btn btn-danger" value="삭제하기" id="btnDelete"/>
					<input type="button" class="btn btn-warning" value="목록보기" id="btnList"/>
					
				</div> <!-- class="col-md-12"-->
		 	</div> <!-- class="row"> -->
		</div> <!-- class="col-md-10" -->
	
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>