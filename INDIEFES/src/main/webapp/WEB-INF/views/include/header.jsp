<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Indiefes</title>
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	<!-- 아이콘 -->
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<!-- 아이콘 끝 -->
  	
	 <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	
<style>
body {
/* 	background: url("${pageContext.request.contextPath}/resources/bg_images/bgpage.jpg") no-repeat center center fixed; */
	background: url("<c:url value='/resources/bg_images/bgpage.jpg'/>") no-repeat center center fixed;
	-webkit-background-size: cover;
  	-moz-background-size: cover;
  	-o-background-size: cover;
  	background-size: cover;
  	font-family: 스웨거 TTF;
/*   	font-family: Ghang, Misdemeanor,Urban Jungle,FuturaBlack BT,Yj SHANALL,Yj WADAG; */
}
aside{
font-family: 영남일보체;
}
/* /resources 내의 자료 불러와지지 않을 때 사용법
<script src="<c:url value='~~~주소~~~'/>"/>
*/

html, body {
	-ms-user-select:none;
	-webkit-user-select:none;
	-moz-user-select:-moz-none;
	user-select:none;
}
</style>

</head>

<body oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>

<div class="container-fluid">
	<div class="row">
