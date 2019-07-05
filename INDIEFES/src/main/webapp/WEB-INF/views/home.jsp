<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<style>
#logo font {
	font-family: blox;
	font-size: 3.5rem;
	margin-left: 30px;
}
#dgm {
	font-family: dgm;
	font-size: 2rem;
	margin-left: 20px;
}
</style>

		<script>
			$(document).ready(function() {
			
			var message = "${message}";
			if (message == "success") {
				alert("회원정보가 수정되었습니다 재로그인 해주십시오");
			}
			else if(message == "delete-success"){
				alert("회원탈퇴가 완료되었습니다");
			}
		});
			
		</script>
		<div class="col-md-10" style="margin:auto;padding:50px;">
			<div>
				<section id="logo" style="background-color:rgba(255,255,255,0.7);">
					<div class="row">
						<font>InDiEFeS</font>
						<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
						매일매일 인디축제</span>
					</div>
				</section>
				<hr style="background-color:rgba(255,255,255,0.7);">
				<section style="background-color:rgba(255,255,255,0.7);">
					<font id="dgm">
						최신 앨범
					</font>
					<article class="art1">
					<%@ include file="include/home_today_list.jsp" %>
					</article>
				</section>
				<hr style="background-color:rgba(255,255,255,0.7);">
				<section style="background-color:rgba(255,255,255,0.7);">
					<font id="dgm">
						인기 앨범
					</font>
					<article class="art2">
					<%@ include file="include/home_good_list.jsp" %>
					</article>
				</section>
			</div>
		</div> <!-- col-md-10 / main -->
		
<%@ include file="include/sidebar.jsp" %>

<%@ include file="include/footer.jsp" %>
