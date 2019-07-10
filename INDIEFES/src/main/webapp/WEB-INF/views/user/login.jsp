<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	
	<script>
	
		var message = "${message}";
		
		if(message == "create_accout_success"){
			alert("회원가입성공");
		} else if (message == "login_fail") {
			alert("로그인 실패");
		}
	
		$(document).ready(function() {
			$("#btnCreateAccount").click(function() {
				location.href="/indiefes/user/account-create";
			});
			
			
		});
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
			로그인</span>
		</div>
		</section>
	</div>
		<div class="col-md-12">
			<form role="form" action="/indiefes/user/login-run" method="post">
				<div class="form-group">
					 
					<label for="user_id">
						아이디
					</label>
					<input type="text" class="form-control" name="user_id" id="user_id" />
				</div>
				<div class="form-group">
					 
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
					로그인
				</button>
				
				<input type="button" id="btnCreateAccount" value="회원가입" class="btn btn-primary" style="float: right;" />
					
				
				</form>
			</div>
		</div>
	
	
	
	
<%@ include file="../include/footer.jsp" %>