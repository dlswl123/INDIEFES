<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Music</title>

    <!-- add styles and scripts -->
    <link href="<c:url value ='/resources/css/styles.css'/>" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<c:url value ='/resources/js/jquery-1.7.2.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value ='/resources/js/musicplayer.js'/>"></script>
    <!-- Add the slick-theme.css if you want default styling -->

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css" />
    <!-- Add the slick-theme.css if you want default styling -->

</head>

<body>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>

    <div class="MusicPlayer">
        <ul class="playlist">
            <li data-cover="" data-artist="test1">
            	<a href="">music-name</a>
            </li>
        </ul>
    </div>

    <script>

        $(".MusicPlayer").musicPlayer({
//             volume: 50,
//             elements: ['artwork', 'controls', 'progress', 'time', 'volume'],
//             playerAbovePlaylist: false,
            autoPlay: true,
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