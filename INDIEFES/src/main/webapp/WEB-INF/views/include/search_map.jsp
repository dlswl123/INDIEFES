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
    
    
				<label id="concerthall">공연장 위치</label>
					<div class="map_wrap" style="color:#292929;">
						<div id="map" style="width:100%;height:500px;position:relative;overflow:hidden;"></div>
						<div class="hAddr">
					        <span class="title">지도중심기준 행정동 주소정보</span>
					        <span id="centerAddr"></span>
					    </div>
						<div id="addr_menu_wrap" class="bg_white">
					    	<div class="option">
					      		<div>
					      			<form id="searchAddr">
					      				주소 : <input type="text" id="keyAddr" size="30" placeholder="주소로 검색시 이용">
					      				<button type="button" onclick="searchAddr(); return false;" class="btn btn-xs btn-primary" id="addrSearch">검색하기</button>
					      			</form>
					      		</div>
					      	</div>
					    </div>
					  	<div id="menu_wrap" class="bg_white">
					        <div class="option">
					            <div>
<!-- 					                <form onsubmit="searchPlaces(); return false;"> -->
					                <form id="searchPlaces">
					                    키워드 : <input type="text" id="keyword" size="15" placeholder="ex)공연장"> 
					                    <button type="button" onclick="searchPlaces(); return false;" class="btn btn-xs btn-primary" id="mapSearch">검색하기</button> 
					                </form>
					            </div>
					        </div>
					        <hr>
					        <ul id="placesList"></ul>
					        <div id="pagination"></div>
					    </div>
					    <div id="addr_result_wrap" class="bg_white">
					    	<div class="option">
					    		<div>
					    			<b>선택장소 확인</b><br>
					    			<div id="chAddr"></div>
					    			<input type="hidden" id="place_name" name="place_name" />
					    			<input type="hidden" id="place_x" name="place_x" />
					    			<input type="hidden" id="place_y" name="place_y" />
					    		</div>
					    	</div>
					    </div>
					</div>
					 <!-- services와 clusterer, drawing 라이브러리 불러오기 -->
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=913777d8d62e9dada9a5b7e3656cdba2&libraries=services,clusterer,drawing"></script>
<!-- 					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=913777d8d62e9dada9a5b7e3656cdba2"></script> -->
					<script>
						// 지도 스크립트 코드
						//=======================================================
							
							
						// 마커를 담을 배열입니다
						var markers = [];
					
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = {
							center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
						};
						

						
						//=======================================================
						
						
						// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
// 						if (navigator.geolocation) {
						
						    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
// 						    navigator.geolocation.getCurrentPosition(function(position) {
						    
// 						        var lat = position.coords.latitude, // 위도
// 						            lon = position.coords.longitude; // 경도
						    
// 						        mapOption = { 
// 								        center: new daum.maps.LatLng(lat, lon), // 지도의 중심좌표
// 								        level: 3 // 지도의 확대 레벨
// 								    };
						            
// 						            console.log("lat : " + lat + ", lon : " + lon);
// 						      });

// 						}
						
						
						//=======================================================
						

							
						var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						var geocoder = new daum.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
						
						
						
						//=======================================================
						
							
						// 지도를 클릭한 위치에 표출할 마커입니다
						var marker = new daum.maps.Marker({ 
						    // 지도 중심좌표에 마커를 생성합니다 
						    position: map.getCenter() 
						}); 
						

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
						
							
// 						infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

						// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
						searchAddrFromCoords(map.getCenter(), displayCenterInfo);

						// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
						daum.maps.event.addListener(map, 'click', function(mouseEvent) {
						    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
						        if (status === daum.maps.services.Status.OK) {
						        	
						            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
						            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
						            
						            var content = '<div class="bAddr">' +
						                            '<span class="title">법정동 주소정보</span>' + 
						                            detailAddr + 
						                        	'</div>';

						            // 지도에 표시되고 있는 마커를 제거합니다
						            removeMarker();            	
						            
						            // 마커를 클릭한 위치에 표시합니다 
						            marker.setPosition(mouseEvent.latLng);
						            marker.setMap(map);
						            markers.push(marker);

						            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
						            infowindow.setContent(content);
						            infowindow.open(map, marker);
						            
						         	// 중심을 선택한 곳으로 옮김
								    map.panTo(marker.getPosition());
						         	
								    setPlaceInfoWithoutTitle(marker);
						        }   
						    });
						});

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
						
						// 장소 검색 객체를 생성합니다
						var ps = new daum.maps.services.Places();  

						// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
						var infowindow = new daum.maps.InfoWindow({zIndex:1});

						// 키워드로 장소를 검색합니다
