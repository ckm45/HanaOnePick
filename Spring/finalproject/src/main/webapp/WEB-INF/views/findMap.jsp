<%@ page import="com.kopo.finalproject.model.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8" name="viewport" content="width=device-width,initial-scale=1">
<title>지도로 혜택 찾기</title>

<head>
    <link rel="stylesheet" href="../resources/css/findMap.css">
    <link rel="stylesheet" href="../resources/css/font.css">
    <!--search 로고-->
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
<script
        src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"></script>
<%@ include file="../include/header.jsp" %>
<hr>
<div class="map-title">
    <h2>내 주변 내 카드 혜택 찾기</h2>
    <img src="../../resources/img/search_character.png"
         alt="search_character">
</div>
<div class="wrap">
    <div class="search">
        <input type="text" class="searchTerm" id="keywordInput"
               placeholder="검색어를 입력하세요">
        <button onclick="searchKeyword()" class="searchButton">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </div>
</div>

<div class="map_wrap">
    <!--카테고리-->
    <ul id="category">
        <li id="FD6" data-order="0"><span class="category_bg bank"></span>
            음식점
        </li>
        <li id="MT1" data-order="1"><span class="category_bg mart"></span>
            마트
        </li>
        <li id="PM9" data-order="2"><span class="category_bg pharmacy"></span>
            약국
        </li>
        <li id="OL7" data-order="3"><span class="category_bg oil"></span>
            주유소
        </li>
        <li id="CE7" data-order="4"><span class="category_bg cafe"></span>
            카페
        </li>
        <li id="CS2" data-order="5"><span class="category_bg store"></span>
            편의점
        </li>
        <li id="AC5" data-order="5"><span class="category_bg store"></span>
            학원
        </li>
    </ul>
    <!--지도-->
    <div id="map"></div>

</div>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01d27ec9956c4c63f5cc349e94a77412&libraries=services">
</script>

