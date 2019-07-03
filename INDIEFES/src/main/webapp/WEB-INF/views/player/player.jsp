<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Music</title>
    
    <!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- 스타일 스크립트 -->
    <link href="<c:url value ='/resources/css/styles.css'/>" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<c:url value ='/resources/js/jquery-1.7.2.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value ='/resources/js/musicplayer.js'/>"></script>
</head>
<body>
<script>
function allowDrop(ev) {
	  ev.preventDefault();
	}

	function drag(ev) {
	  ev.dataTransfer.setData("playIndex", ev.target.id);
	}

	function drop(ev) {
	  ev.preventDefault();
	  var data = ev.dataTransfer.getData("playIndex");
		if (data!=null) {
			location.href="/indiefes/player/playDelete?play_index="+data;
		}
	}
</script>
    <div ondrop="drop(event)" ondragover="allowDrop(event)" style=" width: 100%; height: 0px; text-align: center;">
      	<img src=" <c:url value ='/resources/images/Delete.png'/>" alt="삭제이미지" style="width: 50px; height: 50px;"/>
    </div>
    <div class="MusicPlayer">
        <ul class="playlist">
        	<c:forEach items="${playList}" var="playList">
	            <li data-cover="" data-artist="${playList.team_name}">
	            	<a href="/indiefes/player/Song?file_path=${playList.file_path}&team_number=${playList.team_number}&art_number=${playList.art_number}" draggable="true" ondragstart="drag(event)" id="${playList.play_index}">${playList.music_title}</a>
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
            loop: true,
            readState : true,
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