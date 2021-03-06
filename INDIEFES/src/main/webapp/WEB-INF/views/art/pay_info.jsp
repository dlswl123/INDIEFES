<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>  

<style>
div{
	font-family: prstart,dgm;
	src: url("../fonts/DungGeunMo.ttf") format("truetype");
	color : #00ff00;
	font-style: normal;
	font-weight: normal;	
}
input{
	background-color:rgba(0,0,0,0.5);
	color : #00ff00;
}
button{
	background-color:rgba(0,0,0,0.5);
	color : #00ff00;
}
</style>

<script>
$(document).ready(function() {
	var pay = $("h5").length;
	var price = pay*100;
	$("input[name=price]").val(price);
	// 결제버튼
	$("#btnPay").click(function() {
		var result = confirm("결제 하시겠습니까?");
	    if(result){
		location.href="/indiefes/art/pay_ok";
		alert("결제 되었습니다.");
	    }else{
		alert("결제가 취소 되었습니다.");
	    }
	});
	// 삭제버튼
	$("button").click(function(){
		var music_number = $(this).attr("data-music_number");
		var music_title = $(this).attr("data-music_title");
		location.href="/indiefes/art/payDelete?music_number="+music_number;
		alert(music_title+" 목록에서 삭제됩니다.");
		
	});
});
</script>
	<style>
	#logo font {
		font-family: blox;
		font-size: 3.5rem;
		margin-left: 30px;
		color: #292929;
	}
	#logo {
		color: #292929;	
	 	text-shadow: 1px 1px 0px lightgrey;
	}
	</style>
		<div class="col-md-10">
		<section id="logo" style="padding:20px;width:100%;">
		<div class="row">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;color:#292929;">
			결제정보</span>
		</div>
		</section><hr>
			<div class="row" style="background-color:#292929;">
				<div class="col-md-10">
					<h3>PAY LIST</h3><br>
					<c:forEach items="${payList}" var="payVo">
						<c:if test="${payVo.pay_ok == 0}"><h5>${payVo.music_title} ◀<button data-music_number="${payVo.music_number}" data-music_title="${payVo.music_title}" id="#">삭제</button></h5><br></c:if>
					</c:forEach>
				</div>
				<div class="col-md-10">
					결제금액 : <input name=price type="text" value="" readonly>
					<input id="btnPay" type="button" value="결제하기">
				</div>
			</div>
</div>
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>