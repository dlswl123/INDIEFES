<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<div class="col-md-2">
	<div class="sidebar" style="position:fixed;background-color:rgba(0,0,0,0.7);width:100%;height:100%;">
		<aside id="sidebar">
			<section id="home">
				<h1><a href="/indiefes/">
					<font style="color:#ffffff;">INDIEFES</font>
				</a></h1>
			</section>
			
			
			
			<c:choose>
			 
			    <c:when test="${userInfoVo eq null}">
			        <section id="login">
					<h1><a href="/indiefes/user/login">
						<font style="color:#ffffff;">로그인</font>
					</a></h1>
					</section>
			    </c:when>
			 
			   	 
			    <c:otherwise>
			        <section id="login">
					<h1><a href="/indiefes/user/logout">
						<font style="color:#ffffff;">로그아웃</font>
					</a></h1>
					</section>
					
					<section id="userInfo">
					<h1><a href="/indiefes/user/user-info-pwinput">
						<font style="color:#ffffff;">회원정보</font>
					</a></h1>
					</section>
					
					<section id="player">
			    	<h1>
				    <script type="text/javascript">
						function musicPlayer() {
							window.open("/indiefes/player/player", "regularPaymentAutoDelay", "width=480,height=960,scrollbars=NO,titlebar=no,resizable=no");
						}
					</script>
			    	<a href="#" onclick="musicPlayer();" class="N=a:lml.player"><font style="color:#ffffff;">Player</font></a>
			    	</h1>
		    		</section>
			    </c:otherwise>
			 
			</c:choose>
					
		    <section id="boardList">
			    <h1><a href="/indiefes/board/list">
			    	<font style="color:#ffffff;">자유게시판</font>
			    </a></h1>
		    </section>
		    <section id="artInfo">
			    <h1><a href="/indiefes/art/art_list">
			    	<font style="color:#ffffff;">앨범목록</font>
			    </a></h1>
		    </section>
		    <section id="concertInfo">
			    <h1><a href="/indiefes/concert/info">
			    	<font style="color:#ffffff;">공연정보</font>
			    </a></h1>
		    </section>
		</aside>
	</div>
</div> <!-- col-md-2 / sidebar -->