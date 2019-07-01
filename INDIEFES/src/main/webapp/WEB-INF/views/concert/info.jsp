<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	var resultMessage = "${resultMessage}";
	
	if (resultMessage == "insert_success") {
		alert("글 등록이 완료되었습니다.");
	}
	
	// move to new concert info write form
	$("#btnWrite").click(function() {
		location.href = "/indiefes/concert/write";
	});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">

	<div class="row">
		<section style="padding:20px;width:100%;">
			<h1>공연 정보</h1>
	
			<div style="float:right;">
				<input type="button" class="btn btn-primary" value="글작성" id="btnWrite" />
			</div>
			
		</section>
	</div> <!-- row -->

	<section style="background-color:rgba(255,255,255,0.7);">
	
		<article style="text-align:center;padding:20px;">
		<h1>공연1</h1>
		<img src="${pageContext.request.contextPath}/resources/bg_images/concert.jpg">
		<h4>간단설명1</h4>
		</article>
	
	</section>
	
	<section style="background-color:rgba(255,255,255,0.7);">
	
		<article style="text-align:center;padding:20px;margin:20px;">
		<h1>공연2</h1>
		<img src="${pageContext.request.contextPath}/resources/bg_images/concert.jpg">
		<h4>간단설명1</h4>
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>