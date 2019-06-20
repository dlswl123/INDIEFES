<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

  <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>

<body>

  <div class="container-fluid">
  	
	<div class="row" style="margin-top:75px">
		<div class="col-md-4">
		</div>
		<div class="col-md-4">
			<form role="form" action="/user/login-run" method="post">
				<div class="form-group">
					 
					<label for="user_id">
						아이디
					</label>
					<input type="text" class="form-control" name="user_id" id="user_id" />
				</div>
				<div class="form-group">
					 
					<label for="user_pw">
						비밀번호
					</label>
					<input type="password" class="form-control" name="user_pw" id="user_pw" />
				</div>
				
<!-- 				<div class="checkbox"> -->
					 
<!-- 					<label> -->
<!-- 						<input type="checkbox" /> Check me out -->
<!-- 					</label> -->
<!-- 				</div>  -->
				<button type="submit" class="btn btn-primary">
					로그인
				</button>
			</form>
		</div>
		<div class="col-md-4">
		</div>
	</div>
</div>

  

</body>

</html>