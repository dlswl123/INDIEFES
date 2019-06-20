<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	

	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:rgba(255,255,255,0.7);">
		<div class="col-md-12">
		<h1><a href = "/indiefes/">indiefes</a></h1>
		</div>
		<div class="col-md-4">
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
			</form>
		</div>
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>