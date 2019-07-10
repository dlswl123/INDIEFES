<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<style>
.sidebar font {
	color: #00ff00;
}
.sidebar #home font {
	font-family: blox;
	font-size: 3.5rem;
}
.sidebar #login, #logout, #userInfo, #teamInfo, #boardList, #artInfo, #concertInfo, #player, #payInfo, #teamInput font {
	font-family: prstart;
	margin-bottom: 10px;
	line-height: 20px;
}
.sidebar #home {
	padding:20px;
}
.sidebar section {
	padding-left:20px;
}
</style>

<script>
$(document).ready(function() {
	$("#login font").hover(function() {
		$(this).text("로그인 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("LOGIN").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#logout font").hover(function() {
		$(this).text("로그아웃 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("LOGOUT").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#userInfo font").hover(function() {
		$(this).text("회원정보 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("USER INFO").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#boardList font").hover(function() {
		$(this).text("자유게시판 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("FREE BOARD").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#artInfo font").hover(function() {
		$(this).text("앨범목록 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("ALBUM LIST").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#concertInfo font").hover(function() {
		$(this).text("공연정보 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("CONCERT INFO").css("font-family","prstart").css("font-size","1rem");
	});
	
	$("#player font").hover(function() {
		$(this).text("플레이어 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("PLAYER").css("font-family","prstart").css("font-size","1rem");
	});
	$("#payInfo font").hover(function() {
		$(this).text("결제정보 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("PAY INFO").css("font-family","prstart").css("font-size","1rem");
	});
	$("#teamInput font").hover(function() {
		$(this).text("팀생성 및 가입 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("TEAM INPUT").css("font-family","prstart").css("font-size","1rem");
	});
	$("#teamInfo font").hover(function() {
		$(this).text("팀정보 ◀").css("font-family","dgm").css("font-size","1.5rem");
	},function(){
		$(this).text("TEAM INFO").css("font-family","prstart").css("font-size","1rem");
	});
});
</script>
    
<div class="col-md-2">
	<div class="sidebar" style="position:fixed;background-color:rgba(0,0,0,0.7);width:100%;height:100%;">
		<aside id="sidebar">
			<section id="home">
				<a href="/indiefes/">
					<font>InDiEFeS</font>
				</a>
			</section>
			
			
			
			<c:choose>
			 
			    <c:when test="${userInfoVo eq null}">
			        <section id="login">
					<a href="/indiefes/user/login">
						<font>LOGIN</font>
					</a>
					</section>
			    </c:when>
			 
			   	 
			    <c:otherwise>
			        <section id="logout">
			        <script type="text/javascript">
						function closePlayer() {
							var new_popup = window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
							new_popup.close();
						}
					</script>
					<a href="/indiefes/user/logout" onclick="closePlayer();">
						<font>LOGOUT</font>
					</a>
					</section>
					
					<section id="userInfo">
					<a href="/indiefes/user/user-info-pwinput">
						<font>USER INFO</font>
					</a>
					</section>
					
					<section id="payInfo">
					<a href="/indiefes/art/pay_info">
						<font>PAY INFO</font>
					</a>
					</section>
					<c:choose>
				    	<c:when test="${indieNum eq null}">
							<section id="teamInput">
							<a href="/indiefes/art/indie_team_input">
								<font>TEAM INPUT</font>
							</a>
							</section>
						</c:when>
						<c:otherwise>
							<section id="teamInfo">
							<a href="/indiefes/art/indie_team_info?team_number=${indieNum}">
								<font>TEAM INFO</font>
							</a>
							</section>
						</c:otherwise>
					</c:choose>
					<section id="player">
				    <script type="text/javascript">
						function musicPlayer() {
							var new_popup = window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
						}
					</script>
			    	<a href="#" onclick="musicPlayer();" class="N=a:lml.player"><font>PLAYER</font></a>
		    		</section>
			    </c:otherwise>
			 
			</c:choose>
					
		    <section id="boardList">
			    <a href="/indiefes/board/list">
			    	<font>FREE BOARD</font>
			    </a>
		    </section>
		    <section id="artInfo">
			    <a href="/indiefes/art/art_list">
			    	<font>ALBUM LIST</font>
			    </a>
		    </section>
		    <section id="concertInfo">
			    <a href="/indiefes/concert/info">
			    	<font>CONCERT INFO</font>
			    </a>
		    </section>
		</aside>
	</div>
</div> <!-- col-md-2 / sidebar -->