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
.sidebar #login, #logout, #userInfo, #boardList, #artInfo, #concertInfo, #player font {
	font-family: prstart;
}
.sidebar #home {
	padding:20px;
}
.sidebar section {
	padding-left:20px;
}
</style>
    
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
						<font style="font-family:bom;">LOGIN</font>
					</a>
					</section>
			    </c:when>
			 
			   	 
			    <c:otherwise>
			        <section id="logout">
					<a href="/indiefes/user/logout">
						<font>LOGOUT</font>
					</a>
					</section>
					
					<section id="userInfo">
					<a href="/indiefes/user/user-info-pwinput">
						<font>USER INFO</font>
					</a>
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
		    <section id="player">
			    <script type="text/javascript">
					function musicPlayer() {
						window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
					}
				</script>
		    	<a href="#" onclick="musicPlayer();" class="N=a:lml.player"><font>PLAYER</font></a>
		    </section>
		</aside>
	</div>
</div> <!-- col-md-2 / sidebar -->