<script>
    // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다 (키워드용)
    var infowindow = new kakao.maps.InfoWindow({
        zIndex: 1
    });

    // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
    var placeOverlay = new kakao.maps.CustomOverlay({
            zIndex: 1
        }), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
        markers = [], // 마커를 담을 배열입니다
        currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3, // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    //현위치 정확도 높이기
    var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0,
    };

    // 현재 위치를 얻어 지도 중심으로 설정하고, 마커를 표시하는 함수
    function setCenterToCurrentLocation() {
        if (navigator.geolocation) {
            // Geolocation API를 지원하는 경우
            navigator.geolocation.getCurrentPosition(function (position) {
                // 현재 위치의 위도와 경도를 가져옵니다.
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
qazw
                // 새로운 지도 중심 좌표를 설정합니다.
                var newCenter = new kakao.maps.LatLng(lat, lng);

                // 지도의 중심을 변경합니다.
                map.setCenter(newCenter);

                // 마커를 생성합니다.
                var markerPosition = new kakao.maps.LatLng(lat, lng);
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                //지도에서 현 위치 원 만들기
                var circle = new kakao.maps.Circle({
                    map: map,
                    center: newCenter,
                    radius: 100,
                    strokeWeight: 2,
                    strokeColor: '#b69b9b',
                    strokeOpacity: 0.8,
                    strokeStyle: 'dashed',
                    fillColor: '#afe752',
                    fillOpacity: 0.5
                });

                circle.setMap(map);
                // 마커를 지도에 표시합니다.
                marker.setMap(map);

                searchPlaces2();

            }, function (error) {
                // 위치 정보를 가져오는 데 실패한 경우 처리할 로직을 넣어줄 수 있습니다.
                console.error('Error getting current location:', error);
            }, options);
        } else {
            // Geolocation API를 지원하지 않는 경우 처리할 로직을 넣어줄 수 있습니다.
            console.error('Geolocation is not supported by this browser.');
        }
    }

    // 함수를 호출하여 현재 위치를 가져와서 지도 중심으로 설정하고, 마커를 표시합니다.
    setCenterToCurrentLocation();

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places(map);

    // 장소 검색 객체를 생성합니다 (키워드 검색용)
    var ps_keyword = new kakao.maps.services.Places();

    // 지도에 idle 이벤트를 등록합니다
    kakao.maps.event.addListener(map, 'idle', searchPlaces);

    // 지도에 idle 이벤트를 등록합니다(Boundary 알림을 위해)
    //kakao.maps.event.addListener(map, 'idle', searchPlaces2);
    //idle
    //중심 좌표나 확대 수준이 변경되면 발생한다.
    //단, 애니메이션 도중에는 발생하지 않는다.

    //center_changed
    //중심 좌표가 변경되면 발생한다.
    //중심좌표 변경 이벤트 등록하기 샘플보기

    // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
    contentNode.className = 'placeinfo_wrap';

    // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
    // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
    addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
    addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

    // 커스텀 오버레이 컨텐츠를 설정합니다
    placeOverlay.setContent(contentNode);

    // 각 카테고리에 클릭 이벤트를 등록합니다
    addCategoryClickEvent();

    // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
    function addEventHandle(target, type, callback) {
        if (target.addEventListener) {
            target.addEventListener(type, callback);
        } else {
            target.attachEvent('on' + type, callback);
        }
    }


    // 키워드 검색 완료 시 호출되는 콜백함수 입니다 (키워드용)
    function placesSearchCB_keyword(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();

            for (var i = 0; i < data.length; i++) {
                displayMarker(data[i]);
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            }

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }
    }

    // 지도에 마커를 표시하는 함수입니다 (키워드용)
    function displayMarker(place) {


        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function () {
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            infowindow
                .setContent('<div style="padding:5px;font-size:12px;">'
                    + place.place_name + '</div>');
            infowindow.open(map, marker);
        });
    }

    // Function to search for a keyword entered by the user (키워드용)
    function searchKeyword() {
        var keyword = document.getElementById('keywordInput').value;
        ps_keyword.keywordSearch(keyword, placesSearchCB_keyword);
    }

    // 카테고리 검색을 요청하는 함수입니다
    function searchPlaces() {
        if (!currCategory) {
            return;
        }

        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        ps.categorySearch(currCategory, placesSearchCB, {
            useMapBounds: true
        });
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
            console.log('placeSearchCB: ' + data)
            displayPlaces(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

        } else if (status === kakao.maps.services.Status.ERROR) {
            // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

        }
    }


    // boundary 오면 알림하기 위해 추가 (현재 위치 기준 원으로 검색)
    function searchPlaces2() {

        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        //100미터 안에 혜택이 있는 마트가 있나 체크
        ps.categorySearch('FD6', placesSearchCB2, {
            radius: 100,
            useMapCenter: true
        });

        //100미터 안에 혜택이 있는 마트가 있나 체크
        ps.categorySearch('MT1', placesSearchCB2, {
            radius: 100,
            useMapCenter: true
        });

        //100미터 안에 혜택이 있는 편의점이 있나 체크
        ps.categorySearch('CS2', placesSearchCB2, {
            radius: 100,
            useMapCenter: true
        });

        //100미터 안에 혜택이 있는 카페가 있나 체크
        ps.categorySearch('CE7', placesSearchCB2, {
            radius: 100,
            useMapCenter: true
        });

    }

    //두점 사이의 거리 구하는 함수
    function getDistance(lat1, lon1, lat2, lon2) {
        var R = 6371; // Earth's radius in kilometers
        var dLat = (lat2 - lat1) * Math.PI / 180;
        var dLon = (lon2 - lon1) * Math.PI / 180;
        var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        var d = R * c;
        return d; // returns the distance in kilometers
    }

    <%--function placesSearchCB2(data, status, pagination) {--%>
    <%--    if (status === kakao.maps.services.Status.OK) {--%>
    <%--        var currCenter = map.getCenter(); // 현재 지도 중심 좌표를 가져옵니다.--%>
    <%--        var currLat = currCenter.getLat();--%>
    <%--        var currLng = currCenter.getLng();--%>
    <%--        var RADIUS = 0.1; // 100 meters in kilometers--%>

    <%--        for (var i = 0; i < data.length; i++) {--%>
    <%--            var placeLat = data[i].y;--%>
    <%--            var placeLng = data[i].x;--%>

    <%--            // 현재 위치와 검색된 장소 사이의 거리를 계산합니다.--%>
    <%--            var distance = getDistance(currLat, currLng, placeLat, placeLng);--%>

    <%--            // 거리가 원의 반지름보다 작다면 웹 푸시 알림을 보냅니다.--%>
    <%--            if (distance <= RADIUS) {--%>
    <%--                let searchStoreName = data[i].place_name;--%>
    <%--                let groupCode = data[i].category_group_code;--%>
    <%--                const memberId = '<%= ((MemberDTO)session.getAttribute("dto")).getMemberId() %>';--%>
    <%--                let jsonData = JSON.stringify({--%>
    <%--                    searchStoreName: searchStoreName,--%>
    <%--                    groupCode: groupCode,--%>
    <%--                    memberId: memberId--%>
    <%--                });--%>

    <%--                console.log('jsonData 주변:', jsonData); // jsonData 값을 로깅--%>
    <%--                console.log('data[i] : ' + data[i].place_name);--%>

    <%--                var title = "HanaOnePick";--%>
    <%--                var body = "주변에 혜택 매장이 탐지되었습니다.";--%>
    <%--                var token = "<%= session.getAttribute("firebaseToken") %>";--%>
    <%--                $.ajax({--%>
    <%--                    url: '/fcm',--%>
    <%--                    type: 'POST',--%>
    <%--                    data: {--%>
    <%--                        title: title,--%>
    <%--                        body: body,--%>
    <%--                        token: token--%>
    <%--                    },--%>
    <%--                    success: function (response) {--%>
    <%--                        console.log(response);--%>
    <%--                    },--%>
    <%--                    error: function (error) {--%>
    <%--                        console.error("Error sending notification:", error);--%>
    <%--                        alert('Failed to send notification. Please try again.');--%>
    <%--                    }--%>
    <%--                });--%>
    <%--            }--%>
    <%--        }--%>
    <%--        displayPlaces(data);--%>
    <%--    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {--%>
    <%--        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요--%>
    <%--        console.log("검색결과 없음")--%>

    <%--    } else if (status === kakao.maps.services.Status.ERROR) {--%>
    <%--        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요--%>

    <%--    }--%>
    <%--}--%>

    function placesSearchCB2(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            var currCenter = map.getCenter();
            var currLat = currCenter.getLat();
            var currLng = currCenter.getLng();
            var RADIUS = 0.2;
            console.log("placeSearchCB2: " + data);
            for (var i = 0; i < data.length; i++) {
                console.log('data[i].place_name: '+data[i].place_name)
                var placeLat = data[i].y;
                var placeLng = data[i].x;
                //혜택이 있을때 만 알림 띄우기

                var distance = getDistance(currLat, currLng, placeLat, placeLng);

                if (distance <= RADIUS) {
                    let searchStoreName = data[i].place_name;
                    let groupCode = data[i].category_group_code;
                    let memberId = '<%= ((MemberDTO)session.getAttribute("dto")).getMemberId() %>';

                    const jsonData = JSON.stringify({
                        memberId: memberId,
                        searchStoreName: searchStoreName,
                        groupCode: groupCode
                    });

                    $.ajax({
                        type: 'POST',
                        url: '/showBenefit',
                        data: jsonData,
                        contentType: 'application/json',
                        success: function (response) {
                            console.log("주변에 이 혜택이 있나 체크")
                            const benefitData = response;
                            console.log("요청 성공:", response);
                            if (benefitData.length === 0) {
                                return;
                            } else {
                                var groupCodeStr = "";
                                if(groupCode === "FD6"){
                                    groupCodeStr = "음식점";
                                }else if(groupCode === "MT1"){
                                    groupCodeStr = "마트";
                                }else if(groupCode === "CS2") {
                                    groupCodeStr = "편의점";
                                }else if(groupCode === "CE7") {
                                    groupCodeStr = "카페";
                                }
                                // 혜택이 있을 때 알람기능 추가
                                var title = "HanaOnePick";
                                var body = "주변에 당신의 보유카드인 " + benefitData[0].cardName + " 카드와 관련된 " + "\n" + groupCodeStr + "혜택 매장이 있는거 같습니다." + "\n" + "지도를 확인해보세요!";
                                var token = "<%= session.getAttribute("firebaseToken") %>";
                                $.ajax({
                                    url: '/fcm',
                                    type: 'POST',
                                    data: {
                                        title: title,
                                        body: body,
                                        token: token
                                    },
                                    success: function (response) {
                                        console.log(response);
                                    },
                                    error: function (error) {
                                        console.error("Error sending notification:", error);
                                        alert('Failed to send notification. Please try again.');
                                    }
                                });
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.log("요청 실패:", textStatus);
                            if (errorThrown !== undefined) {
                                console.log("오류:", errorThrown);
                            }
                            console.log("서버 응답 상태:", xhr.status);
                            console.log("서버 응답 내용:", xhr.responseText);
                        }
                    });
                }
            }
            displayPlaces(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            console.log(kakao.maps.services.Status.ZERO_RESULT)
            console.log("검색결과 없음")

        } else if (status === kakao.maps.services.Status.ERROR) {
        }
    }

    // 지도에 마커를 표시하는 함수입니다(키워드용)
    function displayMarker(place) {

        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function () {
            console.log('검색어: ' + place.category_name);
            console.log(place)
            console.log(place.place_name);
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            infowindow
                .setContent('<div style="padding:5px;font-size:12px;">'
                    + place.place_name + '</div>');
            infowindow.open(map, marker);
        });
    }

    function displayPlaces(places) {

        var order = document.getElementById(currCategory).getAttribute('data-order');

        for (var i = 0; i < places.length; i++) {
            (function (index) {
                console.log("장소명:", places[index].place_name);

                const searchStoreName = places[index].place_name;
                const groupCode = places[index].category_group_code;
                const memberId = '<%= ((MemberDTO)session.getAttribute("dto")).getMemberId() %>';

                const jsonData = JSON.stringify({
                    memberId: memberId,
                    searchStoreName: searchStoreName,
                    groupCode: groupCode
                });

                $.ajax({
                    type: 'POST',
                    url: '/showBenefit',
                    data: jsonData,
                    contentType: 'application/json',
                    success: function (response) {
                        const benefitData = response;
                        if (benefitData.length === 0) {
                            return;
                        } else {
                            var marker = addMarker(new kakao.maps.LatLng(places[index].y, places[index].x), order);

                            kakao.maps.event.addListener(marker, 'click', function () {
                                displayPlaceInfo(places[index], benefitData);
                            });
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.log("요청 실패:", textStatus);
                        if (errorThrown !== undefined) {
                            console.log("오류:", errorThrown);
                        }
                        console.log("서버 응답 상태:", xhr.status);
                        console.log("서버 응답 내용:", xhr.responseText);
                    }
                });
            })(i);
        }

    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, order) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(11, 28)
                // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            }, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
                imgOptions), marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
    function displayPlaceInfo(place, benefitData) {
        console.log(place);
        var content = '<div class="placeinfo">'
            + '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
            + place.place_name + '</a>';

        if (place.road_address_name) {
            content += '    <span title="' + place.road_address_name + '">'
                + place.road_address_name
                + '</span>'
                + '  <span class="jibun" title="' + place.address_name + '">(지번 : '
                + place.address_name + ')</span>';
        } else {
            content += '    <span title="' + place.address_name + '">'
                + place.address_name + '</span>';
        }

        content += '    <span class="tel">' + place.phone + '</span>'
            + '</div>' + '<div class="after"></div>';

        //content에 benefitData의 benefit_content, card_name 추가
        //ACPA
        for (let i = 0; i < benefitData.length; i++) {
            console.log(benefitData[i])
            const cardName = benefitData[i].cardName;
            const benefitCode = benefitData[i].benefitCode;
            console.log("cardName: " + cardName)
            console.log("benefitCode: " + benefitCode)
            $.ajax({
                type: 'GET',
                url: '/getCardID',
                data: {
                    cardName: cardName
                },
                success: function (response) {
                    let cardId = response;
                    console.log("요청 성공:", response);

                    console.log("benefitCode: " + benefitCode);
                    const benefitType = benefitCode.substring(0, 2);
                    const benefitMethod = benefitCode.substring(2, 3);
                    const benefitMaxMethod = benefitCode.substring(3, 4);
                    let benefitContent = "";

                    if (benefitMethod === 'P') {
                        benefitContent = benefitContent + benefitData[i].benefitAmount + "%";
                    } else if (benefitMethod === 'V') {
                        benefitContent = benefitContent + benefitData[i].benefitAmount + "원";
                    }

                    if (benefitType === 'AC') {
                        benefitContent = benefitContent + " 적립";
                    } else if (benefitType === "DC") {
                        benefitContent = benefitContent + " 할인";
                    }

                    if (benefitMaxMethod === 'A') {
                        benefitContent = benefitContent + " 최대 " + benefitData[i].benefitMax + "원";
                    } else if (benefitMaxMethod === 'C') {
                        benefitContent = benefitContent + " 최대 " + benefitData[i].benefitMax + "회";
                    }

                    content += '<div class="placeinfo">'
                        + '<span class="cardName"><img src="../../resources/img/hanacard' + cardId + '.png">' + cardName + '</span>'
                        + '<hr style="display: block; height: 100%; margin: 3px">'
                        + '<span class="benefitContent">' + benefitContent + '</span>'
                        + '</div>';

                    // 이 위치에서 다음 동작을 계속하려면 이 부분에 코드를 추가하십시오.
                    if (i === benefitData.length - 1) {
                        contentNode.innerHTML = content;
                        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                        placeOverlay.setMap(map);
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log("요청 실패:", textStatus);
                    if (errorThrown !== undefined) {
                        console.log("오류:", errorThrown);
                    }
                    console.log("서버 응답 상태:", xhr.status);
                    console.log("서버 응답 내용:", xhr.responseText);
                }
            });
        }

    }


    // 각 카테고리에 클릭 이벤트를 등록합니다
    function addCategoryClickEvent() {
        var category = document.getElementById('category'), children = category.children;

        for (var i = 0; i < children.length; i++) {
            children[i].onclick = onClickCategory;
        }
    }

    // 카테고리를 클릭했을 때 호출되는 함수입니다
    function onClickCategory() {
        var id = this.id, className = this.className;

        placeOverlay.setMap(null);

        if (className === 'on') {
            currCategory = '';
            changeCategoryClass();
            removeMarker();
        } else {
            currCategory = id;
            changeCategoryClass(this);
            searchPlaces();
        }
    }

    // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
    function changeCategoryClass(el) {
        var category = document.getElementById('category'), children = category.children, i;

        for (i = 0; i < children.length; i++) {
            children[i].className = '';
        }

        if (el) {
            el.className = 'on';
        }
    }
</script>

<script type="module" src="../../resources/js/index.js"></script>
<%@ include file="../include/footer.jsp" %>
</body>

</html>