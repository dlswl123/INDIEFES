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
     margin: 20 26 20 26;
     float: left;
     box-shadow: 0px 5px 5px 2px grey;
    }
    
/*     한줄라인 글자수 제한 */
    .info{
      width:150px;
      padding:0 2px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
.breadcrumb{
	background-color: #292929;
}
.breadcrumb a{
	font-family: dgm;
	font-size: 1rem;
	color: #00ff00;
}
</style>
<script>
$(document).ready(function() {
	// 검색버튼
	$("#btnSearch").click(function(){
		setPage();
		setSearch();
		$("input[name=page]").val(1); // 검색시 페이지1로가기
		$("#pageForm").submit();
	});
	
	// 전체조회버튼
	$("#btnAllSearch").click(function(){
		setPage();
		$("input[name=searchType]").val("");
		$("input[name=keyword]").val("");
		$("input[name=page]").val(1); // 검색시 페이지1로가기
		$("#pageForm").submit();
	});
	
	// 장르이동
	$(".art_genre").click(function(e){
		e.preventDefault();
		setPage();
		var genre = $(this).attr("data-genre");
// 		console.log(genre);
		if (genre == "appro") {
			$("input[name=searchType]").val("appro");
			$("input[name=keyword]").val(2);
		} else if (genre == "working") {
			$("input[name=searchType]").val("working");
			$("input[name=keyword]").val(0);
		} else if (genre == "delete") {
			$("input[name=searchType]").val("delete");
			$("input[name=keyword]").val(99);
		} else {
			$("input[name=searchType]").val("artGenre");
			$("input[name=keyword]").val(genre);
		}
		$("#pageForm").submit(); // 폼 설정
	});
	
	// 페이지
	function setPage() {
		var page = "${pagingDto.page}"
			if (page == "") {
				page = 1;
		}
		$("input[name=page]").val(page);
// 		$("input[name=perPage]").val(perPage);
	}

	
	// 검색
	function setSearch() {
		var searchType = $("#searchType").val();
		var keyword = $("#keyword").val();
// 		console.log("searchType:" + searchType);
// 		console.log("keyword:" + keyword);
		$("input[name=searchType]").val(searchType);
		$("input[name=keyword]").val(keyword);
	}
	
	// 페이지 번호클릭
	$(".a_pagination").click(function(e){
			e.preventDefault();
//			$(this).text();
			setPage();
			
			var page = $(this).attr("data-page"); // 페이지 숫자 읽기
// 			console.log(page);
			$("input[name=page]").val(page); // 아래쪽 폼의 page에 설정
			$("#pageForm").submit(); // 폼 설정

			
	}); // $(".a_pagination").click
	
	

});

</script>

<form id="pageForm" action="/indiefes/art/art_list">
<!-- 	<input type="hidden" name="perPage"  -->
<%-- 		value="${paginationDto.pagingDto.perPage}"> --%>
	<input type="hidden" name="page" 
			value="${paginationDto.pagingDto.page}">
	<input type="hidden" name="searchType" 
		value="${paginationDto.pagingDto.searchType}">
	<input type="hidden" name="keyword" 
		value="${paginationDto.pagingDto.keyword}">
</form>

<div class="col-md-10">
  <div class="row">
<!--   상단 장르 선택부 -->
		<div class="col-md-12">
			 <span class="badge badge-default">장르</span>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/indiefes/" >Home</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="발라드" 
						<c:if test="${paginationDto.pagingDto.keyword == '발라드'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>발라드</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="댄스"
						<c:if test="${paginationDto.pagingDto.keyword == '댄스'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>댄스</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="랩/힙합"
						<c:if test="${paginationDto.pagingDto.keyword == '랩/힙합'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>랩/힙합</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="R&B/Soul"
						<c:if test="${paginationDto.pagingDto.keyword == 'R&B/Soul'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>R&B/Soul</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="재즈"
						<c:if test="${paginationDto.pagingDto.keyword == '재즈'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>재즈</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="록/메탈"
						<c:if test="${paginationDto.pagingDto.keyword == '록/메탈'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>록/메탈</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="포크/블루스" 
						<c:if test="${paginationDto.pagingDto.keyword == '포크/블루스'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>포크/블루스</a>
					</li>
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="기타"
						<c:if test="${paginationDto.pagingDto.keyword == '기타'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>기타</a>
					</li>
					<c:if test="${userInfoVo.user_level eq 2 }">
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_info_input">앨범등록</a>
					</li>
					</c:if>
					<c:if test="${userInfoVo.user_level eq 0 or userInfoVo.user_level eq 1}">
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="appro"
						<c:if test="${paginationDto.pagingDto.searchType == 'appro'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>승인대기</a>
					</li>
					</c:if>
					<c:if test="${userInfoVo.user_level eq 0 or userInfoVo.user_level eq 1}">
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="delete"
						<c:if test="${paginationDto.pagingDto.searchType == 'delete'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>삭제된 앨범</a>
					</li>
					</c:if>
					<c:if test="${userInfoVo.user_level eq 2}">
					<li class="breadcrumb-item">
						<a href="/indiefes/art/art_list" class="art_genre" data-genre="working"
						<c:if test="${paginationDto.pagingDto.searchType == 'working'}">
							style="text-decoration: underline; color: yellow;"
						</c:if>>작업중인 앨범</a>
					</li>
					</c:if>
				</ol>
			</nav>
		</div>
<!-- 		장르 선택 끝 -->
	</div>
	<div class="row">
<!-- 	검색  -->
<%-- likeCount : ${likeCount} --%>
		<div class ="col-md-12">
			<div class="in-line">
				 <select class="selectBox" id="searchType">
					<option value="albumName" <c:if test="${paginationDto.pagingDto.searchType == 'albumName'}">
								selected
								</c:if>>앨범제목</option>
					<option value="song" <c:if test="${paginationDto.pagingDto.searchType == 'song'}">
								selected
								</c:if>>노래제목</option>
					<option value="indieTeam" <c:if test="${paginationDto.pagingDto.searchType == 'indieTeam'}">
								selected
								</c:if>>가수명</option>
				</select>
				<input type="text" id="keyword" 
				<c:choose>
					<c:when test="${paginationDto.pagingDto.searchType == 'artGenre' or paginationDto.pagingDto.searchType == 'appro' or paginationDto.pagingDto.searchType == 'working' or paginationDto.pagingDto.searchType == 'delete'}">
						value=""
					</c:when>
					<c:otherwise>
						value="${paginationDto.pagingDto.keyword}"
					</c:otherwise>
				</c:choose>>
				<input type="button" class="btn btn-primary" id="btnSearch" value="검색">
				<input type="button" class="btn btn-warning" id="btnAllSearch" value="전체조회">
			</div>
		</div>
<!-- 		검색 끝 -->
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<div class="row">
<!-- 			앨범 리스트 -->
				<ul  class="albumList">
<!-- 				<li> -->
			<c:choose>
				<c:when test="${not empty artList}">
					<c:forEach items="${artList}" var="artVo">
					<c:if test="${(artVo.upload_check eq 1)or(artVo.upload_check eq 2 and paginationDto.pagingDto.searchType eq 'appro')or(artVo.upload_check eq 0 and paginationDto.pagingDto.searchType eq 'working' and userVo.user_id eq artVo.user_id)or(artVo.upload_check eq 99 and paginationDto.pagingDto.searchType eq 'delete')}">
					<li class="art_info">
						<figure class="albumInfo">
							<div class="thumbnail">
								<p class="badge"></p>
								<a href="/indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" onclick="" target="_self">
								<span class="mask"></span>
								<img id="img_art_cover"class="art_images" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" alt="${artVo.art_title} 앨범 대표이미지">
								</a>
<!-- 								<button onclick="" class="btnPlay" aria-label="새창">듣기</button> -->
							</div>
							<figcaption class="info" style="padding-left: 10px; padding-top: 10px;">
								<a href="/indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" class="albumTitle" title="artInfoVo.art_title" onclick="" target="_self">${artVo.art_title}</a>
								<div class="subInfo">
<!-- 								<p class="artist"> -->
								<c:forEach items="${teamList}" var="teamList">
								<c:if test="${artVo.team_number == teamList.team_number}">
									<a href="/indiefes/art/indie_team_info?team_number=${teamList.team_number}" class="artistTitle" title="${teamList.art_team}" onclick="" target="_self">${teamList.art_team}</a>
								</c:if>
								</c:forEach>
								<br>
								<time datetime="">${artVo.reg_art}</time><br>
<!-- 								좋아요 체크 -->
								<c:set var="flag" value="0" />
								<c:if test="${userVo != null}">
									<c:forEach items="${likeCount}" var="likeCount">
										<c:if test="${artVo.art_number == likeCount.art_number}">
											<c:set var="flag" value="1" />
										</c:if>
									</c:forEach>
								</c:if>
								<c:choose>
									<c:when test="${flag == 1}">
										<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="text-align: center;"><i class="fas fa-heart" style="font-size: 20px; color: red;" id="iconLiked"></i></span>
									</c:when>
									<c:otherwise>
										<span class="spLikedCount icon" data-art_number="${artVo.art_number}" style="text-align: center;"><i class="far fa-heart" style="font-size: 20px; color: red;" id="iconLiked"></i></span>
									</c:otherwise>
								</c:choose>
<!-- 								좋아요 체크 끝 -->
<!-- 								좋아요 count 수 -->
								<c:choose>
									<c:when test="${artVo.liked_count != 0 }">
										<span id="artLikedCountSpan">${artVo.liked_count }</span>
									</c:when>
									<c:otherwise>
										<span>&nbsp;&nbsp;</span>
									</c:otherwise>
								</c:choose>
<!-- 								좋아요 count 수 끝 -->
								
<!-- 								추천수 체크 -->
								<c:set var="flag" value="0" />
								<c:if test="${userVo != null}">
									<c:forEach items="${goodCount}" var="goodCount">
										<c:if test="${artVo.art_number == goodCount.art_number}">
											<c:set var="flag" value="1" />
										</c:if>
									</c:forEach>
								</c:if>
								<c:choose>
									<c:when test="${flag == 1}">
										<span class="spGoodCount icon" data-art_number="${artVo.art_number}" style="text-align: center;"><i class="fas fa-thumbs-up" style="font-size: 20px; color: green;" id="iconGood"></i></span>
									</c:when>
									<c:otherwise>
										<span class="spGoodCount icon" data-art_number="${artVo.art_number}" style="text-align: center;"><i class="far fa-thumbs-up" style="font-size: 20px; color: green;" id="iconGood"></i></span>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${artVo.good_count != 0 }">
										<span id="artGoodCountSpan">${artVo.good_count }</span>
									</c:when>
									<c:otherwise>
										<span>&nbsp;&nbsp;</span>
									</c:otherwise>
								</c:choose>
<!-- 								</p> -->
								</div>
							</figcaption>
						</figure>
					</li>
					</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<span>검색결과가 존재하지 않습니다.</span>
				</c:otherwise>
			</c:choose>
<!-- 				</li> -->
				</ul>
<!-- 				앨범리스트 끝 -->
			</div>
			<div class="row">
				<div class="col-md-12">
					<nav>
						<ul class="pagination" >
						<!-- 이전 -->
						<c:if test="${paginationDto.prev == true }">
							<li class="page-item">
								<a class="page-link a_pagination" href="#"
									data-page="${paginationDto.startPage - 1}">이전</a>
							</li>
						</c:if>	
						<!-- 페이징 -->
						<c:forEach var="i" begin="${paginationDto.startPage}" 
											end="${paginationDto.endPage }">
							<li class="page-item
							<c:if test="${paginationDto.pagingDto.page == i}">active</c:if>	
							">
								<a class="page-link a_pagination" href="#"
									data-page="${i}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${paginationDto.next == true }">
							<li class="page-item">
								<a class="page-link a_pagination"  href="#"
								data-page="${paginationDto.endPage +1}">다음</a>
							</li>		
						</c:if>		
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>