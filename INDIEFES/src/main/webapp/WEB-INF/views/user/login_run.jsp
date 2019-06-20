<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style-ks.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 성공</h1>
	${userInfoVo}<br>
	${userInfoVo.user_id}<br>
	${userInfoVo.user_nick}
	
	<div class="row">
	
		
		<div class="col-md-3">
		
		</div>
		<div class="col-md-6">
			<table class="table">
				<tbody>
				<thead>
					<tr>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>배송비</th>
						<th>주문금액</th>
						<th>주문상태</th>
					</tr>
				</thead>
					
					<tr>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
						<td></td>
					</tr>
				
				</tbody>
			</table>
		</div>
		<div class="col-md-3">
		</div>
	</div>
</body>
</html>