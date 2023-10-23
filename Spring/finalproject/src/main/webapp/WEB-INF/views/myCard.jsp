<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>내 카드 관리 페이지</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous">
    <link rel="stylesheet" href="../../resources/css/myCard.css">
    <link rel="stylesheet" href="../../resources/css/font.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- 새로운 DataTables 링크 추가 -->
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<hr>
<div class="card-section">
    <br><br>
    <div class="card-title">
        <h1>내 보유 카드</h1>
        <br>
        <div id="carouselExample" class="carousel carousel-dark slide">
            <div class="carousel-inner border border-2 shadow rounded-5">
                <c:forEach items="${myCardList}" var="card" varStatus="loop">
                    <div class="carousel-item shadow ${loop.first ? 'active' : ''}">
                        <div class="card h-100 mb- border-0">
                            <div class="row h-100 g-0">
                                <div class="col-md-6 d-flex align-items-center justify-content-center">
                                    <img src="../../resources/img/hanacard${card.cardId}.png"
                                         class="img-fluid rounded-start"
                                         alt="...">
                                </div>
                                <div class="col-md-6">
                                    <div class="card-body h-100 d-flex align-items-center justify-content-center">
                                        <ul class="list-group list-group-flush " style="font-size: 1.2vw !important;">
                                            <li class="list-group-item ">
                                                카드 번호:
                                                <span class="hidden-card-number">
                                                    ${card.cardNumber.substring(0, 4)} - **** - **** - ${card.cardNumber.substring(card.cardNumber.length() - 4)}
                                                </span>
                                                <span class="card-number-field" style="display: none">
                                                        ${card.cardNumber.substring(0, 4)} - ${card.cardNumber.substring(4, 8)} - ${card.cardNumber.substring(8, 12)} - ${card.cardNumber.substring(12, card.cardNumber.length())}
                                                </span>

                                            </li>
                                            <c:set var="validationPeriod" value="${card.validationPeriod}"/>

                                            <c:choose>
                                                <c:when test="${not empty validationPeriod}">
                                                    <c:set var="year" value="${card.validationPeriod.substring(0,4)}"/>
                                                    <c:set var="month" value="${card.validationPeriod.substring(5,7)}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="year" value=""/>
                                                    <c:set var="month" value=""/>
                                                </c:otherwise>
                                            </c:choose>
                                            <li class="list-group-item">
                                                카드 유효 기간:
                                                <span class="hidden-card-validation">
                                                 **** 년 ** 월
                                                    </span>
                                                <span class="card-validation-field" style="display: none">
                                                    <c:out value="${year} 년 ${month} 월"/>
                                                    </span>
                                                <br>
                                            </li>
                                            <li class="list-group-item">
                                                카드 등록 날짜:
                                                <fmt:parseDate var="parsedDate" value="${card.cardRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일" /><br>
                                            </li>
                                            <li class="list-group-item">
                                                전월 소비 금액: <fmt:formatNumber value="${card.lastMonthTotal}" type="number" pattern="#,### 원"/>
                                                <br>
                                            </li>
                                            <li class="list-group-item">

                                                <c:if test="${card.cardStatus == 1 }">
                                                    카드 상태: 정상 <br>
                                                </c:if>
                                            </li>
                                        </ul>
                                        <br>
                                        <button class="btn btn-success show-card-number-btn w-75" style="font-size: 1vw">
                                            카드번호/유효기간 보기
                                        </button>
                                        <br>
                                        <button class="btn btn-success show-benefit-btn w-75" style="font-size: 1vw">
                                            내 카드의 혜택 살펴보기
                                        </button>
                                        <input type="hidden" name="lastMonthMoney" value="${card.lastMonthTotal}">
                                        <input type="hidden" name="cardNumber" value="${card.cardNumber}">
                                        <!-- AJAX call 버튼 -->
                                        <button class="btn btn-primary send-card-id-btn" data-card-id="${card.cardId}">
                                            Send Card ID
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                    data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                    data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</div>
<br><br><br><br><br><br>

