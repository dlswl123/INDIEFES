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
     margin: 10 39 10 39;
     position: relative;
     box-shadow: 0px 5px 5px 2px grey;
    }
/*     한줄라인 글자수 제한 */
    .info{
      width:150px;
      font-family: dgm;
	  padding-left: 10px;
	  padding-top: 10px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
    .art1, .art2 {
    overflow-x: hidden;
    overflow-y: auto;
    white-space:nowrap;
    width: 95%;
    height: 600px;
    background-color:rgba(255,255,255);
    margin: auto;
    -ms-overflow-style: none;
    }
    .pagination{
    margin: 0 50;
    }
    .Count{
    position: absolute;
	top: 0%;
	right: 0%;
	color: #00ff00;
	background-color:rgba(0,0,0);
    }
    ::-webkit-scrollbar {
	display:none;
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
