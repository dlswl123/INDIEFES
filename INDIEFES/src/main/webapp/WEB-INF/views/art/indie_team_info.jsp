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
     margin: 25 26 25 26;
     float: left;
     box-shadow: 0px 5px 5px 2px grey;
    }
/*     한줄라인 글자수 제한 */
    .info{
      width:150px;
      padding-left: 10px;
	  padding-top: 10px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
#member{
	src: url("../fonts/DungGeunMo.ttf") format("truetype");
	color : #00ff00;
	font-style: normal;
	font-weight: normal;
	background-color:#292929;
	margin-bottom: 30px;
}
h1{
	font-size: 3.5rem;
	color : #00ff00;
}
h3{
color : #ffff00;
}
div{
font-family: dgm;
}
#list{
font-size: 1.5em;
color : #00ff00;
}
#logo font {
		font-family: blox;
		font-size: 3.5rem;
		margin-left: 30px;
		color: #292929;
	}
	#logo {
		color: #292929;	
	 	text-shadow: 1px 1px 0px lightgrey;
	}
</style>
<script>
$(document).ready(function() {
	$(this).css("font-family","prstart").css("font-size","1rem");
});
</script>
		<div class="col-md-10">
			<section id="logo" style="padding:20px;width:100%;">
			<div class="row">
				<font>InDiEFeS</font>
				<span style="font-size:1.25rem;font-family:hss;margin-bottom: 10px;margin-top: auto;margin-left: 10px;margin-right: auto;">
				내 팀 정보</span>
			</div>
			</section><hr>
			<div class="row">
				<div class="col-md-10" id="member">
				<h1>${teamName}</h1>
					<c:forEach items="${memberList}" var="memberVo">
						<c:if test="${memberVo.team_level==0}"><h3>${memberVo.user_nick}</h3></c:if>
						<c:if test="${memberVo.team_level==1}">${memberVo.user_nick}&nbsp;&nbsp;</c:if>
					</c:forEach>
				</div>
			</div>
	<div class="row">
		<div class="col-md-12">
			<div class="row" >
				<ul  class="albumList">
					<c:forEach items="${teamArtList}" var="artVo">
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
								<time datetime="">${artVo.reg_art}</time>
								</p>
								</div>
							</figcaption>
						</figure>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>