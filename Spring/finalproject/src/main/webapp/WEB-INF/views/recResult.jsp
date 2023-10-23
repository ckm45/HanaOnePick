<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>추천 결과 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="../resources/css/recResult.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<br>
<hr>
<div class="modal fade modal-xl" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">스타벅스 메뉴</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
                        <div class="col" onclick="toggleMenuItem('돌체 콜드 브루',6000)">
                            <div class="p-3"><img src="../../resources/shop3/img/돌체%20콜드%20브루.jpg"></div>
                            <div id="돌체 콜드 브루">돌체 콜드 브루</div>
                            <div>6,000원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('딸기 딜라이트 요거트 블렌디드',6300)">
                            <div class="p-3"><img src="../../resources/shop3/img/딸기%20딜라이트%20요거트%20블렌디드.jpg"></div>
                            <div id="딸기 딜라이트 요거트 블렌디드">딸기 딜라이트 요거트 블렌디드</div>
                            <div>6,300원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('망고 패션 티 블렌디드',5400)">
                            <div class="p-3"><img src="../../resources/shop3/img/망고%20패션%20티%20블렌디드.jpg"></div>
                            <div id="망고 패션 티 블렌디드">망고 패션 티 블렌디드</div>
                            <div>5,400원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('아이스 자몽 허니 블랙 티',5700)">
                            <div class="p-3"><img src="../../resources/shop3/img/아이스%20자몽%20허니%20블랙%20티.jpg"></div>
                            <div id="아이스 자몽 허니 블랙 티">아이스 자몽 허니 블랙 티</div>
                            <div>5,700원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('아이스 카페 아메리카노',4500)">
                            <div class="p-3"><img src="../../resources/shop3/img/아이스%20카페%20아메리카노.jpg"></div>
                            <div id="아이스 카페 아메리카노">아이스 카페 아메리카노</div>
                            <div>4,500원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('제주 시트러스 허니 콜드 브루',7200)">
                            <div class="p-3"><img src="../../resources/shop3/img/제주%20시트러스%20허니%20콜드%20브루.jpg"></div>
                            <div id="제주 시트러스 허니 콜드 브루">제주 시트러스 허니 콜드 브루</div>
                            <div>7,200원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('제주 유기농 말차로 만든 크림 프라푸치노',6300)">
                            <div class="p-3"><img src="../../resources/shop3/img/제주%20유기농%20말차로%20만든%20크림%20프라푸치노.jpg">
                            </div>
                            <div id="제주 유기농 말차로 만든 크림 프라푸치노">제주 유기농 말차로 만든 크림 프라푸치노</div>
                            <div>6,300원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('콜드 브루',4900)">
                            <div class="p-3"><img src="../../resources/shop3/img/콜드%20브루.jpg"></div>
                            <div id="콜드 브루">콜드 브루</div>
                            <div>4,900원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('부드러운 생크림 카스텔라',4500)">
                            <div class="p-3"><img src="../../resources/shop3/img/부드러운%20생크림%20카스텔라.jpg"></div>
                            <div id="부드러운 생크림 카스텔라">부드러운 생크림 카스텔라</div>
                            <div>4,500원</div>
                        </div>
                        <div class="col" onclick="toggleMenuItem('레드벨벳 크림치즈 케이크',5500)">
                            <div class="p-3"><img src="../../resources/shop3/img/레드벨벳%20크림치즈%20케이크.jpg"></div>
                            <div id="레드벨벳 크림치즈 케이크">레드벨벳 크림치즈 케이크</div>
                            <div>5,500원</div>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="fs-4">
                    담은 메뉴: <span id="selectedMenus"></span>
                    <br>
                    결제 예정 금액: <span id="totalPrice">0</span>원
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn" style="color: black" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn" style="color: black" onclick="onApplyButtonClicked();"
                            data-bs-dismiss="modal">입력
                    </button>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="result-title">
    <div class="fs-2">검색 내용 : ${searchStore}</div>
    <c:choose>
        <c:when test="${searchStore.contains('스타벅스')}">
            <button type="button" class="btn btn-success p-3 m-3 fs-4" style="width: 8vw" data-bs-toggle="modal"
                    data-bs-target="#exampleModal">
                메뉴보기
            </button>
        </c:when>
    </c:choose>


    <br><br>
    <h5>결제 금액을 입력해주세요.</h5>
    <div class="calculator">
        <img src="../../resources/img/calculator.png"><input type="text" class="styled-input" id="paymentAmountInput"
                                                             placeholder="결제 금액 입력"/> 원
    </div>

</div>
<script type="text/javascript"
        src="../../resources/js/recResult.js"></script>
