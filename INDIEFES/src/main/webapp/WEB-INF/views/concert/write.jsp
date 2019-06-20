<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	// move to new concert info write form
	$("#btnConfirm").click(function() {
		location.href = "/indiefes/concert/write";
	});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 정보 등록</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			<form>
				<div class="form-group">
					<label id="subject">공연제목</label>
					<input type="text" class="form-control" name="subject" id="subject" />
					
					<label id="content">공연내용</label>
					<textarea class="form-control" rows="10" cols="50" name="content" id="subject"
					style="resize:none;">
					</textarea>
					
					<label id="map">지도</label>
					<div id="map" style="width:100%;height:500px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=913777d8d62e9dada9a5b7e3656cdba2"></script>
					<script>
						var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
						var options = { //지도를 생성할 때 필요한 기본 옵션
							center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
							level: 3 //지도의 레벨(확대, 축소 정도)
						};
					
						var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
					</script>
				</div>
			</form>		
		</article>
	
		<div class="row">
			<article style="text-align:right;padding:20px;">
				<input type="button" class="btn btn-primary" value="등록" id="btnConfirm" />
			</article>
		</div> <!-- row -->
		
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>