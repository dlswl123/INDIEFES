<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
	th {
    height: 100px;
	}
 	 .song_name {
    width: 50%;
 	 }
 	 .btn {
 	 border-radius: 12px;
 	 }
	.thumbnail { 
 		width: 150px; height: 150px 
 	} 
 	.art_images { 
 	    width: 150px; 
 	    height: 150px; 
 	}
 	ul{
	list-style:none;
    }
    .art_info {
     float: left;
    }
    .albumInfo {
     border: 1px solid;
     margin: 20 0 0 15;
    }
/*     한줄라인 글자수 제한 */
    .info{
      width:150px;
      padding:0 2px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
    .art1, .art2 {
    overflow: hidden;
    width: 95%;
    height: 350px;
    background-color:rgba(255,255,255);
    margin: auto;
    box-shadow: 0px 5px 5px 5px grey;
    }
    .pagination{
    margin: 0 50;
    }
</style>
<script>
$(document).ready(function() {
	// 페이지
	function setPage() {
		var page = "${pagingDto.page}"
			if (page == "") {
				page = 1;
		}
		$("input[name=page]").val(page);
	}

	
	// 페이지 번호클릭
	$(".a_pagination").click(function(e){
		e.preventDefault();
		setPage();
		var page = $(this).attr("data-page"); // 페이지 숫자 읽기
		$("input[name=page]").val(page); // 아래쪽 폼의 page에 설정
		$("#pageForm").submit(); // 폼 설정

			
	}); // $(".a_pagination").click
});
</script>
<div class="row">
	<ul  class="albumList">
		<c:forEach items="${toDayList}" var="artVo">
		<c:if test="${artVo.upload_check == 1}">
			<li class="art_info">
				<figure class="albumInfo">
					<div class="thumbnail">
						<p class="badge"></p>
						<a href="/indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" onclick="" target="_self">
						<span class="mask"></span>
						<img id="img_art_cover"class="art_images" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" alt="${artVo.art_title} 앨범 대표이미지">
						</a>
					</div>
					<figcaption class="info">
						<a href="/indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" class="albumTitle" title="artInfoVo.art_title" onclick="" target="_self">${artVo.art_title}</a>
							<div class="subInfo">
							<p class="artist">
							<c:forEach items="${teamList}" var="teamList">
							<c:if test="${artVo.team_number == teamList.team_number}">
								<a href="/indiefes/art/indie_team_info?team_number=${teamList.team_number}" class="artistTitle" title="${teamList.art_team}" onclick="" target="_self">${teamList.art_team}</a>
							</c:if>
							</c:forEach>
							<br>
							<time datetime="">${artVo.reg_art}</time>
							</p>
							</div>
					</figcaption>
				</figure>
			</li>
		</c:if>
		</c:forEach>
	</ul>
</div>
<form id="pageForm" action="/indiefes/">
<input type="hidden" name="page"
value="${toDayPaging.pagingDto.page}"/>
</form>
<div class="row">
	<nav>
		<ul class="pagination" >
		<!-- 이전 -->
		<c:if test="${toDayPaging.prev == true }">
			<li class="page-item">
				<a class="page-link a_pagination" href="#"
					data-page="${toDayPaging.startPage - 1}">이전</a>
			</li>
		</c:if>	
		<!-- 페이징 -->
		<c:forEach var="i" begin="${toDayPaging.startPage}" 
							end="${toDayPaging.endPage }">
			<li class="page-item
			<c:if test="${toDayPaging.pagingDto.page == i}">active</c:if>	
		">
				<a class="page-link a_pagination" href="#" data-page="${i}">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${toDayPaging.next == true }">
			<li class="page-item">
				<a class="page-link a_pagination"  href="#" data-page="${toDayPaging.endPage +1}">다음</a>
			</li>		
		</c:if>		
		</ul>
	</nav>
</div>