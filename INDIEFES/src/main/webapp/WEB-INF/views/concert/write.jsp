<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	// set input today to concertdate
	var today = new Date().toISOString().slice(0,16);
	$("input[name=concertdate]").val(today);
	
	$("#btnConfirm").click(function() {
		$("#concertWriteForm").submit();
	});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 정보 등록</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			
			<!-- // move to new concert info write form -->
			<form role="form" action="/indiefes/concert/write" method="post" id="concertWriteForm">
				<div class="form-group">
					<input type="hidden" name="user_id" value="indie1" />
				
					<label id="subject">공연 제목</label>
					<input type="text" class="form-control" name="subject" id="subject" />
					
					<label id="concertdate">공연 일자</label>
					<input type="datetime-local" class="form-control" name="concertdate" id="concertdate" />
					
					<label id="content">공연 내용</label>
					<textarea class="form-control" rows="10" cols="50" name="content" id="subject"
					style="resize:none;">
					</textarea>
					
					<%@ include file="../include/search_map.jsp" %>
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<input type="Button" class="btn btn-primary" value="등록" id="btnConfirm"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>