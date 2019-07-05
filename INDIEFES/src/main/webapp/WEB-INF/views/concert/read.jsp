<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
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
			<form role="form" id="concertReadForm" enctype="multipart/form-data">
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