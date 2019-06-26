<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
 	.thumbnail { 
 		width: 150px; height: 150px 
 	} 
 	.art_images { 
 	    width: 150px; 
 	    height: 150px; 
 	} 
 	ul{
    list-style:none;
    overflow: auto;
    }
    .art_info {
     border: 1px solid;
     margin: 20 20 20 20;
     float: left;
    }
/*     한줄라인 글자수 제한 */
    .info{
      width:150px;
      padding:0 2px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
</style>
<script>
$(document).ready(function() {
// 	$.getJSON("/indiefes/art/getCoverList", function(list) {
// 		console.log("list:" + list);
		
// 		$(list).each(function() {
// 			var fileName = this; // 2019/5/21/0e6348d6-92d6-4f92-98e2-617ce4ba64ff_Chrysanthemum.jpg
// // 			var filePath = "<img src='/upload/displayFile?fileName=" + thumbnailName + "'>"
// 			$("#img_art_cover").attr("src", filePath);
// 		}); // $(list).each
// 	}); // $.getJSON
	
});

</script>

<form id="pageForm" action="/indiefes/art/art_list">
	<input type="hidden" name="art_number" 
		value="${param.art_number}">
	<input type="hidden" name="team_number" 
		value="${param.team_number}">
	<input type="hidden" name="perPage" 
		value="${paginationDto.pagingDto.perPage}">
	<input type="hidden" name="searchType" 
		value="${paginationDto.pagingDto.searchType}">
	<input type="hidden" name="keyword" 
		value="${paginationDto.pagingDto.keyword}">
</form>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
  <div class="row">
		<div class="col-md-12">
			 <span class="badge badge-default">장르</span>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/indiefes/">Home</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list?">발라드</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">댄스</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">랩/힙합</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">R&B/Soul</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">재즈</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">록/메탈</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">포크/블루스</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">기타</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_info_input">앨범등록</a>
					</li>
				</ol>
			</nav>
		</div>
	</div>
	<div class="row">
		<div class ="col-md-12">
			<select id="art_genre">
				<option value="발라드">발라드</option>
				<option value="댄스">댄스</option>
				<option value="랩/힙합">랩/힙합</option>
				<option value="R&B/Soul">R&B/Soul</option>
				<option value="재즈">재즈</option>
				<option value="록/메탈" selected >록/메탈</option>
				<option value="포크/블루스">포크/블루스</option>
				<option value="기타">기타</option>
			</select>
		</div>
	
	</div>
	
	<div class="row">
		<div class="col-md-12">
			 <span class="badge badge-default">앨범 목록</span>
			<div class="row">
				<ul  class="albumList">
				<li>
					<c:forEach items="${artList}" var="artVo">
					<li class="art_info">
						<figure class="albumInfo">
							<div class="thumbnail">
								<p class="badge"></p>
								<a href="/indiefes/art/art_info?art_number=${artVo.art_number }&team_number=${artVo.team_number}" onclick="" target="_self">
								<span class="mask"></span>
								<img id="img_art_cover"class="art_images" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}" alt="${artVo.art_title} 앨범 대표이미지">
								</a>
<!-- 								<button onclick="" class="btnPlay" aria-label="새창">듣기</button> -->
							</div>
							<figcaption class="info">
								<a href="/indiefes/art/art_info?art_number=${artVo.art_number }&team_number=${artVo.team_number}" class="albumTitle" title="artInfoVo.art_title" onclick="" target="_self">${artVo.art_title}</a>
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
					</c:forEach>
				</li>
				</ul>
			</div>
			<div class="row">
				<div class="col-md-12">
					<nav>
						<ul class="pagination">
							<li class="page-item">
								<a class="page-link" href="#">Previous</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">1</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">2</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">3</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">4</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">5</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#">Next</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>