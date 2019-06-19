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
			<section id="login">
				<h1><a href="/indiefes/user/login">
					<font style="color:#ffffff;">로그인폼</font>
				</a></h1>
			</section>
		    <section id="boardList">
			    <h1><a href="/indiefes/board/list">
			    	<font style="color:#ffffff;">자유게시판</font>
			    </a></h1>
		    </section>
		    <section id="artInfo">
			    <h1><a href="/indiefes/art/art_info">
			    	<font style="color:#ffffff;">앨범정보</font>
			    </a></h1>
		    </section>
		    <section id="widget_3">
			    <h1>
			    	<font style="color:#ffffff;">링크3</font>
			    </h1>
		    </section>
		    <section id="player">
			    <h1>
			    	<font style="color:#ffffff;">플레이어</font>
			    </h1>
		    </section>
		</aside>
	</div>
</div> <!-- col-md-2 / sidebar -->