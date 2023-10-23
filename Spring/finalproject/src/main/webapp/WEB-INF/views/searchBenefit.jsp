<%@ page import="com.kopo.finalproject.model.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<title>검색으로 혜택찾기</title>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../resources/css/font.css">
    <link rel="stylesheet" href="../resources/css/searchBenefit.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous">
    <link rel="stylesheet" href="../../resources/css/font.css">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<hr>
<br>
<div class="title-bar shadow">매장 혜택 찾기</div>
<div class="wrap">
    <div class="search rounded-5 shadow">
        <input type="text" class="searchTerm" id="keywordInput"
               placeholder="결제하는 곳이 어딘가요?">
        <button onclick="searchKeyword()" class="searchButton">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </div>
    <div class="search-section">
        <div class="search-rank shadow rounded-3">
            <h5 class="strong">최근 검색 순위</h5>
            <ol class="list-group list-group-numbered fs-4">
                <c:forEach var="searchRank" items="${searchRankList}" varStatus="status">
                    <c:if test="${searchRank=='CE'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/ce.png">커피</div></li>
                    </c:if>
                    <c:if test="${searchRank=='MT'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/mt.png">대형마트</div></li>
                    </c:if>
                    <c:if test="${searchRank=='SH'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/sh.png">쇼핑</div></li>
                    </c:if>
                    <c:if test="${searchRank=='OL'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/ol.png">주유</div></li>
                    </c:if>
                    <c:if test="${searchRank=='FD'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/fd.png">요식</div></li>
                    </c:if>
                    <c:if test="${searchRank=='CT'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/ct.png">문화시설</div></li>
                    </c:if>
                    <c:if test="${searchRank=='ED'}">
                        <li class="list-group-item">교육</li>
                    </c:if>
                    <c:if test="${searchRank=='MD'}">
                        <li class="list-group-item">의료</li>
                    </c:if>
                    <c:if test="${searchRank=='CS'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/cs.png">편의점</div></li>
                    </c:if>
                    <c:if test="${searchRank=='UNKNOWN'}">
                        <li class="list-group-item"><div class="rank-list fs-4 mt-3"><img src="../../resources/img/group-code/unknown.png">기타</div></li>
                    </c:if>
                </c:forEach>
            </ol>
        </div>
        <div class="search-history shadow rounded-3">
            <h5 class="strong">검색기록</h5>
            <ul class="list-group list-group-flush fs-5">
                <c:forEach var="searchHistroy" items="${searchHistoryList}" varStatus="status">
                    <li class="list-group-item">
                        <div>
                            <div class="search-place">${searchHistroy.searchPlace}</div>
                            <div class="search-date">${searchHistroy.searchDate}</div>
                        </div>
                        <button class="remove-btn" onclick="updateSearchStatus(this, ${searchHistroy.searchHistoryId})">
                            x
                        </button>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01d27ec9956c4c63f5cc349e94a77412&libraries=services"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var searchPlaceElements = document.querySelectorAll('.search-place');
        for (var i = 0; i < searchPlaceElements.length; i++) {
            searchPlaceElements[i].addEventListener('click', function (event) {
                var searchKeyword = event.target.textContent;
                searchKeywordFunction(searchKeyword);
            });
        }
    });

    function searchKeywordFunction(keyword) {
        var keywordInput = document.getElementById('keywordInput');
        keywordInput.value = keyword;
        searchKeyword();
    }

    var ps_keyword = new kakao.maps.services.Places();

    function searchKeyword() {
        var keyword = document.getElementById('keywordInput').value;
        ps_keyword.keywordSearch(keyword, placesSearchCB_keyword);
    }

    function placesSearchCB_keyword(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/searchResult';

            const inputBenefitData = document.createElement('input');
            inputBenefitData.type = 'hidden';
            inputBenefitData.name = 'benefitData';
            inputBenefitData.value = JSON.stringify(data);
            console.log('inputBenefitData.value' + inputBenefitData.value);
            const inputSearchHistory = document.createElement('input');
            inputSearchHistory.type = 'hidden';
            inputSearchHistory.name = 'searchHistory';
            inputSearchHistory.value = document.getElementById('keywordInput').value;

            form.appendChild(inputBenefitData);
            form.appendChild(inputSearchHistory);
            document.body.appendChild(form);

            form.submit();
        }
    }

    function searchPlaces() {
        if (!currCategory) {
            return;
        }

        placeOverlay.setMap(null);

        removeMarker();

        ps.categorySearch(currCategory, placesSearchCB, {
            useMapBounds: true
        });
    }

    function updateSearchStatus(button, searchHistoryId) {

        var data = {
            searchHistoryId: searchHistoryId
        };

        // Ajax 요청 설정
        $.ajax({
            type: 'POST',
            url: '/updateSearchStatus',
            data: data,
            success: function (response) {
                if (response) {
                    console.log('성공')
                    button.parentElement.style.display = "none";
                } else {

                    alert("업데이트 실패");
                }
            },
            error: function () {

                alert("오류 발생");
            }
        });
    }
</script>
<%@ include file="../include/footer.jsp" %>
</body>
</html>
