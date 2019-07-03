(function($, window, document, undefined) {
  "use strict";
  // 기본값 생성
  var pluginName = "musicPlayer",
    defaults = {
      playlistItemSelector: "li",
      autoPlay: false,
      volume: 77,
      loop: false,
      timeSeparator: " / ",
      playerAbovePlaylist: true,
      infoElements: ["title", "artist"],
      elements: [
        "artwork",
        "information",
        "controls",
        "progress",
        "time",
        "volume"
      ],
      timeElements: ["current", "duration"],
      controlElements: ["backward", "play", "forward", "stop"],
      onLoad: function() {},
      onPlay: function() {},
      onPause: function() {},
      onStop: function() {},
      onFwd: function() {},
      onRew: function() {},
      volumeChanged: function() {},
      seeked: function() {},
      trackClicked: function() {},
      onMute: function() {}
    };

  // 터치 이벤트 설정
  var isTouch = "ontouchstart" in window,
    eStart = isTouch ? "touchstart" : "mousedown",
    eMove = isTouch ? "touchmove" : "mousemove",
    eEnd = isTouch ? "touchend" : "mouseup",
    eCancel = isTouch ? "touchcancel" : "mouseup";

  function Plugin(element, options) {
    this.element = element;
    this.settings = $.extend({}, defaults, options);
    this._defaults = defaults;
    this._name = pluginName;
    this.init();
  }

  $.extend(Plugin.prototype, {
    init: function() {
      var controlInnerElem = "",
        timeInnerElem = "",
        infoElem = "",
        infoInnerElem = "",
        fullPlayerElem = "",
        volumeElem = "",
        progressElem = "",
        artworkElem = "",
        timeElem = "",
        controlElem = "",
        titleElem = "",
        artistElem = "",
        backwardElem = "",
        forwardElem = "",
        stopElem = "",
        playElem = "",
        curTimeElem = "",
        durTimeElem = "",
        timeSeparator = "",
        playerElem = "",
        playerThis = this;

      for (var elemItem in this.settings.elements) {
        // 볼륨 준비함
        if (this.settings.elements[elemItem] == "volume") {
          volumeElem =
            "<div class='volume'><div class='volume-btn' title='Volume'></div><div class=' volume-adjust'><div><div></div></div></div></div>";
          fullPlayerElem += volumeElem;
        }
        // 프로그레스바 준비함
        else if (this.settings.elements[elemItem] == "progress") {
          progressElem =
            "<div class='progressbar'><div class='bar-loaded' ></div><div class='bar-played'></div></div>";
          fullPlayerElem += progressElem;
        }
        // 커버 준비함
        else if (this.settings.elements[elemItem] == "artwork") {
          artworkElem = "<div class='cover'></div>";
          fullPlayerElem += artworkElem;
        }
        // 주어진 순서대로 플레이어가 표시 한 정보를 준비함
        else if (this.settings.elements[elemItem] == "information") {
          $.inArray("title", this.settings.infoElements) != "-1"
            ? (titleElem = "<div class='title'></div>")
            : (titleElem = " ");
          $.inArray("artist", this.settings.infoElements) != "-1"
            ? (artistElem = "<div class='artist'></div>")
            : (artistElem = " ");

          for (var item in this.settings.infoElements) {
            if (this.settings.infoElements[item] == "title") {
              infoInnerElem += titleElem;
            } else if (this.settings.infoElements[item] == "artist") {
              infoInnerElem += artistElem;
            }
          }
          infoElem = "<div class='info' >" + infoInnerElem + "</div>";
          fullPlayerElem += infoElem;
        }
        // 지정된 순서로 시간 준비 (current & Duration)
        else if (this.settings.elements[elemItem] == "time") {
          $.inArray("current", this.settings.timeElements) != "-1"
            ? (curTimeElem = "<div class='time-current'></div>")
            : (curTimeElem = " ");
          $.inArray("duration", this.settings.timeElements) != "-1"
            ? (durTimeElem = "<div class='time-duration'></div>")
            : (durTimeElem = " ");
          timeSeparator =
            "<div class='time-separator'>" +
            this.settings.timeSeparator.replace(/\s/g, "&nbsp;") +
            "</div>";

          for (var item in this.settings.timeElements) {
            if (item == 1) {
              timeInnerElem += timeSeparator;
            }
            if (this.settings.timeElements[item] == "current") {
              timeInnerElem += curTimeElem;
            } else if (this.settings.timeElements[item] == "duration") {
              timeInnerElem += durTimeElem;
            }
          }
          timeElem = "<div class='timeHolder'>" + timeInnerElem + "</div>";
          fullPlayerElem += timeElem;
        }
        // 지정된 순서로 [play, stop, forward or backward] 표시 할 내부 요소를 제어 준비
        else if (this.settings.elements[elemItem] == "controls") {
          $.inArray("backward", this.settings.controlElements) != "-1"
            ? (backwardElem = "<div class='rew'></div>")
            : (backwardElem = " ");
          $.inArray("forward", this.settings.controlElements) != "-1"
            ? (forwardElem = "<div class='fwd'></div>")
            : (forwardElem = " ");
          $.inArray("stop", this.settings.controlElements) != "-1"
            ? (stopElem = "<div class='stop'></div>")
            : (stopElem = " ");
          $.inArray("play", this.settings.controlElements) != "-1"
            ? (playElem = "<div class='play'></div><div class='pause'></div>")
            : (playElem = " ");

          for (var item in this.settings.controlElements) {
            if (this.settings.controlElements[item] == "backward") {
              controlInnerElem += backwardElem;
            } else if (this.settings.controlElements[item] == "play") {
              controlInnerElem += playElem;
            } else if (this.settings.controlElements[item] == "forward") {
              controlInnerElem += forwardElem;
            } else if (this.settings.controlElements[item] == "stop") {
              controlInnerElem += stopElem;
            }
          }
          controlElem = "<div class='controls'>" + controlInnerElem + "</div>";
          fullPlayerElem += controlElem;
        }
      }

      // 준비된 요소를 플레이어 요소에 맞춰 순서대로 추가합니다.
      playerElem = $("<div class='player' >" + fullPlayerElem + "</div>");
      //console.log(this.element);
      if (this.settings.playerAbovePlaylist) {
        $(playerElem).insertBefore($(this.element).find(".playlist"));
      } else {
        $(playerElem).insertAfter($(this.element).find(".playlist"));
      }

      this.playlistItemSelector = this.settings.playlistItemSelector;
      (this.playlistHolder = $(this.element).children(".playlist")),
        (this.playerHolder = $(this.element).children(".player"));
      this.song = "";
      this.theBar = this.playerHolder.find(".progressbar");
      this.barPlayed = this.playerHolder.find(".bar-played");
      this.barLoaded = this.playerHolder.find(".bar-loaded");
      this.timeCurrent = this.playerHolder.find(".time-current");
      this.timeDuration = this.playerHolder.find(".time-duration");
      this.timeSeparator = this.settings.timeSeparator;
      this.volumeInfo = this.playerHolder.find(".volume");
      this.volumeButton = this.playerHolder.find(".volume-btn");
      this.volumeAdjuster = this.playerHolder.find(".volume-adjust" + " > div");
      this.volumeValue = this.settings.volume / 100;
      this.volumeDefault = 0;
      this.trackInfo = this.playerHolder.find(".info");
      //tracker           = playerHolder.find('.progressbar'),
      //volume            = playerHolder.find('.volume'),
      this.coverInfo = this.playerHolder.find(".cover");
      this.controlsInfo = this.playerHolder.find(".controls");
      this.controlPlay = $(this.controlsInfo).find(".play");
      this.controlPause = $(this.controlsInfo).find(".pause");
      this.controlStop = $(this.controlsInfo).find(".stop");
      this.controlFwd = $(this.controlsInfo).find(".fwd");
      this.controlRew = $(this.controlsInfo).find(".rew");
      this.cssClass = {
        playing: "playing",
        mute: "mute"
      };

      // 자바 스크립트를 사용하여 볼륨을 설정할 수 없으므로 볼륨 변경 이벤트가 실행되지 않습니다.
      // 모바일 사파리가 열린 상태에서 사용자가 기기의 볼륨을 변경하더라도 이 이벤트는 시작되지 않습니다.
      // source: https://www.ibm.com/developerworks/library/wa-ioshtml5/
      // IOS 장치의 볼륨 제어 숨기기.
      if (/iPad|iPhone|iPod/.test(navigator.userAgent))
        $(this.volumeInfo).hide();

      // 초기화 - 재생 목록의 첫 번째 요소
      this.initAudio(
        $(this.playlistHolder.find(this.playlistItemSelector + ":first"))
      );

      // 볼륨 설정
      this.song.volume = this.volumeValue;

      // 기본 시간과 현재 및 지속 시간 설정
      this.timeDuration.html("&hellip;");
      this.timeCurrent.text(this.secondsToTime(0));

      // 재생 클릭
      $(this.controlPlay).click(function(e) {
        e.preventDefault();

        playerThis.playAudio();
      });

      // 일시정지 정지 클릭
      $(this.controlPause).click(function(e) {
        e.preventDefault();

        playerThis.stopAudio();

        // issue pause callback
        playerThis.settings.onPause();
      });

      // 다음곡 클릭
      $(this.controlFwd).click(function(e) {
        e.preventDefault();

        playerThis.stopAudio();

        var next = playerThis.getSong(true);

        // 루핑 활성화 : 다음 항목이 없는 경우 재생 목록의 첫 번째 항목을 재생(루핑)
        if (next.length == 0) {
          next = $(playerThis.playlistHolder).find(
            playerThis.playlistItemSelector + ":first"
          );
        }

        playerThis.loadNewSong(next);
        playerThis.playAudio();

        //issue forward callback
        playerThis.settings.onFwd();
      });

      // 이전곡 클릭
      $(this.controlRew).click(function(e) {
        e.preventDefault();

        playerThis.stopAudio();

        var prev = playerThis.getSong(false);

        // 이전 항목이 없는 경우 재생 목록의 마지막 항목 재생(루핑)
        if (prev.length == 0) {
          prev = $(playerThis.playlistHolder).find(
            playerThis.playlistItemSelector + ":last"
          );
        }

        playerThis.loadNewSong(prev);
        playerThis.playAudio();

        //issue backward callback
        playerThis.settings.onRew();
      });

      // 정지 클릭
      $(this.controlStop).click(function(e) {
        e.preventDefault();

        playerThis.stopAudio();
        playerThis.song.currentTime = 0;

        //issue stop callback
        playerThis.settings.onStop();
      });

      // 클릭 한 재생 목록 노래를 재생합니다.
      $(this.playlistHolder)
        .find(this.playlistItemSelector)
        .click(function(e) {
          e.preventDefault();

          playerThis.stopAudio();
          playerThis.loadNewSong($(this));
          playerThis.playAudio();

          //issue track clicked callback
          playerThis.settings.trackClicked();
        });
    },

    secondsToTime: function(secs) {
      var hours = Math.floor(secs / 3600),
        minutes = Math.floor((secs % 3600) / 60),
        seconds = Math.ceil((secs % 3600) % 60);

      return (
        (hours == 0
          ? ""
          : hours > 0 && hours.toString().length < 2
            ? "0" + hours + ":"
            : hours + ":") +
        (minutes.toString().length < 2 ? "0" + minutes : minutes) +
        ":" +
        (seconds.toString().length < 2 ? "0" + seconds : seconds)
      );
    },
    adjustVolume: function(e) {
      var theRealEvent = isTouch ? e.originalEvent.touches[0] : e;
      this.song.volume = Math.abs(
        (theRealEvent.pageX - this.volumeAdjuster.offset().left) /
          this.volumeAdjuster.width()
      );
    },
    adjustCurrentTime: function(e) {
      var theRealEvent = isTouch ? e.originalEvent.touches[0] : e;
      this.song.currentTime = Math.round(
        (this.song.duration *
          (theRealEvent.pageX - this.theBar.offset().left)) /
          this.theBar.width()
      );
    },

    initAudio: function(elem) {
      var url = elem.children("a:first-child").attr("href"),
        title = elem.text(),
        cover = elem.attr("data-cover"),
        artist = elem.attr("data-artist"),
        playerInstance = this;

      // 플레이어에서 노래 제목 설정
      $(this.trackInfo)
        .children(".title")
        .text(title);
      // 플레이어에서 아티스트 이름 설정
      $(this.trackInfo)
        .children(".artist")
        .text(artist);

      // 플레이어의 표지 이미지 설정
      $(this.coverInfo).css("background-image", "url(" + cover + ")");

      this.song = new Audio(url);

      // 강제로드
      this.song.load();

      // 플레이어의 노래 지속 시간 설정
      this.song.addEventListener(
        "loadeddata",
        function() {
          $(playerInstance.timeDuration).html(
            playerInstance.secondsToTime(this.duration)
          );
          $(playerInstance.volumeAdjuster)
            .find("div")
            .width(this.volume * 100 + "%");
          playerInstance.volumeDefault = this.volume;
        },
        false
      );

      // 바 로더 업데이트
      this.song.addEventListener("progress", function() {
        $(playerInstance.barLoaded).width(
          (this.buffered.end(0) / this.duration) * 100 + "%");
      });

      // 시간 업데이트 이벤트 리스너 (현재 시간 속성과 함께 사용되어 오디오 재생의
      // 현재 위치를 초 단위로 반환하는 시간 업데이트)
      this.song.addEventListener("timeupdate", function() {
        $(playerInstance.timeCurrent).text(
          playerInstance.secondsToTime(this.currentTime)
        );
        $(playerInstance.barPlayed).width(
          (this.currentTime / this.duration) * 100 + "%"
        );
      });

      this.song.addEventListener("volumechange", function() {
        if (Number(Math.round(this.volume * 100 + "e" + 1) + "e-" + 1) <= 0.4) {
          this.volume = 0;
        }
        $(playerInstance.volumeAdjuster)
          .find("div")
          .width(this.volume * 100 + "%");
        if (
          this.volume > 0 &&
          playerInstance.playerHolder.hasClass(playerInstance.cssClass.mute)
        )
          playerInstance.playerHolder.removeClass(playerInstance.cssClass.mute);
        if (
          this.volume <= 0 &&
          !playerInstance.playerHolder.hasClass(playerInstance.cssClass.mute)
        )
          playerInstance.playerHolder.addClass(playerInstance.cssClass.mute);

        playerInstance.volumeValue = this.volume;
      });

      this.song.addEventListener("ended", function() {
        // 자동 실행 시 로드된 노래 재생
        // $('.fwd').click();
        if (playerInstance.settings.autoPlay) {
          playerInstance.autoPlayNext();
        } else {
          // 재생 클래스 숨기기
          playerInstance.playerHolder.removeClass(
            playerInstance.cssClass.playing
          );
          // 일시 중지 아이콘 숨기기 및 재생 표시
          $(playerInstance.controlPlay).removeClass("hidden");
          $(playerInstance.controlPause).removeClass("visible");
        }
      });

      // 음소거 아이콘 전환 및 볼륨 재설정
      $(this.volumeButton).on("click", function() {
        if (
          $(playerInstance.playerHolder).hasClass(playerInstance.cssClass.mute)
        ) {
          $(playerInstance.playerHolder).removeClass(
            playerInstance.cssClass.mute
          );
          playerInstance.song.volume = playerInstance.volumeDefault;
        } else {
          $(playerInstance.playerHolder).addClass(playerInstance.cssClass.mute);
          playerInstance.volumeDefault = playerInstance.song.volume;
          playerInstance.song.volume = 0;
          //issue callback to track mute action.
          playerInstance.settings.onMute();
        }
        return false;
      });

      // 볼륨 바를 클릭할 때
      $(this.volumeAdjuster)
        .on(eStart, function(e) {
          playerInstance.adjustVolume(e);
          playerInstance.volumeAdjuster.on(eMove, function(e) {
            playerInstance.adjustVolume(e);
          });
          //issue callback
          playerInstance.settings.volumeChanged();
        })
        .on(eCancel, function() {
          playerInstance.volumeAdjuster.unbind(eMove);
        });

      // 트랙 바를 클릭할 때
      $(this.theBar)
        .on(eStart, function(e) {
          playerInstance.adjustCurrentTime(e);
          playerInstance.theBar.on(eMove, function(e) {
            playerInstance.adjustCurrentTime(e);
          });
        })
        .on(eCancel, function() {
          playerInstance.theBar.unbind(eMove);
          //issue callback
          playerInstance.settings.seeked();
        });

      $(this.playlistHolder)
        .find(playerInstance.playlistItemSelector)
        .removeClass("active");
      elem.addClass("active");

      //issue Callback
      this.settings.onLoad();

      // 자동 실행 시 로드된 노래 재생
      if (this.settings.autoPlay) this.playAudio();
    },

    playAudio: function() {
      this.song.play();

      // 재생 클래스 추가
      this.playerHolder.addClass(this.cssClass.playing);

      // 일시 중지 아이콘 숨기기 및 아이콘이 있으면 재생 표시
      if (
        $.inArray("controls", this.settings.elements) != "-1" &&
        $.inArray("play", this.settings.controlElements) != "-1"
      ) {
        $(this.controlPlay).addClass("hidden");
        $(this.controlPause).addClass("visible");
      }
      this.settings.onPlay();
    },

    stopAudio: function() {
      this.song.pause();
      // 재생 클래스 제거
      this.playerHolder.removeClass(this.cssClass.playing);

      // 일시 중지 아이콘 숨기기 및 아이콘이 있으면 재생 표시
      if (
        $.inArray("controls", this.settings.elements) != "-1" &&
        $.inArray("play", this.settings.controlElements) != "-1"
      ) {
        $(this.controlPlay).removeClass("hidden");
        $(this.controlPause).removeClass("visible");
      }
    },
    // 자동 루프가 활성화 된 경우 다음 트랙 및 루프를 재생합니다.
    autoPlayNext: function() {
      this.stopAudio();
      var next = this.getSong(true);
      // 루핑 활성화 : 다음 항목이 없으면 재생 목록의 첫 번째 항목을 재생합니다 (루핑)
      if (next.length == 0 && this.settings.loop) {
        next = $(this.playlistHolder).find(
          this.playlistItemSelector + ":first"
        );
        this.loadNewSong(next);
        this.playAudio();
      } else if (!next.length == 0) {
        this.loadNewSong(next);
        this.playAudio();
      }
    },
    // nextSong : 다음 또는 이전 노래를 가져 오는 Boolean입니다.
    getSong: function(nextSong) {
      var $x = $(this.playlistHolder).find(this.playlistItemSelector);
      var curSong = $(this.playlistItemSelector + ".active");
      if (nextSong) {
        return $x.eq($x.index(curSong) + 1);
      } else {
        return $x.eq($x.index(curSong) - 1);
      }
    },
    // 현재 노래 설정을 유지
    loadNewSong: function(elem) {
      // 현재 볼륨 저장
      this.volumeValue = this.song.volume;
      // 다음 곡 재생 설정
      this.initAudio(elem);
      // 노래 볼륨을 이전 트랙의 볼륨으로 설정
      this.song.volume = this.volumeValue;
      this.volumeAdjuster.find("div").width(this.volumeValue * 100 + "%");
      // 진행률 및 로드된 바 재설정
      this.barPlayed.width(0);
      this.barLoaded.width(0);
    }
  });

  $.fn[pluginName] = function(options) {
    return this.each(function() {
      if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName, new Plugin(this, options));
      }
    });
  };
})(jQuery, window, document);
