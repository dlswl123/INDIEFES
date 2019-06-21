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
     margin: 5 5 5 5;
     float: left;
    }
</style>

<div class="col-md-10" style="background-color:rgba(255,255,255,0.7);">
  <div class="row">
		<div class="col-md-12">
			 <span class="badge badge-default">장르</span>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="#">Home</a>
					</li>
					<li class="breadcrumb-item">
						<a href="#">Library</a>
					</li>
					<li class="breadcrumb-item active">
						Data
					</li>
				</ol>
			</nav>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			 <span class="badge badge-default">앨범 목록</span>
			<div class="row">
				<ul  class="albumList">
				<li>
					<c:forEach items="${artList}" var="artInfoVo">
					<li class="art_info">
						<figure class="albumInfo">
							<div class="thumbnail">
								<p class="badge"></p>
								<a href="/indiefes/art/art_info" onclick="" target="_self">
								<span class="mask"></span>
								<img class="art_images" src="../resources/images/Koala.jpg" onerror="bugs.utils.imgError(this);" alt="포장마차 앨범 대표이미지">
								</a>
<!-- 								<button onclick="" class="btnPlay" aria-label="새창">듣기</button> -->
							</div>
							<figcaption class="info">
								<a href="/indiefes/art/art_info" class="albumTitle" title="artInfoVo.art_title" onclick="" target="_self">${artInfoVo.art_title}</a>
								<div class="subInfo">
								<p class="artist">
								<c:forEach items="${teamList}" var="teamList">
								<c:if test="${artInfoVo.team_number == teamList.team_number}">
								<a href="https://music.bugs.co.kr/artist/20041592?wl_ref=list_ab_04" class="artistTitle" title="${teamList.art_team}" onclick="" target="_self">${teamList.art_team}</a>
								</c:if>
								</c:forEach>
								<br>
								<time datetime="">${artInfoVo.reg_art}</time>
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