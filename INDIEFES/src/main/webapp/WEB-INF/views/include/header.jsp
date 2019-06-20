<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Indiefes</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	<!-- 아이콘 -->
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  	<script src="https://kit.fontawesome.com/9d5a98c207.js"></script>
  	<!-- 아이콘 끝 -->
	
<style>
body {
/* 	background: url("${pageContext.request.contextPath}/resources/bg_images/bgpage.jpg") no-repeat center center fixed; */
	background: url("<c:url value='/resources/bg_images/bgpage.jpg'/>") no-repeat center center fixed;
	-webkit-background-size: cover;
  	-moz-background-size: cover;
  	-o-background-size: cover;
  	background-size: cover;
}
/* /resources 내의 자료 불러와지지 않을 때 사용법
<script src="<c:url value='~~~주소~~~'/>"/>
*/
</style>
</head>

<body>

<div class="container-fluid">
	<div class="row">
