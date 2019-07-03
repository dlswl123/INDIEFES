<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	
	<script>
	
		$(document).ready(function() {
			
			var user_info_winput_run_result = "${user-info-pwinput-run}";
			if (user_info_winput_run_result == 'fail') {
				alert("비밀번호가 틀렸습니다");
			}
			
		});
	</script>	
	
	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:rgba(255,255,255,0.7);">
		<div class="col-md-12">
		<h1>비밀번호를 입력하세요</h1>
		</div>
		<div class="col-md-12">
			<form role="form" action="/indiefes/user/user-info-pwinput-run" method="post">
			
				<div class="form-group">
					 <input type="hidden" name="user_id" value="${userInfoVo.user_id}">
					<label for="user_pw">
						비밀번호
					</label>
					<input type="password" class="form-control" name="user_pw" id="user_pw" />
				</div>
				
<!-- 				<div class="checkbox"> -->
					 
<!-- 					<label> -->
<!-- 						<input type="checkbox" /> Check me out -->
<!-- 					</label> -->
<!-- 				</div>  -->
				<button type="submit" class="btn btn-primary">
					확인
				</button>
					
				
				</form>
			</div>
		</div>
	
	
	
	
<%@ include file="../include/footer.jsp" %>