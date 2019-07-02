<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>



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
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div>
				<h1>
					INDIEFES 
				</h1>
				
				<section>
					최신 앨범
					<article class="art1">
					<%@ include file="include/home_today_list.jsp" %>
					</article>
				</section>
				
				<section>
					인기 앨범
				<article class="art2">
					<%@ include file="include/home_good_list.jsp" %>
				</article>
				</section>
			</div>
		</div> <!-- col-md-10 / main -->
		
<%@ include file="include/sidebar.jsp" %>

<%@ include file="include/footer.jsp" %>
