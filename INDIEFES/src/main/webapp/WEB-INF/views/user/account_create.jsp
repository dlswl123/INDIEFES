<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	
	
	
	
	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:rgba(255,255,255,0.7);">
		<div class="col-md-12" style="width: 500;">
			<form role="form">
				<div class="form-group">
					 
					<label for="inputAccount">
						아이디
					</label>
					<input type="email" class="form-control" name="account" />
				</div>
				<div class="form-group">
					 
					<label for="inputPassword1">
						비밀번호
					</label>
					<input type="password" class="form-control" name="password1" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputPassword2">
						비밀번호 확인
					</label>
					<input type="password" class="form-control" name="password2" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputNickName">
						닉네임
					</label>
					<input type="text" class="form-control" name="nickName" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputEmail">
						e-mail
					</label>
					<input type="email" class="form-control" name="email" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputBirth">
						생년월일
					</label>
					
					<div style="margin-left:auto;margin-right:auto;">
					<input type="number" class="form-control" name="birthYear" style="display: inline;width: 138;"/>년
					
					
					
					<input type="text" class="form-control" name="birthMonth" style="display: inline;width: 138;" />월
					
					
					
					<input type="text" class="form-control" name="birthDay" style="display: inline;width: 137;" />일
					</div>
					
					성별<br>
					  <input type="radio" name="gender" value="female" />여성
					  <input type="radio" name="gender" value="male" />남성
					
					
					
				</div>
				
				<button type="submit" class="btn btn-primary">
					완료
				</button>
			</form>
		</div>
	</div>

	
<%@ include file="../include/footer.jsp" %>