// 						searchPlaces();
						
						// 키워드 검색을 요청하는 함수입니다
						function searchPlaces() {

						    var keyword = document.getElementById('keyword').value;

						    if (!keyword.replace(/^\s+|\s+$/g, '')) {
						        alert('키워드를 입력해주세요!');
						        return false;
						    }

						    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
						    ps.keywordSearch(keyword, placesSearchCB); 
						}

						// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
						function placesSearchCB(data, status, pagination) {
						    if (status === daum.maps.services.Status.OK) {

						    	// 정상적으로 검색이 완료됐으면
						        // 검색 목록과 마커를 표출합니다
						        displayPlaces(data);

						        // 페이지 번호를 표출합니다
						        displayPagination(pagination);

						    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

						        alert('검색 결과가 존재하지 않습니다.');
						        return;

						    } else if (status === daum.maps.services.Status.ERROR) {

						        alert('검색 결과 중 오류가 발생했습니다.');
						        return;

						    }
						}

						// 검색 결과 목록과 마커를 표출하는 함수입니다
						function displayPlaces(places) {

						    var listEl = document.getElementById('placesList'), 
						    menuEl = document.getElementById('menu_wrap'),
						    fragment = document.createDocumentFragment(), 
						    bounds = new daum.maps.LatLngBounds(), 
						    listStr = '';
						    
						    // 검색 결과 목록에 추가된 항목들을 제거합니다
						    removeAllChildNods(listEl);

						    // 지도에 표시되고 있는 마커를 제거합니다
						    removeMarker();
						    
						    for ( var i=0; i<places.length; i++ ) {

						        // 마커를 생성하고 지도에 표시합니다
						        var placePosition = new daum.maps.LatLng(places[i].y, places[i].x),
						            marker = addMarker(placePosition, i), 
						            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

						        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
						        // LatLngBounds 객체에 좌표를 추가합니다
						        bounds.extend(placePosition);

						        // 마커와 검색결과 항목에 mouseover 했을때
						        // 해당 장소에 인포윈도우에 장소명을 표시합니다
						        // mouseout 했을 때는 인포윈도우를 닫습니다
						        (function(marker, title) {
						            daum.maps.event.addListener(marker, 'mouseover', function() {
						                displayInfowindow(marker, title);
						            });

						            daum.maps.event.addListener(marker, 'mouseout', function() {
						                infowindow.close();
						            });
						            
						            daum.maps.event.addListener(marker, 'click', function() {
										getPlacePosition(marker, title);
									});
						            
						            itemEl.onmouseover =  function () {
						                displayInfowindow(marker, title);
						            };

						            itemEl.onmouseout =  function () {
						                infowindow.close();
						            };
						            
						            itemEl.onclick = function() {
						            	getPlacePosition(marker, title);
									};
						            
						        })(marker, places[i].place_name);
						        
						        fragment.appendChild(itemEl);
						    }

						    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
						    listEl.appendChild(fragment);
						    menuEl.scrollTop = 0;

						    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
						    map.setBounds(bounds);
						}

						// 검색결과 항목을 Element로 반환하는 함수입니다
						function getListItem(index, places) {

						    var el = document.createElement('li'),
						    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
						                '<div class="info">' +
						                '   <h5>' + places.place_name + '</h5>';

						    if (places.road_address_name) {
						        itemStr += '    <span>' + places.road_address_name + '</span>' +
						                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
						    } else {
						        itemStr += '    <span>' +  places.address_name  + '</span>'; 
						    }
						                 
						      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
						                '</div>';           

						    el.innerHTML = itemStr;
						    el.className = 'item';

						    return el;
						}

						// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
						function addMarker(position, idx, title) {
						    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
						        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
						        imgOptions =  {
						            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
						            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
						            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
						        },
						        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
						            marker = new daum.maps.Marker({
						            position: position, // 마커의 위치
						            image: markerImage 
						        });

						    marker.setMap(map); // 지도 위에 마커를 표출합니다
						    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

						    return marker;
						}

						// 지도 위에 표시되고 있는 마커를 모두 제거합니다
						function removeMarker() {
						    for ( var i = 0; i < markers.length; i++ ) {
						        markers[i].setMap(null);
						    }   
						    markers = [];
						}

						// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
						function displayPagination(pagination) {
						    var paginationEl = document.getElementById('pagination'),
						        fragment = document.createDocumentFragment(),
						        i; 

						    // 기존에 추가된 페이지번호를 삭제합니다
						    while (paginationEl.hasChildNodes()) {
						        paginationEl.removeChild (paginationEl.lastChild);
						    }

						    for (i=1; i<=pagination.last; i++) {
						        var el = document.createElement('a');
						        el.href = "#";
						        el.innerHTML = i;

						        if (i===pagination.current) {
						            el.className = 'on';
						        } else {
						            el.onclick = (function(i) {
						                return function() {
						                    pagination.gotoPage(i);
						                }
						            })(i);
						        }

						        fragment.appendChild(el);
						    }
						    paginationEl.appendChild(fragment);
						}

						// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
						// 인포윈도우에 장소명을 표시합니다
						function displayInfowindow(marker, title) {
						    var content = '<div style="padding:5px;z-index:1;overflow:hidden;height:auto;">' + title + '</div>';

						 	// 마커의 중심으로 이동
						    map.panTo(marker.getPosition());
						    
						    infowindow.setContent(content);
						    infowindow.open(map, marker);
						}

						 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
						function removeAllChildNods(el) {   
						    while (el.hasChildNodes()) {
						        el.removeChild (el.lastChild);
						    }
						}
						 
						 
						 //======================================================= 
						 
						 
						 // 클릭한 마커와 목록의 좌표를 얻어내는 함수
						 function getPlacePosition(marker, title) {
							 removeMarker();
							 
							 map.panTo(marker.getPosition());
							 
							 marker.setMap(map);
							 markers.push(marker);
							 
							 setPlaceInfo(marker, title);
						 }
						 
						 // 선택한 주소값을 받아오는 함수
						 function setPlaceInfo(marker, title) {
							 var latLng = marker.getPosition();
							 var pointX = latLng.getLng();
							 var pointY = latLng.getLat();
							 
							 searchDetailAddrFromCoords(latLng, function(result, status) {
								 if (status === daum.maps.services.Status.OK) {
						            var detailAddr = '<div>상호명 : ' + title + '</div>';
						            	detailAddr += !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
						            	detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
						            	detailAddr += '<input type="hidden" id="chAddrName" name="chAddrName" value="' + title + '">';
						            
						            // 선택에 법정동 상세 주소정보를 표시합니다
						            $("#chAddr").html(detailAddr);
						            
						            $("#place_name").val(title);
						            $("#place_x").val(pointX);
						            $("#place_y").val(pointY);
								 }
							 });
						 }
						 
						 // 선택한 주소값을 받아오는 함수 (상호명 없을때)
						 function setPlaceInfoWithoutTitle(marker) {
							 var latLng = marker.getPosition();
							 var pointX = latLng.getLng();
							 var pointY = latLng.getLat();
							 
							 searchDetailAddrFromCoords(latLng, function(result, status) {
								 if (status === daum.maps.services.Status.OK) {
						            var detailAddr = '<div>상호명 : <input type="text" id="chAddrName" name="chAddrName" placeholder="장소명을 입력해주세요" required/></div>';
						            	detailAddr += !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
						            	detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
						            
						            // 선택에 법정동 상세 주소정보를 표시합니다
						            $("#chAddr").html(detailAddr);
						            
						            $("#place_x").val(pointX);
						            $("#place_y").val(pointY);
								 }
							 });
						 }
						 
						$("#chAddr").on("change", "#chAddrName", function() {
							var placeName = $(this).val();
							$("#place_name").val(placeName);
						});
						 
						 
						//======================================================= 

						// 주소 입력 후 검색
						function searchAddr() {
							var keyAddr = document.getElementById('keyAddr').value;
						    
						    if (!keyAddr.replace(/^\s+|\s+$/g, '')) {
						        alert('주소를 입력해주세요!');
						        return false;
						    }

						    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
							// 주소로 좌표를 검색합니다
							geocoder.addressSearch(keyAddr, function(result, status) {
								
							    // 정상적으로 검색이 완료됐으면 
							     if (status === daum.maps.services.Status.OK) {

							        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

							        // 결과값으로 받은 위치를 마커로 표시합니다
							        var marker = new daum.maps.Marker({
							            map: map,
							            position: coords
							        });
							        
							        var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
						            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

						            var content = '<div class="bAddr"><span class="title">법정동 주소정보</span>' + detailAddr + '</div>';
						            
							        // 인포윈도우로 장소에 대한 설명을 표시합니다
							        infowindow.setContent(content);
							        infowindow.open(map, marker);

							        markers.push(marker);  // 배열에 생성된 마커를 추가합니다
							        
							        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							        map.setCenter(coords);
							        
							        setPlaceInfoWithoutTitle(marker);

							     } 
							});    
						}
						 
						
						//======================================================= 
						
						
					</script> <!-- kakao map -->