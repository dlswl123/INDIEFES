<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>  

<style>
</style>

<script>
$(document).ready(function() {
	var pay = $("h5").length;
	var price = pay*100;
	$("input[name=price]").val(price);
	console.log(price);
	$("#btnPay").click(function() {
		var result = confirm("결제 하시겠습니까?");
	    if(result){
		alert("600원 결제 되었습니다.");
		location.href="/indiefes/art/pay_ok";
	    }else{
		alert("결제가 취소 되었습니다.");
	    }
	});
});
</script>
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div class="row">
				<h1>결제정보</h1><br><br><br>
			</div>
			<div class="row">
				<div class="col-md-10">
					<h3>장바구니</h3><br>
					<c:forEach items="${payList}" var="payVo">
						<c:if test="${payVo.pay_ok == 0}"><h5>${payVo.music_title}</h5><br></c:if>
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