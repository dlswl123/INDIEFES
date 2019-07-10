<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:100px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.title {font-weight:bold;display:block;}
.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#centerAddr {display:block;margin-top:2px;font-weight: normal;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#addr_menu_wrap	{position:absolute;top:65px;left:10px;width:300px;z-index:1;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
#addr_result_wrap {position:absolute;bottom:10px;right:10px;width:300px;z-index:1;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
</style>
    
    
					<div class="map_wrap">
						<div id="map" style="width:100%;height:500px;position:relative;overflow:hidden;"></div>
						<div class="hAddr">
					        <span class="title" style="color:#000000;">지도중심기준 행정동 주소정보</span>
					        <span id="centerAddr" style="color:#000000;"></span>
					    </div>
					</div>
					 <!-- services와 clusterer, drawing 라이브러리 불러오기 -->
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=913777d8d62e9dada9a5b7e3656cdba2&libraries=services,clusterer,drawing"></script>
<!-- 					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=913777d8d62e9dada9a5b7e3656cdba2"></script> -->
					<script>
						// 지도 스크립트 코드
						//=======================================================
						
						var pX = "${vo.place_x}";
						var pY = "${vo.place_y}";
						var pN = "${vo.place_name}";
							
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = {
							center: new daum.maps.LatLng(pY, pX), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
						};
						

						//=======================================================
						

							
						var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						var geocoder = new daum.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
						
						
						
						//=======================================================
						
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(pY, pX); 

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
						
						
						var iwContent = '<div style="padding:5px;color:#000000;">' + pN + '<br><a href="https://map.kakao.com/link/map/' + pN + ',' + pY + ',' + pX + '" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/' + pN + ',' + pY + ',' + pX + '" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
					    iwPosition = new kakao.maps.LatLng(pY, pX); //인포윈도우 표시 위치입니다

						// 인포윈도우를 생성합니다
						var infowindow = new kakao.maps.InfoWindow({
						    position : iwPosition, 
						    content : iwContent 
						});
						  
						// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
						infowindow.open(map, marker); 

						//=======================================================
							
							
						// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
						var mapTypeControl = new daum.maps.MapTypeControl();

						// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
						// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
						map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

						// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
						var zoomControl = new daum.maps.ZoomControl();
						map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
						
						
						//=======================================================
							

						// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
						searchAddrFromCoords(map.getCenter(), displayCenterInfo);


						// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
						daum.maps.event.addListener(map, 'idle', function() {
						    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
						});

						function searchAddrFromCoords(coords, callback) {
						    // 좌표로 행정동 주소 정보를 요청합니다
						    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
						}

						function searchDetailAddrFromCoords(coords, callback) {
						    // 좌표로 법정동 상세 주소 정보를 요청합니다
						    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
						}

						// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
						function displayCenterInfo(result, status) {
						    if (status === daum.maps.services.Status.OK) {
						        var infoDiv = document.getElementById('centerAddr');

						        for(var i = 0; i < result.length; i++) {
						            // 행정동의 region_type 값은 'H' 이므로
						            if (result[i].region_type === 'H') {
						                infoDiv.innerHTML = result[i].address_name;
						                break;
						            }
						        }
						    }    
						}

						
						//======================================================= 
						
						
					</script> <!-- kakao map -->