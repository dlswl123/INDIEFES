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
<style>
.infoImage {
	position: relative;
	width: 100%;
	overflow: hidden;
	display: block;
}
h1.concertTitle {
	z-index: 2;
    position: absolute;
    top: 10px;
    color: #fff;
    display: block;
    width: 100%;
    text-shadow: -1px 0 grey, 0 1px grey, 1px 0 grey, 0 -1px grey;
}
.concertSummary {
	z-index: 2;
    position: absolute;
    bottom: 10px;
    color: #fff;
    display: block;
    width: 100%;
    text-shadow: -1px 0 grey, 0 1px grey, 1px 0 grey, 0 -1px grey;
}
article {
	background-color: #292929;
}
#logo font {
	font-family: blox;
	font-size: 3.5rem;
	margin-left: 30px;
}
#logo {
	margin-bottom: 30px;
	color: #292929;	
 	text-shadow: 1px 1px 0px lightgrey;
}
</style>

<div class="col-md-10">

	<div class="row">
		<section id="logo" style="padding:20px;width:100%;">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 30px;margin-top: auto;margin-left: 10px;margin-right: auto;">
			공연정보</span>
			<c:if test="${user_level < 3}">
				<div style="float:right;">
					<input type="button" class="btn btn-primary" value="홍보글작성" id="btnWrite" />
				</div>
			</c:if>
			
		</section>
	</div>

	<c:forEach var="vo" items="${list}">
		<section class="concertList">
		
			<article style="text-align:center;padding:20px;">
				<div class="infoImage">
					<a href="/indiefes/concert/read?concert_number=${vo.concert_number}">
					<c:choose>
						<c:when test="${vo.info_file_path != null && vo.info_file_path != 'null' && vo.info_file_path != ''}">
							<img src="/indiefes/concert/displayFile?fileName=${vo.info_file_path}" style="max-width:1200px;max-height:350px;">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/resources/bg_images/concert.jpg" style="max-width:1200px;max-height:350px;">
						</c:otherwise>
					</c:choose>
					<h1 class="concertTitle">${vo.subject}</h1>
					<div class="concertSummary">요약내용 : ${vo.summary}<br>일시 : ${vo.concert_date}</div>
					</a>
				</div>
			</article>
			
		</section>
	</c:forEach>
	
</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>