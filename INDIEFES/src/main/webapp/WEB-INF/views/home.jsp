<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Indiefes</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	
<style>
html {
	background: url(/resources/bg_images/homebg.jpg) no-repeat center center fixed;
	-webkit-background-size: cover;
  	-moz-background-size: cover;
  	-o-background-size: cover;
  	background-size: cover;
}

body, html {
  height: 100%;
}
</style>
</head>

<body>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10" style="background-color:#ff8888;">
			<div>
				<h1>
					Hello world!  
				</h1>
				
				<P>  The time on the server is ${serverTime}. </P>
				<section style="background-color:#88ffff;">
					section
					<article style="background-color:#ff88ff;">
						<h1>article</h1>
					</article>
					section
				</section>
				
				<article style="background-color:#ff88ff;">
					<h1>article</h1>
				</article>
			</div>
		</div> <!-- col-md-10 / main -->
		
		<div class="col-md-2">
			<div class="sidebar" style="position:fixed;background-color:#ffff88;width:100%;height:100%;">
				<aside id="sidebar">
					<section id="signin"><h1>로그인폼</h1></section>
				    <section id="boardList"><h1><a herf="/indiefes/board/list">자유게시판</a></h1></section>
				    <section id="widget_2"><h1>링크2</h1></section>
				    <section id="widget_3"><h1>링크3</h1></section>
				    <section id="player"><h1>플레이어</h1></section>
				</aside>
			</div>
		</div> <!-- col-md-2 / sidebar -->
	</div> <!-- row -->
</div> <!-- container-fluid -->

</body>

</html>
