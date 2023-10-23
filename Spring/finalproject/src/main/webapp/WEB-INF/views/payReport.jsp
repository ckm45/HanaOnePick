<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>소비 분석 페이지</title>
    <link rel="stylesheet" href="../../resources/css/payReport.css">
    <link rel="stylesheet" href="../../resources/css/font.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<%@ include file="../include/header.jsp" %>
<hr>
<!-- chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
<%--<div class="main-section"> --%>
<%
    java.util.Date today = new java.util.Date();
    pageContext.setAttribute("today", today);
%>

<div class="main-section">
    ${sessionScope.dto.name}님의 1년간의 소비내역입니다.
    <fmt:formatDate var="currentDate" value="${today}" pattern="yyyy-MM-dd"/>
    <p class="fs-5">2023-10-14 기준 1년입니다.</p>
</div>

<div class="chart-div border border-3 round rounded-5 shadow p-3">
    <div class="chart-section">
        <canvas id="myChart"></canvas>

    </div>
    <div id="legend" class="chart-legend">

    </div>
</div>
<br><br>
<div class="desc-payChart border border-3 p-3">
    <c:set var="totalAmount" value="0"/>
    <c:forEach items="${totalChart}" var="item" varStatus="loop">
        <c:set var="totalAmount" value="${totalAmount + item.transactionAmount}" />
    </c:forEach>
    총 합산 금액: <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,### 원"/>
</div>

<div class="rec-card-button" type="button" onclick="clickRecCardBtn()">
    <img src="../../resources/img/search-logo.png">내게 맞는 카드 추천 받기
