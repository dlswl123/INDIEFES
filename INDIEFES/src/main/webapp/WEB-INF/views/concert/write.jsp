<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	
	// set input today to show_date
	var today = new Date().toISOString().slice(0,16);
	$("input[id=show_date]").val(today);
	$("input[name=concert_date]").val(today.replace("T", " "));
	
	$("#btnConfirm").click(function() {
		$("#concertWriteForm").submit();
	});
	
	$("input[id=show_date]").on("change", function() {
		var show_date = $("input[id=show_date]").val();
		$("input[id=show_date]").val(show_date);
		
		$("input[name=concert_date]").val(show_date.replace("T", " "));
		console.log($("input[name=concert_date]").val());
	});
	
});
</script>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
	<h1>공연 정보 등록</h1>

	<section style="background-color:rgba(255,255,255,0.7);margin:20px;">
	
		<article style="padding:20px;">
			
			<!-- // move to new concert info write form -->
			<form role="form" action="/indiefes/concert/write" method="post" id="concertWriteForm">
				<div class="form-group">
					<input type="hidden" name="user_id" value="indie1" />
				
					<label id="subject">공연 제목</label>
					<input type="text" class="form-control" name="subject" id="subject" placeholder="공연명을 기입해주세요" value="테스트공연" required/>
					
					<label id="show_date">공연 일자</label>
					<input type="datetime-local" class="form-control" id="show_date" />
					<input type="hidden" name="concert_date" id="concert_date" />
					
					<label id="content">공연 요약 내용</label>
					<input type="text" class="form-control" name="summary" id="summary" placeholder="목록에 보여질 내용을 한줄로 요약해서 기입해주세요" value="테스트공연요약" />
					
					<label id="info_file_path">목록에 보일 홍보 요약 포스터(크기는 1200x300)</label>
					<input type="file" class="form-control" id="info_file_path" name="info_file_path" value="홍보 요약 포스터" />

					<label id="file_path">홍보 포스터</label>
					<input type="file" class="form-control" id="file_path" name="file_path" value="홍보포스터" />
					
					<label id="content">공연 내용</label>
					<textarea class="form-control" rows="10" cols="50" name="content"
					 id="subject" style="resize:none;">! 허위 정보를 입력할 경우 불이익이 발생할 수 있습니다.
장소 : 
설명 :
참여팀 : 
입장료 :
공연날짜 :
주의사항 :
기타 : 
					</textarea>
					
					<%@ include file="../include/search_map.jsp" %>
					
				</div>
				
				<div class="row">
					<article style="text-align:right;padding:20px;">
						<input type="Button" class="btn btn-primary" value="등록" id="btnConfirm"/>
					</article>
				</div> <!-- row -->
				
			</form>		
		</article>
	
	</section>

</div> <!-- col-md-10 -->

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>