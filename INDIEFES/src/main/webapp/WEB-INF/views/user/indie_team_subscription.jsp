<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	
	<script>
	
	var message = "${message}";
	
// 	if(message == "create_accout_success"){
// 		alert("회원가입성공");
// 	} 
	console.log(message);
	if (message == "fail") {
		alert("비밀번호가 틀렸습니다");
	}
	</script>	
	<style>
	#logo font {
		font-family: blox;
		font-size: 3.5rem;
		margin-left: 30px;
		color: #00ff00;
	}
	#logo {
		color: #00ff00;	
	 	text-shadow: 1px 1px 0px lightgrey;
	}
	.form-group label {
		font-family: dgm;
		color: #00ff00;
	}
	</style>
	
	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:#292929;">
		<div class="col-md-12">
		<section id="logo" style="padding:20px;width:100%;">
		<div class="row">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 10px;margin-top: auto;margin-left: 10px;margin-right: auto;">
			비밀번호 확인</span>
		</div>
		</section>
		</div>
		<div class="col-md-12">
			<form role="form" action="/indiefes/user/indie-team-subscription-run" method="post">
			
				<div class="form-group">
					 <input type="hidden" name="user_id" value="${userInfoVo.user_id}">
					<label for="user_pw">
						비밀번호를 입력하세요
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