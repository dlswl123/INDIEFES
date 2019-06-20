<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function() {
	
	// 작성완료 버튼
	$("#btnTeam").click(function() {
		
		// 폼을 전송
		$("#team1").submit();
	});
	$("#btnMember").click(function() {
		var team_number = $("#team_number").val();
		location.href = "/indiefes/art/team_member_input?team_number="+team_number;
	});
});
</script>
<!-- localhost/board/regist -->
<br><br><br><br><br><br><br>
<h1 style="color: #ffffff;">팀생성</h1>
	<div class="col-md-12">
		<div class="col-md-10">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" id="team1">
			<input type="hidden" name="team_level" value="0">
				<div class="form-group">
					<label for="art_team" style="color: #ffffff;">팀이름</label>
					<input type="text" class="form-control" id="art_team"
						name="art_team" />
				</div>
				<input type="button" id="btnTeam" 
					class="btn btn-success" value="작성완료"/>
				<a href="">
				<input type="button" class="btn btn-danger" value="작성취소"/></a> 
			</form>
		</div>
<%@ include file="../include/sidebar.jsp" %>
<br><br><br><br><br><br><br>
<h1 style="color: #ffffff;">팀가입</h1>		
		<div class="col-md-10">
			<!-- form action 속성 생략시 현재 경로(board/regist)가 액션 -->
			<form role="form" method="post" >
				<div class="form-group">
					<label for="team_number" style="color: #ffffff;">팀번호</label>
					<input type="number" class="form-control" id="team_number"
						name="team_number" />
				</div>
				<input type="button" id="btnMember" 
					class="btn btn-success" value="작성완료"/>
				<a href="">
				<input type="button" class="btn btn-danger" value="작성취소"/></a> 
			</form>
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>