<link rel="stylesheet" href="../../resources/css/font.css">
<hr>
<div class="accordion-section">
    <c:forEach var="searchData" items="${searchDataList}" varStatus="status">
        <c:if test="${status.index < 5}">
            <button class="accordion fs-4">${searchData.place_name}</button>
            <c:forEach items="${benefitList}" var="benefits">
                <div class="panel">
                    <c:forEach var="benefit" items="${benefits}">
                        <c:choose>
                            <c:when test="${not empty benefit}">
                                <c:choose>
                                    <c:when test="${not empty benefit.benefitCode}">
                                        <!-- Horizontal -->
                                        <div class="card mb-3">
                                            <div class="row g-0">
                                                <div class="col" style="padding: 5%;">
                                                    <img src="../../resources/img/hanacard${benefit.cardId}.png"
                                                         class="img-fluid rounded-start h-100"
                                                         alt="...">
                                                </div>
                                                <div class="col-6">
                                                    <div class="card-body" data-benefitCode="${benefit.benefitCode}"
                                                         data-benefitAmount="${benefit.benefitAmount}"
                                                         data-benefitMax="${benefit.benefitMax}">
                                                        <h5 class="card-title"><img class="rank-icon" src=""
                                                                                    alt="Ranking Icon"
                                                                                    style="width: 10%">${benefit.cardName}
                                                        </h5>
                                                        <p class="card-text fs-4">${benefit.cardSubtitle}</p>
                                                        <p class="card-text expected-benefit fs-5">예상 혜택 금액</p>
                                                        <!-- 예상 혜택 금액을 표시할 공간 -->
                                                        <p class="card-text fs-4">혜택 종류 :
                                                            <c:choose>
                                                                <c:when test="${(benefit.benefitCode).substring(0,2) == 'AC'}">
                                                                    적립
                                                                </c:when>
                                                                <c:when test="${(benefit.benefitCode).substring(0,2)== 'DC'}">
                                                                    할인
                                                                </c:when>
                                                                <c:otherwise>
                                                                    기타
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="card-text fs-4">
                                                            <c:choose>
                                                                <c:when test="${(benefit.benefitCode).substring(3,4)== 'C'}">
                                                                    혜택 한도 : ${benefit.benefitMax}회
                                                                </c:when>
                                                                <c:otherwise>
                                                                    혜택 한도 : 최대 <fmt:formatNumber value="${benefit.benefitMax}" type="number" pattern="#,### 원"/>
<%--                                                                    혜택 한도 : 최대 ${benefit.benefitMax}원--%>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="card-text fs-4" style="color:blue;">
                                                            <c:choose>
                                                                <c:when test="${(benefit.benefitCode).substring(2,3)== 'P'}">
                                                                    <c:choose>
                                                                        <c:when test="${(benefit.benefitCode).substring(0,2) == 'AC'}">
                                                                            적립률: ${benefit.benefitAmount}%
                                                                        </c:when>
                                                                        <c:when test="${(benefit.benefitCode).substring(0,2) == 'DC'}">
                                                                            할인률: ${benefit.benefitAmount}%
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${(benefit.benefitCode).substring(0,2) == 'AC'}">
                                                                            적립 금액 : ${benefit.benefitAmount}원
                                                                        </c:when>
                                                                        <c:when test="${(benefit.benefitCode).substring(0,2) == 'DC'}">
                                                                            할인 금액 : ${benefit.benefitAmount}원
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col border border-3 m-1 p-1">
                                                    <c:forEach var="benefitCountMap" items="${benefitCountList}">
                                                        <c:choose>
                                                            <c:when test="${benefitCountMap[benefit.cardId] != null}">
                                                                <c:set var="benefitCountValue"
                                                                       value="${benefitCountMap[benefit.cardId]}"/>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <div class="card-title mt-3 ms-3">
                                                        <혜택 사용 현황>
                                                    </div>
                                                    <span class="fs-5">이번 달 사용량</span>
                                                    <br>
                                                    <c:set var="isCountType"
                                                           value="${benefit.benefitCode.substring(3,4) == 'C'}"/>
                                                    <c:set var="isExceededMax"
                                                           value="${benefit.benefitMax < benefitCountValue}"/>

                                                    <c:choose>
                                                        <c:when test="${isCountType}">
                                                            <span class="fs-4">최대 ${benefit.benefitMax}회 중 <br>
                                                                <c:choose>
                                                                    <c:when test="${isExceededMax}">${benefit.benefitMax}</c:when>
                                                                    <c:otherwise>${benefitCountValue}</c:otherwise>
                                                                </c:choose>
                                                            회 사용</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="fs-4">
                                                                최대 <fmt:formatNumber value="${benefit.benefitMax}" type="number" pattern="#,### 원"/> 중 <br>
