<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<ul  class="albumList">
		<c:set var="count" value="0"/>
		<c:forEach items="${goodList}" var="artVo">
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
						<p>${count = count+1}위</p>
				</figure>
			</li>
		</c:forEach>
	</ul>
</div>