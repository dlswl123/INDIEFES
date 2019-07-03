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

			<c:if test="${user_id != null}">
				<div style="float:right;">
					<input type="button" class="btn btn-primary" value="글작성" id="btnWrite" />
				</div>
			</c:if>
			
		</section>
	</div> <!-- row -->

	<c:forEach var="vo" items="${list}">
		<section style="background-color:rgba(255,255,255,0.7);">
		
			<article style="text-align:center;padding:20px;">
			<h1>${vo.subject}</h1>
			<a href="/indiefes/concert/read?concert_number=${vo.concert_number}">
			<c:choose>
				<c:when test="${vo.info_file_path != null}">
					<img src="/indiefes/concert/displayFile?fileName=${vo.info_file_path}" style="max-width:1200px;max-height:350px;">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/resources/bg_images/concert.jpg" style="max-width:1200px;max-height:350px;">
				</c:otherwise>
			</c:choose>
			</a>
			<h4>${vo.summary} / ${vo.concert_date}</h4>
			</article>
		
		</section>
	</c:forEach>
	
</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>