<div class="modal fade" id="benefitModal" tabindex="-1" role="dialog" aria-labelledby="benefitModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document"> <!-- modal-dialog-centered 추가 -->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="benefitModalLabel">혜택 상세 정보</h5>
                <button type="button" class="close" style="background-color: #00857E; color: white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<br>
<div class="performance-text">내 카드의 실적 관리하기</div>

<div class="performance-text2"><이번 달 현재 사용금액과 실적 진행도 정보></div>

<br><br><br><br>
<div class="container" id="progressContainer">
    <div class="step-bar" id="step-bar">
        <div class="vertical-line"></div>
        <div class="vertical-line"></div>
        <div class="vertical-line"></div>
    </div>
    <div class="speech-bubble">남은 실적까지 :</div>
    <div class="special-bar"></div>
</div>

<br><br><br><br><br><br>
<div class="compare-benefit-box" style="display: none;">
    <div class="compare-benefit-sub shadow border border-3 rounded-3">1</div>

    <div class="compare-benefit-sub shadow border border-3 rounded-3">1</div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">본인인증</h1>
                <button type="button" class="btn-close btn-success" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="auth-form">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <select class="form-select" aria-label="Default select example" id="phone-prefix">
                                <option selected>010</option>
                                <option value="1">010</option>
                                <option value="2">011</option>
                                <option value="3">016</option>
                            </select>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" placeholder="'-'제외하고 입력" aria-label="phone-number"
                                   id="phone-input">
                        </div>
                    </div>
                    <br>
                    <div class="col">
                        <input class="btn btn-success my-3" onclick="sendSmsRequest()" type="button" value="인증번호 발송">
                        <input type="text" class="form-control" placeholder="인증번호 6자리 입력" aria-label="auth-number">
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" onclick="sendAuthNumber()">인증 확인</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
<script>
    function sendAuthNumber() {
        var authNumber = $('input[aria-label="auth-number"]').val();
        console.log(authNumber);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/auth", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

        var data = JSON.stringify({ authNumber: authNumber });

        xhr.send(data);

        xhr.onload = function () {
            if (xhr.status === 200 && xhr.responseText === 'Success') {
                // 모달을 닫습니다.
                $('#myModal').modal('hide');

                var cardItem = $('.carousel-inner').find('.active');

                var cardNumberField = cardItem.find('.card-number-field');
                var hiddenCardNumber = cardItem.find('.hidden-card-number');
                var cardValidationField = cardItem.find('.card-validation-field');
                var hiddenCardValidation = cardItem.find('.hidden-card-validation');

                if (cardNumberField.is(':visible')) {

                    cardNumberField.hide();
                    hiddenCardNumber.show();
                    cardValidationField.hide();
                    hiddenCardValidation.show();
                } else {

                    cardNumberField.show();
                    hiddenCardNumber.hide();
                    cardValidationField.show();
                    hiddenCardValidation.hide();
                }

                alert("인증이 성공적으로 완료되었습니다.");
            } else {

                alert("인증에 실패했습니다. 다시 시도해주세요.");
            }
        };
    }
    function generateRandomSixDigitNumber() {
        const randomNumber = Math.floor(100000 + Math.random() * 900000);

        const sixDigitNumber = randomNumber.toString().padStart(6, '0');

        return sixDigitNumber;
    }

    function sendSmsRequest() {
        var selectedPrefix = document.getElementById("phone-prefix").value;

        var enteredNumber = document.getElementById("phone-input").value;

        var recipientPhoneNumber = selectedPrefix + enteredNumber;

        const randomSixDigitNumber = generateRandomSixDigitNumber();

        console.log(recipientPhoneNumber)
        const requestData = {
            recipientPhoneNumber: recipientPhoneNumber,
            content: `HanaOnePick에서 보내는 인증번호 :` + randomSixDigitNumber,
            randomNumber: randomSixDigitNumber
        };

        // 서버로 POST 요청을 보냅니다.
        fetch('/user/sms', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestData)
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
            })
            .catch(error => {
                // 오류가 발생한 경우 처리합니다.
                console.error('Error sending SMS request:', error);
                alert('인증번호 전송 중 오류가 발생했습니다.');
            });
    }

    $('.show-card-number-btn').click(function () {

        $('#myModal').modal('show');

    });

    $(document).ready(function () {


        // 내 카드의 혜택보기
        $('.show-benefit-btn').click(function () {
            var cardNumber = $(this).closest('.card-body').find('input[name="cardNumber"]').val();
            console.log("cardNumber: " + cardNumber);
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/member/getBenefitList",
                data: {cardNumber: cardNumber},
                success: function (response) {
                    console.log("혜택 조회 결과: " + response);

                    // 모달에 혜택 정보 추가
                    var modalBody = $('#benefitModal').find('.modal-body');
                    modalBody.empty();


                    var groupedBenefits = groupByCardPerformance(response);

                    // 모달에 혜택 정보 추가
                    var modalBody = $('#benefitModal').find('.modal-body');
                    modalBody.empty();


                    for (var performance in groupedBenefits) {
                        var groupBenefits = groupedBenefits[performance];
                        performance = performance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        var groupHtml = '<h5>카드 실적: ' + performance + '원</h5>';



                        var tableHtml = '<table class="table table-bordered">' +
                            '<thead>' +
                            '<tr>' +
                            '<th>업종</th>' +
                            '<th>가맹점 이름</th>' +
                            '<th>혜택 금액</th>' +
                            '<th>혜택 한도</th>' +
                            '<th>혜택 설명</th>' +
                            '</tr>' +
                            '</thead>' +
                            '<tbody>';

                        for (var industryCode in groupBenefits) {
                            var industryBenefits = groupBenefits[industryCode];
                            var storeNames = industryBenefits.map(function (benefit) {
                                return benefit.benefitStoreName;
                            }).join(', ');

                            var benefitAmount = industryBenefits[0].benefitAmount;
                            benefitAmount = benefitAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                            var benefitMax = industryBenefits[0].benefitMax;
                            var industryName = '';
                            if (industryCode === 'CE') {
                                industryName = '카페';
                            } else if (industryCode === 'CS') {
                                industryName = '편의점';
                            } else if (industryCode === 'PT') {
                                industryName = '대중교통';
                            } else if (industryCode === 'MT') {
                                industryName = '대형마트';
                            } else if (industryCode === 'SH') {
                                industryName = '쇼핑';
                            } else if (industryCode === 'OL') {
                                industryName = '주유';
                            } else if (industryCode === 'FD') {
                                industryName = '요식';
                            } else if (industryCode === 'CT') {
                                industryName = '문화시설';
                            } else if (industryCode === 'ED') {
                                industryName = '교육';
                            } else if (industryCode === 'MD') {
                                industryName = '의료';
                            } else if (industryCode === 'AP') {
                                industryName = '항공';
                            } else if (industryCode === 'TR') {
                                industryName = '여행';
                            } else if (industryCode === 'AL') {
                                industryName = '국내가맹점';
                            }

                            let benefitContent = '일치하지 않는 경우'; // 기본값 설정

                            console.log(industryBenefits[0].benefitCode);
                            if (industryBenefits[0].benefitCode === 'DCVC ') {
                                benefitContent = benefitAmount + '원 할인 월 최대 ' + benefitMax + '회';
                            } else if (industryBenefits[0].benefitCode === 'DCPC ') {
                                benefitContent = benefitAmount + '% 할인 월 최대 ' + benefitMax + '회';
                            } else if (industryBenefits[0].benefitCode === 'DCVA ') {
                                benefitContent = benefitAmount + '원 할인 월 최대 ' + benefitMax.toLocaleString() + '원';
                            } else if (industryBenefits[0].benefitCode === 'DCPA ') {
                                benefitContent = benefitAmount + '% 할인 월 최대 ' + benefitMax.toLocaleString() + '원';
                            } else if (industryBenefits[0].benefitCode === 'ACPC ') {
                                benefitContent = benefitAmount + '% 적립 월 최대 ' + benefitMax + '회';
                            } else if (industryBenefits[0].benefitCode === 'ACVC ') {
                                benefitContent = benefitAmount + '원 적립 월 최대 ' + benefitMax + '회';
                            } else if (industryBenefits[0].benefitCode === 'ACPA ') {
                                benefitContent = benefitAmount + '% 적립 월 최대 ' + benefitMax.toLocaleString() + '원';
                            } else if (industryBenefits[0].benefitCode === 'ACVA ') {
                                benefitContent = benefitAmount + '원 적립 월 최대 ' + benefitMax.toLocaleString() + '원';
                            }
                            console.log(industryBenefits[0].benefitCode.substring(2,3));
                            if(industryBenefits[0].benefitCode.substring(2,3)==='P'){
                                benefitAmount = benefitAmount + '%';
                            }else{
                                benefitAmount = benefitAmount.toLocaleString()+ '원';
                            }
                            if(industryBenefits[0].benefitCode.substring(3,4)==='A') {
                                benefitMax = benefitMax.toLocaleString() + '원';
                            }else {
                                benefitMax = benefitMax.toLocaleString() + '회';
                            }


                            tableHtml += '<tr>' +
                                '<td>' + industryName + '</td>' +
                                '<td>' + storeNames + '</td>' + // 콤마로 나열된 가맹점 이름
                                '<td>' + benefitAmount + '</td>' +
                                '<td>' + benefitMax + '</td>' +
                                '<td>' + benefitContent + '</td>' +
                                '</tr>';
                        }


                        tableHtml += '</tbody></table>';
                        groupHtml += tableHtml;
                        modalBody.append(groupHtml);
                    }


                    $('#benefitModal').modal('show');
                },
                error: function (error) {
                    console.log(error);
                }
            });
        });

        function groupByCardPerformance(data) {
            var grouped = {};
            for (var i = 0; i < data.length; i++) {
                var benefit = data[i];
                var performance = benefit.cardPerformance.toString();
                var benefitIndustryCode = benefit.benefitIndustryCode.toString();

                if (!grouped[performance]) {
                    grouped[performance] = {};
                }

                if (!grouped[performance][benefitIndustryCode]) {
                    grouped[performance][benefitIndustryCode] = [];
                }

                grouped[performance][benefitIndustryCode].push(benefit);
            }
            console.log(grouped);
            return grouped;
        }

        function findClosestValues(arr, target) {
            arr = arr.sort((a, b) => a - b);
            var smaller = null;
            var larger = null;

            for (var i = 0; i < arr.length; i++) {
                if (arr[i] < target) {
                    smaller = arr[i];
                } else if (arr[i] >= target) {
                    larger = arr[i];
                    break;
                }
            }
            console.log("smaller: " + smaller);
            console.log("larger: " + larger);
            return [smaller, larger];
        }


        function createBenefitTable(key, valueList) {
            var table = $("<table></table>").addClass('benefit-table');
            var thead = $("<thead></thead>");
            var tbody = $("<tbody></tbody>");

            // Header Creation
            var headerRow = $("<tr></tr>");
            var headers = ["가맹점 이름", "혜택 설명", "혜택 한도"];
            headers.forEach(function(header) {
                headerRow.append($("<th class='fs-4'></th>").text(header));
            });
            thead.append(headerRow);

            var groupedByIndustry = {};
            valueList.forEach(function(item) {
                var industryCode = item.benefitIndustryCode;
                if (!groupedByIndustry[industryCode]) {
                    groupedByIndustry[industryCode] = [];
                }
                groupedByIndustry[industryCode].push(item);
            });


            for (var industryCode in groupedByIndustry) {
                if (groupedByIndustry.hasOwnProperty(industryCode)) {
                    var industryHtml = getIndustryHtml(industryCode);


                    var industryRow = $("<tr class='fs-4 industry-row'></tr>");
                    var industryNameCell = $("<td></td>").html(industryHtml).attr("colspan", headers.length);
                    industryRow.append(industryNameCell);
                    tbody.append(industryRow);


                    groupedByIndustry[industryCode].forEach(function(item) {
                        var row = $("<tr class='fs-4'></tr>");

                        // Benefit Type & Unit Detection
                        var benefitType = item.benefitCode.substring(1, 3) === 'AC' ? '적립 ' : '할인 ';
                        var benefitUnit = item.benefitCode.substring(2, 3) === 'V' ? '원 ' : '% ';
                        var benefitMaxType = item.benefitCode.substring(3, 4) === 'A' ? '최대' + item.benefitMax.toLocaleString() + '원' : '최대' + item.benefitMax.toLocaleString() + '회';


                        var benefitDetails = item.benefitAmount + benefitUnit + benefitType;


                        var data = [item.benefitStoreName, benefitDetails, benefitMaxType];
                        data.forEach(function(value, index) {
                            var td = $("<td></td>").text(value);
                            if(index === 1 || index === 2) {
                                td.addClass("text-end");
                            }
                            row.append(td);
                        });

                        tbody.append(row);
                    });
                }
            }

            table.append(thead).append(tbody);

            return table;
        }
        function getIndustryHtml(code) {
            var srcPath = "../../resources/img/group-code/";
            var imgStyle = 'style="width: 8%; height: 10%; margin-right: 2%"';
            switch (code) {
                case 'CE': return '<img src="' + srcPath + 'ce.png" ' + imgStyle + '>카페';
                case 'CS': return '<img src="' + srcPath + 'cs.png" ' + imgStyle + '>편의점';
                case 'PT': return '<img src="' + srcPath + 'pt.png" ' + imgStyle + '>대중교통';
                case 'MT': return '<img src="' + srcPath + 'mt.png" ' + imgStyle + '>대형마트';
                case 'SH': return '<img src="' + srcPath + 'sh.png" ' + imgStyle + '>쇼핑';
                case 'OL': return '<img src="' + srcPath + 'ol.png" ' + imgStyle + '>주유';
                case 'FD': return '<img src="' + srcPath + 'fd.png" ' + imgStyle + '>요식';
                case 'CT': return '<img src="' + srcPath + 'ct.png" ' + imgStyle + '>문화시설';
                case 'ED': return '<img src="' + srcPath + 'ed.png" ' + imgStyle + '>교육';
                case 'MD': return '<img src="' + srcPath + 'md.png" ' + imgStyle + '>의료';
                case 'AP': return '<img src="' + srcPath + 'ap.png" ' + imgStyle + '>항공';
                case 'TR': return '<img src="' + srcPath + 'tr.png" ' + imgStyle + '>여행';
                case 'AL': return '<img src="' + srcPath + 'al.png" ' + imgStyle + '>국내가맹점';
                default: return '알 수 없음';
            }
        }


        function createBenefitBox(key, valueList) {
            var benefitBox = $("<div class='benefit-box'></div>");

            var groupedByIndustry = {};
            for (var i = 0; i < valueList.length; i++) {
                var item = valueList[i];
                var industryCode = item.benefitIndustryCode;

                if (!groupedByIndustry[industryCode]) {
                    groupedByIndustry[industryCode] = [];
                }

                groupedByIndustry[industryCode].push(item);
            }

            for (var industryCode in groupedByIndustry) {
                if (groupedByIndustry.hasOwnProperty(industryCode)) {
                    var industryGroup = groupedByIndustry[industryCode];
                    let industryName='';

                    if (industryCode === 'CE') {
                        industryName = '카페';
                    } else if (industryCode === 'CS') {
                        industryName = '편의점';
                    } else if (industryCode === 'PT') {
                        industryName = '대중교통';
                    } else if (industryCode === 'MT') {
                        industryName = '대형마트';
                    } else if (industryCode === 'SH') {
                        industryName = '쇼핑';
                    } else if (industryCode === 'OL') {
                        industryName = '주유';
                    } else if (industryCode === 'FD') {
                        industryName = '요식';
                    } else if (industryCode === 'CT') {
                        industryName = '문화시설';
                    } else if (industryCode === 'ED') {
                        industryName = '교육';
                    } else if (industryCode === 'MD') {
                        industryName = '의료';
                    } else if (industryCode === 'AP') {
                        industryName = '항공';
                    } else if (industryCode === 'TR') {
                        industryName = '여행';
                    } else if (industryCode === 'AL') {
                        industryName = '국내가맹점';
                    }

                    var industryKeyBox = $("<div class='benefit-key' style='font-size: 3vh'>" + industryName + "</div>");
                    var industryValueListContainer = $("<div class='benefit-list border border-3'></div>");

                    for (var j = 0; j < industryGroup.length; j++) {
                        var industryItem = industryGroup[j];
                        var industryBenefitCode = industryItem.benefitCode;
                        if(industryBenefitCode.substring(1,3)=='AC'){
                            var benefitType = '적립 '
                        }else{
                            var benefitType = '할인 '
                        }
                        if(industryBenefitCode.substring(2,3)=='V'){
                            var benefitUnit = '원 '
                        }else{
                            var benefitUnit = '% '
                        }
                        if(industryBenefitCode.substring(3,4)=='A'){
                            var benefitMaxType = '최대' + industryItem.benefitMax + '원'
                        }else{
                            var benefitMaxType = '최대' + industryItem.benefitMax + '회'
                        }

                        var industryItemText = industryItem.benefitStoreName + ": " + industryItem.benefitAmount+ benefitUnit + benefitType + benefitMaxType;
                        var industryValueItem = $("<div style='font-size: 2.5vh; list-style-type: none;'>" + industryItemText + "</div>");
                        industryValueListContainer.append(industryValueItem);
                    }

                    var industryBox = $("<div class='industry-box'></div>");
                    industryBox.append(industryKeyBox);
                    industryBox.append(industryValueListContainer);

                    benefitBox.append(industryBox);
                }
            }


            return benefitBox;
        }
        // 카드 아이디를 보내는 Ajax 호출 함수 (카드 실적 가져오기)
        function sendCardId(cardId) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/member/getPerformanceLevel",
                data: {cardId: parseInt(cardId)},
                success: function (response) {
                    console.log("response: " + response);
                    var thisMonthTotal = response.thisMonthTotal; // thisMonthTotal 값을 추출
                    var distinctPerformanceValue = response.distinctPerformanceValue; // distinctPerformanceValue 값을 추출
                    console.log("distinctPerformanceValue: " + distinctPerformanceValue);
                    var closestValues = findClosestValues(distinctPerformanceValue, thisMonthTotal);
                    var smallerValue = closestValues[0];
                    var largerValue = closestValues[1];
                    if(smallerValue === null){
                        smallerValue = 0;
                    }
                    console.log("Smaller Value: " + smallerValue);
                    console.log("Larger Value: " + largerValue);
                    console.log("cardId: " + cardId);
                    console.log("thisMonthTotal: " + thisMonthTotal);

                    updateProgressBar(distinctPerformanceValue, thisMonthTotal);
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/member/compareBenefit",
                        data: JSON.stringify({
                            cardId: cardId,
                            smallerValue: smallerValue,
                            largerValue: largerValue
                        }),
                        contentType: "application/json",
                        success: function (response) {

                            console.log(response);

                            var benefitListMap = response; // 서버에서 받은 데이터가 이미 benefitListMap 형식일 경우

                            var compareBenefitBox = $(".compare-benefit-box");
                            compareBenefitBox.empty();
                            compareBenefitBox.css("display", "block");
                            var benefitBoxes = [];
                            var findMin = 9999999;
                            console.log("benefitListMap의 길이: " + Object.keys(benefitListMap).length);

                            if (Object.keys(benefitListMap).length === 1) {
                                console.log("실적등급이 하나");
                                console.log(benefitListMap);
                                //map의 key값 추출
                                for (var key in benefitListMap) {
                                    if(key < thisMonthTotal){
                                        findMin = key;
                                    }
                                }
                            } else {
                                console.log("실적등급이 하나 이상");
                                var findMin = null;
                                for (var key in benefitListMap) {
                                    if (findMin === null || key < findMin) {
                                        findMin = key;
                                    }
                                }
                            }


                            for (var key in benefitListMap) {
                                if (benefitListMap.hasOwnProperty(key)) {
                                    var valueList = benefitListMap[key];
                                    var benefitTable = createBenefitTable(key, valueList);
                                    var cardPerformanceBox = $("<div class='compare-benefit-sub border border-3 rounded-3'></div>").css("overflow", "auto");

                                    if (key == findMin) {
                                        cardPerformanceBox.append("<h2 class='p-3' style='text-align: center; background-color: #5f7d7b; color: white'>현재 다음 달에 받을 수 있는 혜택</h2>");
                                    } else {
                                        cardPerformanceBox.append("<h2 class='p-3' style='text-align: center; background-color: #ffbf14; color: white'>다음 등급 혜택</h2>");
                                    }

                                    cardPerformanceBox.append(benefitTable);
                                    compareBenefitBox.append(cardPerformanceBox);
                                }
                            }


                            compareBenefitBox.css({
                                "display": "flex",
                                "flex-wrap": "wrap",
                                "justify-content": "center",
                                "align-items": "center"
                            });

                            console.log("Data sent to server successfully.");
                        },
                        error: function (error) {
                            console.log("Error sending data to server: " + error);
                        }
                    });

                    setTimeout(function() {
                        var tables = $(".compare-benefit-box .benefit-table");
                        if(tables.length < 2) return;

                        var leftTableRows = $(tables[0]).find("tbody tr");
                        var rightTableRows = $(tables[1]).find("tbody tr");

                        leftTableRows.each(function(index) {
                            var leftRow = $(this);
                            var rightRow = rightTableRows.eq(index);

                            var leftBenefitDescription = leftRow.find("td:eq(1)").text();
                            var rightBenefitDescription = rightRow.find("td:eq(1)").text();

                            var leftBenefitLimit = leftRow.find("td:eq(2)").text();
                            var rightBenefitLimit = rightRow.find("td:eq(2)").text();

                            if(leftBenefitDescription != rightBenefitDescription) {
                                leftRow.find("td:eq(1)").css("color", "red");
                                rightRow.find("td:eq(1)").css("color", "blue");
                            }
                            if(leftBenefitLimit != rightBenefitLimit) {
                                leftRow.find("td:eq(2)").css("color", "red");
                                rightRow.find("td:eq(2)").css("color", "blue");
                            }
                        });
                    }, 100);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }


        function drawVerticalLines(numbers, referenceNumber, lastMonthTotal) {
            var stepBar = $("#step-bar");
            stepBar.empty();

            var referencePosition = (lastMonthTotal / referenceNumber) * 100;


            var moneyBarLeftOffsetInStepBar = stepBar.width() * (referencePosition / 100);
            var stepBarOffsetInContainer = ($("#progressContainer").width() - stepBar.width()) / 2;

            var moneyBarTotalOffset = moneyBarLeftOffsetInStepBar + stepBarOffsetInContainer;

            $('.speech-bubble').css('left', moneyBarTotalOffset - ($('.speech-bubble').width() / 2) + "px");

            var maxLabel = Math.max.apply(null, numbers);

            for (var j = 0; j < numbers.length; j++) {
                var position = (numbers[j] / referenceNumber) * 100;
                var label = numbers[j];

                console.log('label', label);
                stepBar.append('<div class="vertical-line" style="left: ' + position + '%;"><div class="label">' + label.toLocaleString() + '원</div></div>');
            }



            if(referencePosition < 100) {
                stepBar.append('<div class="special-bar" style="width: ' + referencePosition + '%;"></div>');
            }else{
                stepBar.append('<div class="special-bar" style="width: 100%;"></div>');

            }
            if(lastMonthTotal < maxLabel){
                stepBar.append('<div class="vertical-line reference" id="money-bar" style="left: ' + referencePosition + '%;"><div class="label"><div class="lastMonthTotal">이번 달 사용금액: ' + lastMonthTotal.toLocaleString() + '원</div></div></div>');
            }else{
                stepBar.append('<div class="vertical-line reference" id="money-bar" style="left: 100%;"><div class="label"><div class="lastMonthTotal" style="background-color: rgba(114,115,246,0.56); padding: 5%">이번 달' + '<br>' + '실적 달성!</div></div></div>');
                stepBar.append('<br><br><div style="font-size: 2.5vh;"> 이번 달 사용금액: ' + lastMonthTotal.toLocaleString() + '원</div>');
                $(".special-bar").css("background-color", "rgb(114,115,246)");
                var specialBar = document.querySelector('.special-bar');
                var progressContainer = document.createElement('div');
                progressContainer.textContent='축하합니다 이번 달 실적을 달성하셨습니다!';
                $("startButton").trigger("click");
                setTimeout(function () {
                    $("stopButton").trigger("click");
                }, 6000);
                progressContainer.className='progressContainer';
                specialBar.appendChild(progressContainer);

            }
        }

        function updateProgressBar(performanceValue, money) {
            var progressBar = $("#progressContainer .progressbar");
            progressBar.empty(); // Clear existing items
            progressBar.append('<li class="active">0</li>');

            for (var i = 0; i < performanceValue.length; i++) {
                var pfv = performanceValue[i];
                console.log("pfv: " + pfv);
                progressBar.append('<li class="active">' + pfv + '</li>');
            }

            // performanceValue에서 money를 뺀 결과 중 양수만 filter로 걸러내고, 그 중 최소값을 구함
            var differences = performanceValue.map(pfv => pfv - money).filter(diff => diff > 0);
            var minPositiveDifference = Math.min(...differences);
            console.log("minPositiveDifference : " + minPositiveDifference)
            if (minPositiveDifference == 'Infinity') {
                $('.speech-bubble').css('display', 'none');
            } else {
                $('.speech-bubble').text('남은 실적까지 : ' + minPositiveDifference.toLocaleString() + ' 원');
            }
            drawVerticalLines(performanceValue, Math.max(...performanceValue), money);
        }


        function updateOnSlideChange() {
            var activeSlide = $(".carousel-item.active");
            var currentCardIdBtn = activeSlide.find(".send-card-id-btn");

            if (currentCardIdBtn.length > 0) {
                var cardId = currentCardIdBtn.data("card-id");
                var lastMonthTotal = activeSlide.find('input[name="lastMonthMoney"]').val();
                var cardNumber = activeSlide.find('input[name="cardNumber"]').val();
                sendCardId(cardId, lastMonthTotal);

            }
        }

        $("#carouselExample").on('slid.bs.carousel', updateOnSlideChange);


    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
<br><br>
<hr>


<%@ include file="../include/footer.jsp" %>
</body>
</html>