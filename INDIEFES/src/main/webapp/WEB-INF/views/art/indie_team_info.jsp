<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>  

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
	
	
});
</script>
		<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
			<div class="row">
				<h1>팀정보</h1><br><br><br>
			</div>
			<div class="row">
				<div class="col-md-10">
					<h3>${teamName}</h3><br>
					<c:forEach items="${memberList}" var="memberVo">
						<c:if test="${memberVo.team_level==0}"><strong>${memberVo.user_nick}</strong><br></c:if>
						<c:if test="${memberVo.team_level==1}"><small>${memberVo.user_nick}</small><br></c:if>
					</c:forEach>
				</div>
			</div>
	<div class="row">
		<div class="col-md-12">
			 <span class="badge badge-default">앨범 목록</span>
			<div class="row">
				<ul  class="albumList">
				<li>
					<c:forEach items="${teamArtList}" var="artVo">
					<li class="art_info">
						<figure class="albumInfo">
							<div class="thumbnail">
								<p class="badge"></p>
								<a href="//indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" onclick="" target="_self">
								<span class="mask"></span>
								<img id="img_art_cover"class="art_images" src="/indiefes/art/getCover?artCover=${artVo.art_cover}&team_number=${artVo.team_number}&art_number=${artVo.art_number}" alt="${artVo.art_title} 앨범 대표이미지">
								</a>
							</div>
							<figcaption class="info">
								<a href="/indiefes/art/art_info/${artVo.art_number }/${artVo.team_number}" class="albumTitle" title="artInfoVo.art_title" onclick="" target="_self">${artVo.art_title}</a>
								<div class="subInfo">
								<p class="artist">
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
		</div>
	</div>
</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>