<%--                                                                최대 ${benefit.benefitMax}원 중 <br>--%>
                                                                <c:choose>
                                                                    <c:when test="${isExceededMax}"><fmt:formatNumber value="${benefit.benefitMax}" type="number" pattern="#,### 원"/> </c:when>
                                                                    <c:otherwise><fmt:formatNumber value="${benefitCountValue}" type="number" pattern="#,### 원"/></c:otherwise>
                                                                </c:choose>
                                                            원 사용</span>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <br>

                                                    <c:choose>
                                                        <c:when test="${isExceededMax}">
                                                            <span class="fs-5" style="color: red">이번달 혜택을<br> 모두 사용했습니다</span>
                                                        </c:when>
                                                        <c:otherwise>
        <span class="fs-4" style="color: #00a876">
            ${benefit.benefitMax - benefitCountValue}
            <c:choose>
                <c:when test="${isCountType}">회</c:when>
                <c:otherwise>원</c:otherwise>
            </c:choose>
            <br>사용가능합니다
        </span>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- benefit.benefitCode가 null일 때 실행될 내용 -->
                                        <div class="card mb-3">
                                            <div class="row g-0">
                                                <div class="col" style="padding: 5%;">
                                                    <img src="../../resources/img/hanacard${benefit.cardId}.png"
                                                         class="img-fluid rounded-start h-100"
                                                         alt="...">
                                                </div>
                                                <div class="col-6">
                                                    <c:set var="cardId" value="${benefit.cardId}"/>
                                                    <c:set var="thisMonthTotalVarName"
                                                           value="thisMonthTotal${cardId}"/>
                                                    <c:set var="thisMonthTotal"
                                                           value="${sessionScope[thisMonthTotalVarName]}"/>
                                                    <div class="card-body">
                                                        <div class="not-benefit-title shadow border rounded">
                                                            <img src="../../resources/img/manage-card.png"> 실적을
                                                            관리해보세요!
                                                        </div>
                                                        <h5 class="card-title">${benefit.cardName}</h5>
                                                        <p class="card-text fs-4">${benefit.cardSubtitle}</p>
                                                        <p class="card-text expected-benefit fs-4">
                                                            <c:if test="${thisMonthTotal == null}">
                                                                이번달 사용금액: 0원
                                                            </c:if>
                                                            <c:if test="${thisMonthTotal != null}">
                                                                이번달 사용금액: ${thisMonthTotal}원
                                                            </c:if>
                                                        </p>
                                                        <p class="card-text fs-4">
                                                            다음실적등급 금액: ${benefit.cardPerformance}원
                                                        </p>

                                                        <p class="card-text fs-4 border border-4 rounded bg-light bg-gradient fw-bold"
                                                           style="color: #e3b342; width: fit-content; padding-left: 1.5%; padding-right: 1.5%;">
                                                            다음등급까지 : ${benefit.cardPerformance - thisMonthTotal}원
                                                            남았습니다!
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col border border-3 m-1 p-1">
                                                    <div class="card-title mt-3 ms-3">
                                                        <혜택 사용 현황>
                                                    </div>
                                                    <span class="fs-5">받을 수 있는 혜택이 없습니다</span>
                                                    <span class="fs-5">실적을 채워보세요!</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:forEach>
        </c:if>
    </c:forEach>
</div>

<script>
    $(document).ready(function () {
        updateImageDisplay();

        $("#paymentAmountInput").on("input", updateImageDisplay);
    });



    function updateImageDisplay() {
        if (!$("#paymentAmountInput").val()) {
            $(".rank-icon").hide();
        } else {
            $(".rank-icon").show();
        }
    }


    let selectedItems = [];
    let totalPrice = 0;

    function onApplyButtonClicked() {
        setPaymentAmount();
        applyBenefits();
    }

    function toggleMenuItem(menuName, price) {
        const index = selectedItems.indexOf(menuName);
        if (index > -1) {

            selectedItems.splice(index, 1);
            totalPrice -= price;
        } else {
            selectedItems.push(menuName);
            totalPrice += price;
        }
        updateMenuDisplay();
        updatePriceDisplay();
    }

    function updateMenuDisplay() {
        document.getElementById('selectedMenus').textContent = selectedItems.join(', ');
    }

    function updatePriceDisplay() {
        document.getElementById('totalPrice').textContent = totalPrice.toLocaleString();
    }

    document.getElementById('exampleModal').addEventListener('hidden.bs.modal', function () {
        selectedItems = [];
        totalPrice = 0;
        updateMenuDisplay();
        updatePriceDisplay();
    });

    function setPaymentAmount() {

        var totalPrice = document.getElementById("totalPrice").innerText;


        document.getElementById("paymentAmountInput").value = totalPrice;

        updateImageDisplay();
    }


    var acc = document.getElementsByClassName("accordion");
    var i;

    for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + 30 + "px";
            }
        });
    }
</script>

</body>

</html>