</div>
<div class="benefit-result-title fs-4"><카드별 1년간의 혜택 현황></div>
<div class="benefit-result" style="display: none;">
</div>
<div class="benefit-result-card"></div>
<img src="../../resources/img/loadingImg.gif" id="loadingImage" style="display: none;">
<script>

    var labels = [];
    var data = [];

    <c:forEach var="item" items="${totalChart}" varStatus="loop">
    var label = '';
    var transactionIndustryCode = '${item.transactionIndustryCode}'; // JSP 변수를 JavaScript 변수로 할당
    if (transactionIndustryCode === 'SH') {
        label = '쇼핑';
    } else if (transactionIndustryCode === 'FD') {
        label = '음식';
    } else if (transactionIndustryCode === 'CT') {
        label = '문화시설';
    } else if (transactionIndustryCode === 'CS') {
        label = '편의점';
    } else if (transactionIndustryCode === 'CE') {
        label = '카페';
    } else if (transactionIndustryCode === 'MT') {
        label = '대형마트';
    } else if (transactionIndustryCode === 'PT') {
        label = '대중교통';
    } else if (transactionIndustryCode === 'OL') {
        label = '주유';
    } else if (transactionIndustryCode === 'ED') {
        label = '교육';
    } else if (transactionIndustryCode === 'AP') {
        label = '항공';
    } else if (transactionIndustryCode === 'TR') {
        label = '여행';
    } else if (transactionIndustryCode === 'MD') {
        label = '의료';
    } else if (transactionIndustryCode === 'AL') {
        label = '기타 국내가맹점';
    }
    labels.push(label);
    data.push(${item.transactionAmount});
    </c:forEach>

    var ctx = document.getElementById('myChart').getContext('2d');
    var myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(255, 205, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(201, 203, 207, 0.2)',
                    'rgba(255, 99, 71, 0.2)',
                    'rgba(50, 205, 50, 0.2)',
                    'rgba(138, 43, 226, 0.2)',
                    'rgba(127, 255, 212, 0.2)',
                    'rgba(222, 49, 99, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(255, 205, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(201, 203, 207, 1)',
                    'rgba(255, 99, 71, 1)',
                    'rgba(50, 205, 50, 1)',
                    'rgba(138, 43, 226, 1)',
                    'rgba(127, 255, 212, 1)',
                    'rgba(222, 49, 99, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            title: {
                display: true,
                text: '< 1년치 지출 분포 >'
            },
            legend: {
                display: false,
            },
            legendCallback: function (chart) {
                var text = [];
                text.push('<ul>');
                var data = chart.data.datasets[0].data;
                var backgroundColors = chart.data.datasets[0].backgroundColor;
                var labels = chart.data.labels;

                for (var i = 0; i < labels.length; i++) {
                    text.push('<li>');
                    text.push('<span class="legend-color" style="background-color:' + backgroundColors[i] + '"></span>');
                    text.push('<span class="legend-label">' + labels[i] + '</span>');
                    text.push('<span class="legend-price">' + data[i].toLocaleString() + ' 원</span>');
                    text.push('</li>');
                }

                text.push('</ul>');
                return text.join('');
            }
        }
    });

    document.getElementById('legend').innerHTML = myPieChart.generateLegend();
    var benefitAmount = 0;
        function getBenefitSum() {
            document.getElementById('loadingImage').style.display = 'block';
            $.ajax({
                type: "GET",
                url: "/member/getBenefitSum",
                success: function (data) {

                    console.log("getBenefitSum() : " , data);
                    var benefitContainer = $('.benefit-result');
                    var discountAmountSum = 0;
                    var accumulatedAmountSum = 0;
                    for (var i = 0; i < data.length; i++) {
                        var card = data[i];
                        discountAmountSum += card.discountAmount;
                        accumulatedAmountSum += card.accumulatedAmount;
                        var discountOrAccumulatedText = card.discountAmount != 0 ?
                            '할인 받은 금액: ' + card.discountAmount.toLocaleString() + '원' :
                            '적립 받은 금액:' + card.accumulatedAmount.toLocaleString() + '원';

                        var cardDiv = '<div class="card">' +
                            '<div class="card-body">' +
                            '<img src="../../resources/img/hanacard' + card.cardId + '.png" alt="' + card.cardName + '" style="margin-bottom: 2%">' +
                            '<h5 class="card-title">' + card.cardName + '</h5>' +
                            '<h6 class="card-subtitle mb-2 text-muted">' + card.cardSubTitle + '</h6>' +
                            '<p class="card-text">' + discountOrAccumulatedText + '</p>' +
                            '</div>' +
                            '</div>';
                        benefitContainer.append(cardDiv);
                    }
                    var formattedDiscountAmount = discountAmountSum.toLocaleString('en-US');
                    var formattedAccumulatedAmount = accumulatedAmountSum.toLocaleString('en-US');
                    var resultCardDiv = '<p class="mt-2">1년간 총 ' + formattedDiscountAmount + '원을 할인 받고, ' + formattedAccumulatedAmount + '원을 적립했어요!</p>';
                    benefitContainer.append(resultCardDiv);

                    benefitAmount = discountAmountSum + accumulatedAmountSum;
                    getRecCard();
                },
                error: function () {
                    console.log("AJAX 요청 실패!");
                }
            });
        }

    function getRecCard() {
        $.ajax({
            type: "GET",
            url: "/member/getRecCard",
            success: function (data) {
                var benefitContainer = $('.benefit-result');
                benefitContainer.addClass('d-flex flex-wrap justify-content-center');
                document.querySelector('.benefit-result-title').style.display = 'block';
                document.querySelector('.benefit-result').style.display = 'block';
                document.getElementById('loadingImage').style.display = 'none';
                console.log("getRecCard() : " + data);
                var cardId = data.cardId;
                var cardName = data.cardName;
                var cardSubtitle = data.cardSubTitle;
                var cardTypeCode = data.cardTypeCode;
                var annualFee = data.annualFee;
                var discountAmount = data.discountAmount;
                console.log("cardId : " + cardId + ", cardName : " + cardName + ", cardSubtitle : " + cardSubtitle + ", cardTypeCode : " + cardTypeCode + ", annualFee : " + annualFee + ", discountAmount : " + discountAmount);
                console.log(data)
                var cardHtml ='<h3>이런 카드는 어떠세요?</h3>'+
                    '<img src="../../resources/img/hanacard' + cardId + '.png" alt="' + cardName + '" style="margin-bottom: 2%">' +
                    '<h2>[신용] ' + cardName + '</h2>' +
                    '<p>연회비: ' + annualFee.toLocaleString() + '원</p>' +
                    '<p>분석결과 같은 소비 대비</p>' +
                    '<p style="color: red">' + (discountAmount - benefitAmount).toLocaleString() + '원 할인을 더 받을 수 있어요!</p>';


                $('.benefit-result-card').html(cardHtml);
                document.querySelector('.benefit-result-card').style.display = 'block';

                document.getElementById('loadingImage').style.display = 'none';
            },
            error: function () {

                console.log("AJAX 요청 실패!");
            }
        });
    }

function clickRecCardBtn(){
    getBenefitSum();
}

</script>


<br><br><br><br><br>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
