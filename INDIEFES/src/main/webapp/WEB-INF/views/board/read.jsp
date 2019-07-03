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
		var del = confirm("삭제하시겠습니까?");
		if (del) {
			location.href = "/indiefes/board/delete?board_number=${boardVo.board_number}";
		}
	});
	// 댓글 목록 가져오기
	function getReplyList() {
		var url = "/indiefes/reply/list/${boardVo.board_number}"
		$.getJSON(url, function(receivedData) {
			console.log("getReplyList()", receivedData);
			var strHtml = "";
			$(receivedData).each(function(i) {
				var user_id = "${userInfoVo.user_id}";
				
				strHtml += "<tr>"
					+		"<td>" + this.reply_number + "</td>"
					+		"<td>" + this.content + "</td>"
					+		"<td>" + this.user_id + "</td>"
					+		"<td>" + dateString(this.reg_date) + "</td>";
				if (user_id == this.user_id) {
					strHtml +=  "<td>"
							+	"<input type='button' value='수정' class='btn-xs btn-warning'"
							+		"data=content='" + this.content + "'"
							+     " data-user_id='" + this.user_id + "'"
							+		" data-reply_number='" + this.reply_number + "'"
							+		" data-index='" + i + "'>" 
							+ 	"</td>"
							+  	"<td>"
							+ 	"<input type='button' value='삭제' class='btn-xs btn-danger'"
							+     " data-reply_number='" + this.reply_number + "'"
							+		" data-board_number='" + this.board_number + "'"
							+		" data-index='" + i + "'>"
							+	"</td>";
				} else {
					strHtml += "<td>&nbsp;</td>"
							+  "<td>&nbsp;</td>";
				}
					  
				strHtml += "</tr>";
	
			});// $(receivedData).each(function(i)
					$("#replyList").html(strHtml);
		}); // $.getJSON
	}// function getReplyList()
	
	// 댓글 목록 버튼
	$("#btnReplyList").click(function(){
		console.log("btnReplyList 버튼 클릭됨.");
		getReplyList();
	});
	
	// 댓글 쓰기 버튼
	$("#btnReply").click(function(){
		console.log("btnReply 클릭됨");
		var board_number = "${boardVo.board_number}";
		var content = $("#reply_text").val();
		var user_id =$("#user_id").val();
		var data = {
				"board_number" : board_number,
				"content" : content,
				"user_id" : user_id
		};
		var url = "/indiefes/reply/insert";
		$.ajax({
			"type" : "post",
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Mehod-Override" : "post"
			},
			"dataType" : "text",
			"data" : JSON.stringify(data),
			"success" : function(receivedData) {
				getReplyList(); // 댓글 목록 가져오기
				
			}
		}); // $.ajax
	}); // $("#btnReply").click

	// 댓글수정버튼
	$("#replyList").on("click","btn-warning", function(){
	
		//댓글수정버튼이 클릭되면 화면에 보이지않는 a태그가 클릭되게하는부분
		$("#modal-721283").trigger("click"); // 연쇄반응
		var content = $(this).attr("data-content");
		var user_id = $(this).attr("data-user_id");
		var reply_number = $(this).attr("data-reply_number");
		var index = $(this).attr("data-index");
		$("#modal_content").val(content);
		$("#modal_user_id").val(user_id);
		$("#modal_reply_number").val(reply_number);
		$("#modal_index").val(index);
	});
	// 댓글 삭제 버튼
	$("#replyList").on("click", ".btn-danger", function() {

		var reply_number = $(this).attr("data-reply_number");
		var board_number = $(this).attr("data-board_number");
		var index = $(this).attr("data-index");

		var url = "/indiefes/reply/delete/" + reply_number + "/" + board_number;
		$.ajax({
			"type" : 'delete',
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Overried" : "delete"
			},
			"success" : function(receivedData) {
				console.log(receivedData); // success
				if (receivedData == "success") {
					// 1. 댓글 데이터를 새로 불러오기
//	 				getReplyList();
					// 2. Traversing(트래버싱)
					$("#replyList > tr").eq(index).fadeOut("1000");
				}
			}
		});
	});
	
	// 모달창 작성완료 버튼
	$("#btnModalReply").click(function() {
		var content = $("#modal_content").val();
		var user_id = $("#modal_user_id").val();
		var reply_number = $("#modal_reply_number").val();
		var data = {
				"content" : content,
				"user_id" : user_id,
				"reply_number" : reply_number
		};
// 		console.log(data);
		var url = "/indiefes/reply/update/" + reply_number;
		$.ajax({
			"type" : "put",
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "put"
			},
			"dataType" : "text",
			"data" : JSON.stringify(data),
			"success" : function(receivedData) {
				$("#btnModalReply").next().trigger("click"); // 모달창 사라지기
// 				getReplyList(); // 1. 새로 불러 들이기
				// 2. 해당 댓글, 댓글러만 수정
				var index = $("#modal_index").val();
				// <tbody> 내의 해당 번째 <tr>
				var target_tr = $("#replyList > tr").eq(index);
				// <tr>의 1번째(두번째) <td> - 댓글내용
				target_tr.find("td").eq(1).text(reply_text);
				// <tr>의 2번째(세번째) <td> - 댓글러
				target_tr.find("td").eq(2).text(replyer);
			} // "success"
		}); // $.ajax
	}); // $("#btnModalReply").click
	//첨부파일 목록 가져오기
	$.getJSON("/indiefes/board/getAttach/${boardVo.board_number}", function(list) {
		console.log("첨부 파일 목록 가져오기", list);
		
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
		 	<hr>
		 	
		 	<!--  댓글작성 -->
		 	<div class="row" style="background-color: #bfd2ef">
		 		<div class="col-md-12">
		 			<div class="form-group">
		 				<label for="title">댓글 내용</label>
		 				<input type="text" class="form-control" id="reply_text"/>
		 			</div>
		 		</div>
		 		<div class="col-md-12">
		 		<div class="form-group">
		 			<input type="button" class="btn-xs btn-success" id="btnReply"
		 				value="작성완료"/>
		 		</div>
		 		</div>
		 	</div>
		 	<hr>
		 	<!-- 댓글 목록 -->
		 	<div class="row">
		 		<div class="col-md-12">
		 			<p><input type="button" id=btnReplyList value="댓글목록"
		 				class="btn btn-primary"></p>
		 				
		 			<table class="table">
		 				<thead>
		 					<tr>
		 						<th>번호</th>
		 						<th>댓글내용</th>
		 						<th>작성자</th>
		 						<th>날짜</th>
		 						<th>수정</th>
		 						<th>삭제</th>
		 					</tr>
		 				</thead>
		 				<!-- 여기에 댓글 목록 보임 -->
		 				<tbody id="replyList">
		 				
		 				</tbody>
		 			</table>
		 		</div>
		 	</div>
		 	
		 </div>  <!-- class="col-md-10"   -->
	
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>