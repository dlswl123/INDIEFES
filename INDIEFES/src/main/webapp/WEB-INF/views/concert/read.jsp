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
<style>
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

	<section id="logo" style="padding:20px;width:100%;">
		<div class="row">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
			공연정보</span>
		</div>
	</section><hr>

	<section style="background-color:#292929;margin:20px;color:#00ff00;font-family:dgm;">
	
		<article style="padding:20px;">
			
			<!-- // move to new concert info write form -->
			<form role="form" id="concertReadForm" enctype="multipart/form-data">
				<div class="form-group">
					<!-- Session으로 유저 정보 받아오기 -->
<!-- 					<input type="hidden" name="user_id" value="indie1" /> -->
			
					<div><h1>${vo.subject}</h1></div><hr>
					
					<div>공연일시 : ${vo.concert_date}</div><hr>
					
<%-- 					<div>${vo.summary}</div><hr> --%>
					
					<c:forEach var="image" items="${list}">
					<div>
						<img src="/indiefes/concert/displayFile?fileName=${image}" style="max-width:100%;">
					</div><br>
					</c:forEach>
					
					<div>${vo.content}</div><hr>
						
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