<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	
	
	<script>
	$(document).ready(function() {
		
		var idChkCondition = $("#idCheck").val();
		var nickChkCondition = $("#nickCheck").val();
		var pwChkCondition = $("#pwCheck").val();
		
		
		
		function overlapChk() {
			
			
			
		    if(idChkCondition == "Y" && nickChkCondition == "Y" && pwChkCondition == "Y"){
		    	$("#submit").removeAttr("disabled");
		    }
		    else{
		    	$("#submit").attr("disabled", "disabled");
		    }

		  };
		
		// 아이디 중복체크 버튼 클릭
		$("#idOverlapChk").click(function() {
			var id = {user_id : $("#user_id").val()};
			
			
			
			$.ajax({
				  url : "/indiefes/user/id-check",
				  type : "post",
				  data : id,
				  success : function(data) {
				  
				   if(data == 1) 
				   {
				    $(".resultId .msgId").text("이미 존재하는 아이디입니다");
				    $(".resultId .msgId").attr("style", "color:#f00");   
				    
				    $("#idCheck").attr("value", "N");
				    
				   } 
				   else {
				    $(".resultId .msgId").text("사용가능한 아이디입니다");
				    $(".resultId .msgId").attr("style", "color:#00f");
				    
				    $("#idCheck").attr("value", "Y");
				    }
				   idChkCondition = $("#idCheck").val();
				   overlapChk();
				  }
			});  // ajax 끝
		
			
		
		});
		
		// 아이디 inputbox 값 변동
		$("#user_id").keyup(function(){
			 $(".resultId .msgId").text("아이디 중복 체크를 해주십시오");
			 $(".resultId .msgId").attr("style", "color:#fafafa");
			 
			 $("#idCheck").attr("value", "N");
			 
			 idChkCondition = $("#idCheck").val();
			 overlapChk();
			 
		});
		
		// 닉네임 중복체크 버튼 클릭
		$("#nickOverlapChk").click(function() {
			var nick = {user_nick : $("#user_nick").val()};
			
			$.ajax({
				  url : "/indiefes/user/nick-check",
				  type : "post",
				  data : nick,
				  success : function(data) {
				  
				   if(data == 1) 
				   {
				    $(".resultNick .msgNick").text("이미 존재하는 닉네임입니다");
				    $(".resultNick .msgNick").attr("style", "color:#f00");   
				    
				    $("#nickCheck").attr("value", "N");
				   } 
				   else {
				    $(".resultNick .msgNick").text("사용가능한 닉네임입니다");
				    $(".resultNick .msgNick").attr("style", "color:#00f");
				    
				    $("#nickCheck").attr("value", "Y");
				   }
				   nickChkCondition = $("#nickCheck").val();
				   overlapChk();
				  }
			});  // ajax 끝
		
		});
		
		// 닉네임 inputbox 값 변동
		$("#user_nick").keyup(function(){
			 $(".resultNick .msgNick").text("닉네임 중복 체크를 해주십시오");
			 $(".resultNick .msgNick").attr("style", "color:#fafafa");
			 
			 $("#nickCheck").attr("value", "N");
				 
			 nickChkCondition = $("#nickCheck").val();
			 overlapChk();
				 
		});
		
		// 비밀번호확인 inputbox 값 변동
		$("#user_pw2").keyup(function(){
			var pwVal = $("#user_pw").val();
			var pwVal2 = $("#user_pw2").val();
			
			if(pwVal == pwVal2){
				$(".resultPw .msgPw").text("비밀번호가 일치합니다");
				$(".resultPw .msgPw").attr("style", "color:#00f");
				
				$("#pwCheck").attr("value", "Y");
			}
			else{
				$(".resultPw .msgPw").text("비밀번호가 일치하지 않습니다");
				$(".resultPw .msgPw").attr("style", "color:#f00");
				
				$("#pwCheck").attr("value", "N");
			}
			pwChkCondition = $("#pwCheck").val();
			overlapChk();
			
			
// 			 console.log("비밀번호 바뀜");
// 			 console.log(pwCondition);
// 			 console.log(pwCondition2);
			 
		});
		
		//
// 		$("#idChkTest").click(function() {
			
			
			
			
// 			console.log("아이디체크여부 : " + idChkCondition);
			
			
// 		});
		
// 		$("#nickChkTest").click(function() {
			
			
			
			
			
// 			console.log("닉네임체크여부 : " + nickChkCondition);
			
// 		});
		
// 		$("#pwChkTest").click(function() {
			
			
// 			var pwCondition = $("#user_pw").val();
			
			
// 			console.log("비밀번호 : " + pwCondition);
			
// 		});
		
		
		
		
		
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
	margin-bottom: 30px;
	color: #00ff00;	
 	text-shadow: 1px 1px 0px lightgrey;
}
.col-md-12 {
	font-family: dgm;
	color: #00ff00;
	padding: 20px;
}
</style>

	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:#292929;">
		<div class="col-md-12" style="width: 550px;">
		<section id="logo" style="padding:20px;width:100%;">
			<div class="row">
				<font>InDiEFeS</font>
				<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
				회원가입</span>
			</div>
		</section><hr style="background-color:#fafafa;border-color:#fafafa;color:#fafafa;">
			<form role="form" action="/indiefes/user/account-create-run">
				<div class="form-group">
					 
					<label for="inputAccount">
						아이디
					</label>
					<input type="text" class="form-control" id = "user_id" name="user_id" />
					<input type="button" id="idOverlapChk" class="btn btn-info" value="아이디중복체크"/>
					<p class="resultId">
						<span class="msgId"></span>
					</p>
				</div>
				<div class="form-group">
					 
					<label for="inputPassword1">
						비밀번호
					</label>
					<input type="password" class="form-control" name="user_pw" id="user_pw" />
				</div>
				
				<div class="form-group">
					 
					<label for="inputPassword2">
						비밀번호 확인
					</label>
					<input type="password" class="form-control" name="user_pw2" id="user_pw2" />
					<p class="resultPw">
						<span class="msgPw"></span>
					</p>
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
					<input type="text" class="form-control" id = "user_nick" name="user_nick" />
					<input type="button" id="nickOverlapChk" class="btn btn-info" value="닉네임중복체크"/>
					<p class="resultNick">
						<span class="msgNick"></span>
					</p>
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
					
					<br>
					성별<br>
					  <input type="radio" name="user_gender" checked="checked" value="F" />여성
					  <input type="radio" name="user_gender" value="M" />남성
					
					
					
				</div>
				
				<button type="submit" id="submit" disabled="disabled" class="btn btn-primary">
					완료
				</button>
				
<!-- 				<input type="button" id="idChkTest" value="아이디체크테스트"> -->
<!-- 				<input type="button" id="nickChkTest" value="닉네임체크테스트">  -->
<!-- 					<input type="button" id="pwChkTest" value="비밀번호값테스트"> -->
				
				<input type="hidden" id="idCheck" name="idCheck" value="N"/>
				<input type="hidden" id="nickCheck" name="nickCheck" value="N"/>
				<input type="hidden" id="pwCheck" name="pwCheck" value="N"/>
			</form>
		</div>
	</div>

	
<%@ include file="../include/footer.jsp" %>