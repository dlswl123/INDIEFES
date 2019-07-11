<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<script>
	$(document).ready(function() {
		
		var nickChkCondition = $("#nickCheck").val();
		var pwChkCondition = $("#pwCheck").val();
		
		function overlapChk() {
			
		    if(pwChkCondition == "Y" && nickChkCondition == "Y"){
		    	$("#submit").removeAttr("disabled");
		    }
		   	else{
		    	$("#submit").attr("disabled", "disabled");
		    }

	    };
// 		$("select option[value='1988']").attr("selected", true);
		
		var birth = "${userInfoVo.user_birth}";
		var subBirthYear = birth.substring(0, 4);
		var subBirthMonth = birth.substring(6, 7);
		var subBirthDay = birth.substring(9, 10);
		
		$("#birthYear").val(subBirthYear);
		$("#birthMonth").val(subBirthMonth);
		$("#birthDay").val(subBirthDay);
			
		
		$("#btnCancel").click(function() {
				
				
			location.replace('/indiefes');
				
// 				console.log("birth : " + birth);
// 	 			console.log("selectBirth : " + subBirthDay);
			
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
		
		// 닉네임 중복체크 버튼 클릭
		$("#nickOverlapChk").click(function() {
			var nick = $("#user_nick").val();
			console.log(nick);
			
			if(nick == "${userInfoVo.user_nick}"){
				$(".resultNick .msgNick").text("수정되지 않았습니다");
				$(".resultNick .msgNick").attr("style", "color:#f00");
				
				$("#nickCheck").attr("value", "Y");
				
				nickChkCondition = $("#nickCheck").val();
				overlapChk();
			}
			else{
				nick = {user_nick : $("#user_nick").val()};
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
			}
			
			
		
		});
		
		$("#btnDeleteUser").click(function() {
// 			console.log("회원탈퇴");
			var result = confirm('회원탈퇴를 하시겠습니까?'); 
			
			if(result){
				location.href="/indiefes/user/user-delete";
			}
			else{
				location.replace("/indiefes/user/user-info");
			}
		});
		
		$("#btnTeamSub").click(function() {
// 			console.log("인디팀가입");
			var result = confirm('인디팀 가입신청을 하시겠습니까?'); 
			
			if(result){
				location.href="/indiefes/user/indie-team-subscription";
			}
			else{
				location.replace("/indiefes/user/user-info");
			}
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
	table td {
		font-family: dgm;
		color: #00ff00;
	}
	</style>
	
            <div class="container">
    <div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color: #292929;">
        <div class="col-sm-12">
            <div class="col-sm-2"></div>
                <div class="col-sm-9" style="margin:auto;">
                    <section id="logo" style="padding:20px;width:100%;">
					<div class="row">
						<font>InDiEFeS</font>
						<span style="font-size:1.25rem;font-family:hss;margin-bottom: 10px;margin-top: auto;margin-left: 10px;margin-right: auto;">
						회원정보</span>
					</div>
					</section>
			                     
                    <form action="/indiefes/user/user-info-adjust">
                     
                    <table class="table table-striped">
                      <tr>
                        <td>아이디</td>
                        <td><input type="text" id = "user_id" name="user_id" class="form-control" value="${userInfoVo.user_id}" readonly></td>
                      </tr>
                       
                      <tr>
                        <td>비밀번호</td>
                        <td>
                        <input type="password" name="user_pw" id="user_pw" class="form-control">
                        </td>
                      </tr>
                       
                      <tr>
                        <td>비밀번호 확인</td>
                        <td>
                        <input type="password" name="user_pw2" id="user_pw2" class="form-control">
                        <p class="resultPw">
						<span class="msgPw"></span>
						</p>
                        </td>
                      </tr>
                      
                      <tr>
                        <td>이름</td>
                        <td>
                        <input type="text" name="user_name" value="${userInfoVo.user_name}" class="form-control">
                        </td>
                      </tr>
                      
                      <tr>
                        <td>닉네임</td>
                        <td>
                        <input type="text" id = "user_nick" name="user_nick" value="${userInfoVo.user_nick}" class="form-control">
                        <input type="button" id="nickOverlapChk" class="btn btn-info" value="닉네임중복체크"/>
						<p class="resultNick">
							<span class="msgNick"></span>
						</p>
                        </td>
                      </tr>
                      
                       <tr>
                        <td>이메일</td>
                        <td>
                        <input type="email" name="user_email" class="form-control" value="${userInfoVo.user_email}">
                        </td>
                      </tr>
                      
                      <tr>
                        <td>생년월일</td>
                        <td>
                        <select class="form-control" name="birthYear" id="birthYear" style="display: inline;width: 134;" >
						<c:forEach var="i" begin="1900" end="2019">
							<option>${i}</option>
						</c:forEach>
						 					
					</select>
					년
					
					
					
					<select class="form-control" name="birthMonth" id="birthMonth" style="display: inline;width: 135;">
						<c:forEach var="i" begin="1" end="12">
							<option>${i}</option>
						</c:forEach>
					</select>
					월
					
					
					
					<select class="form-control" name="birthDay" id="birthDay" style="display: inline;width: 134;">
						<c:forEach var="i" begin="1" end="31">
							<option>${i}</option>
						</c:forEach>
					</select>일
                        </td>
                      </tr>
                      
                      <tr>
                        <td>성별</td>
                        <td>
                        
					  <input type="radio" name="user_gender" 
					  <c:if test="${userInfoVo.user_gender eq 'F'}">checked="checked"</c:if>
					   value="F" />여성
					  <input type="radio" name="user_gender" 
					  <c:if test="${userInfoVo.user_gender eq 'M'}">checked="checked"</c:if>
					  value="M" />남성
                        </td>
                      </tr>
                      
                      <c:if test="${userInfoVo.user_level < 3}">
                      <tr>
                      	<td>팀 번호</td>
                      	<td>
                      	<c:if test="${indieTeamList != null}">
                      		<c:forEach items="${indieTeamList}" var="list">
                      			&nbsp;| ${list.art_team} : ${list.team_number}&nbsp; 
                      		</c:forEach>
                      	</c:if>
                      	</td>
                      </tr>
                      </c:if>
                      
                       
                    <tr>
                         <td colspan="2" class="text-center">
                         <c:if test = "${userInfoVo.user_level == 3}">
                         <input type="button" id=btnTeamSub class="btn btn-warning" value="인디팀신청" style="float: left;" />
                         </c:if>
                         
                         <input type="submit" id="submit" disabled="disabled" value="완료" class="btn btn-success">
 						 <button type="button" id="btnCancel" class="btn btn-warning" >취소</button>
 						 <input type="hidden" id="nickCheck" name="nickCheck" value="N"/>
                         <input type="hidden" id="pwCheck" name="pwCheck" value="N"/>
                         
                         <input type="button" id=btnDeleteUser class="btn btn-warning" value="회원탈퇴" style="float: right;" />
                         </td>    
                    </tr>
                         
                           
                    </table>
                 
                </form>   
                     
                </div>
        </div> <!-- col-sm-12 -->
    </div><!-- row -->
</div> <!-- container end-->


<%@ include file="../include/footer.jsp" %>