<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	
	
	<script>
	$(document).ready(function() {
		$("#idOverlapChk").click(function() {
			var id = {user_id : $("#user_id").val()};
			
			console.log(id);
		});

		
	});
	
	
	</script>
	
	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:rgba(255,255,255,0.7);">
		<div class="col-md-12" style="width: 500;">
			<form role="form" action="/indiefes/user/account-create-run">
				<div class="form-group">
					 
					<label for="inputAccount">
						아이디
					</label>
					<input type="text" class="form-control" id = "user_id" name="user_id" />
					<input type="button" id="idOverlapChk" value="중복체크"/>
				</div>
				<div class="form-group">
					 
					<label for="inputPassword1">
						비밀번호
					</label>
					<input type="password" class="form-control" name="user_pw" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputPassword2">
						비밀번호 확인
					</label>
					<input type="password" class="form-control" name="user_pw2" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputName">
						이름
					</label>
					<input type="text" class="form-control" name="user_name" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputNickName">
						닉네임
					</label>
					<input type="text" class="form-control" name="user_nick" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputEmail">
						e-mail
					</label>
					<input type="email" class="form-control" name="user_email" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputBirth">
						생년월일
					</label>
					
					<div style="margin-left:auto;margin-right:auto;">
<%-- 					<c:set var="now" value="<%=new java.util.Date()%>" /> --%>
					
					
					<select class="form-control" name="birthYear" style="display: inline;width: 134;" >
						<c:forEach var="i" begin="1900" end="2019">
							<option>${i}</option>
						</c:forEach>
						 					
					</select>
					년
					
					
					
					<select class="form-control" name="birthMonth" style="display: inline;width: 135;">
						<c:forEach var="i" begin="1" end="12">
							<option>${i}</option>
						</c:forEach>
					</select>
					월
					
					
					
					<select class="form-control" name="birthDay" style="display: inline;width: 134;">
						<c:forEach var="i" begin="1" end="31">
							<option>${i}</option>
						</c:forEach>
					</select>일
					</div>
					
					성별<br>
					  <input type="radio" name="user_gender" checked="checked" value="F" />여성
					  <input type="radio" name="user_gender" value="M" />남성
					
					
					
				</div>
				
				<button type="submit" class="btn btn-primary">
					완료
				</button>
			</form>
		</div>
	</div>

	
<%@ include file="../include/footer.jsp" %>