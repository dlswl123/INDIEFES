<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Music</title>

    <!-- 스타일 스크립트 -->
    <link href="<c:url value ='/resources/css/styles.css'/>" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<c:url value ='/resources/js/jquery-1.7.2.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value ='/resources/js/musicplayer.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value ='/resources/css/slick.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value ='/resources/css/slick-theme.min.css'/>"/>

</head>

<body>
    <script type="text/javascript" src="<c:url value ='/resources/css/slick.min.jss'/>"></script>

    <div class="MusicPlayer">
        <ul class="playlist">
        <c:forEach items="${playList}" var="playList">
	            <li data-cover="" data-artist="${playList.team_name}">
<%-- 	            	<a href="http:${playList.file_path}">${playList.music_title}</a> --%>
	            	<a href="/indiefes/player/Song?file_path=${playList.file_path}&team_number=${playList.team_number}&art_number=${playList.art_number}">${playList.music_title}</a>
	            </li>
		</c:forEach>
        </ul>
    </div>

    <script>

        $(".MusicPlayer").musicPlayer({
//             volume: 50,
//             elements: ['artwork', 'controls', 'progress', 'time', 'volume'],
//             playerAbovePlaylist: false,
            autoPlay: true,
            preload: true,
            loop: true,
            onLoad: function () {
//                 Add Audio player
                plElem = "<div class='pl'></div>";
                $('.MusicPlayer').find('.player').append(plElem);
//                 show playlist
                $('.pl').click(function (e) {
                    e.preventDefault();
                    $('.MusicPlayer').find('.playlist').toggleClass("hidden");
                });
            },

        });

    </script>

</body>
</html>