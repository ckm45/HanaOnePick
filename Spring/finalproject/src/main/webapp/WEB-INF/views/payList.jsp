<%@ page import="com.kopo.finalproject.model.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>거래내역 페이지</title>
    <link rel="stylesheet" href="../../resources/css/payList.css">
    <link rel="stylesheet" href="../../resources/css/font.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

    <!-- Datepicker CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

</head>
<body>
<%@ include file="../include/header.jsp" %>
<!-- Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<!-- chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
<hr>
<div class="search-transactions">
    카드이용내역
    <br>
    <hr class="transaction-hr">
    <div class="search-transactions-section">
        <div class="select-card">
            <div class="select-card-title">카드 선택</div>
            <div class="card-list" data-card-number="">전체</div>
            <c:forEach items="${myCardList}" var="card">
                <div class="card-list" data-card-number="${card.cardNumber}">${card.cardName}</div>
            </c:forEach>
        </div>
        <div class="modal fade" id="dateRangeModal" tabindex="-1" role="dialog" aria-labelledby="dateRangeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" style="width: fit-content" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding: 0.5rem 1rem;">
                        <h5 class="modal-title" id="dateRangeModalLabel" style="line-height: 1.5;">조회 기간</h5>
                        <button type="button" class="close" style="line-height: 1.5; font-size: 1rem;"
                                data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-row row">
                            <div class="col-md-4 form-group">
                                <div class="input-group">
                                    <label for="startDate" class="fs-4"></label>
                                    <input type="text" id="startDate" class="datepicker form-control h-75"
                                           placeholder="시작 날짜">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"
                                                                          style="height: 2.3vh !important;"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1 form-group h-50 fs-3" style="align-items: center; text-align: center">
                                ~
                            </div>
                            <div class="col-md-4 form-group">
                                <div class="input-group">
                                    <input type="text" id="endDate" class="datepicker form-control h-75"
                                           placeholder="종료 날짜">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"
                                                                          style="height: 2.3vh !important;"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-dark w-75" id="applyDateRange">조회</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="select-date">
            <div class="select-card-title">조회 기간
                <button style="margin-left: 38%; padding: 5px 10px; font-size: 0.8vw">직접 입력</button>
            </div>
            <div class="date-list">전체 기간</div>
            <div class="date-list">이번 달</div>
            <div class="date-list">2주</div>
            <div class="date-list">1개월</div>
            <div class="date-list">3개월</div>
        </div>
        <div class="select-button" type="button">조회</div>
    </div>
</div>
<input type="hidden" id="selected-card-name" name="selectedCardName">
<input type="hidden" id="selected-card-number" name="selectedCardNumber">
<input type="hidden" id="selected-date-range" name="selectedDateRange">
<br>
<div class="result-transactions">

    <div class="card mb-4 mx-auto w-100" id="table-box">
        <div class="card-header">
            <i class="fas fa-table me-1"></i>
            <% MemberDTO dto = (MemberDTO) session.getAttribute("dto"); %><%=dto.getName()%>님의 거래내역
        </div>
        <div class="card-body">
            <table id="datatablesSimple" class="cell-border">
                <thead>
                <tr>
                    <th>결제 시간</th>
                    <th>결제 카드번호</th>
                    <th>결제 업종</th>
                    <th>결제 장소</th>
                    <th>결제 금액</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<div class="chart-transactions" style="margin-bottom: 40%">
    <div class="shadow p-3 border-3 mb-3">
        <div class="fs-3 mb-3 p-3">업종별 사용 금액</div>
        <table class="table table-hover table-bordered table-striped w-75 mx-auto fs-4">
            <thead class="thead-dark">
            <tr>
                <th>거래 업종</th>
                <th style="text-align: right">금액</th>
            </tr>
            </thead>
            <tbody id="tableBody" class="table-group-divider">

            </tbody>
            <tfoot class="table-striped-columns">
            <tr>
                <td>합계</td>
                <td id="totalAmount">0</td>
            </tr>
            </tfoot>
        </table>
    </div>
    <div class="accordion mb-5" id="accordionExample">
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button fs-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseOne"
                        aria-expanded="true" aria-controls="collapseOne">
                    카드 이용 내역 한눈에 보기
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                    <canvas id="myChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- TransactionDetail Modal -->
<div class="modal fade shadow" id="transactionDetailModal" tabindex="-1" aria-labelledby="transactionDetailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #00857E">
                <h4 class="modal-title" style="color: white" id="transactionDetailModalLabel">거래 내역 상세 정보</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>카드 번호:</strong> <span id="cardNumber"></span></p>
                <p><strong>거래 유형:</strong> <span id="transactionType">국내일반</span></p>
                <p><strong>거래 날짜:</strong> <span id="transactionDate"></span></p>
                <p><strong>취소 일시:</strong></p>
                <hr>
                <p><strong>거래 금액:</strong> <span id="transactionAmount"></span></p>
                <p><strong>받은 혜택:</strong> <span id="benefitAmount"></span></p>
                <br>
                <hr>
                <p><strong>가맹점 명:</strong> <span id="transactionStoreName"></span></p>
                <p><strong>업종:</strong> <span id="transactionIndustryCode"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
    var startDate = "";
    var endDate = "";
    $(document).ready(function () {
        // Datepicker 초기화
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            language: 'ko',
            showButtonPanel: true,
            todayHighlight: true
        });

        // "직접 입력" 버튼 클릭 시 모달 표시
        $('.select-card-title button').click(function () {
            $('#dateRangeModal').modal('show');
        });


    });

    // "전체"를 클릭한 경우 모든 카드를 선택 또는 해제
    $(".card-list[data-card-number='']").click(function () {
        // "전체"의 현재 선택 상태 확인
        var isChecked = $(this).hasClass("clicked");

        // 모든 카드 선택 또는 해제
        $(".card-list[data-card-number!='']").each(function () {
            if (!isChecked) {
                $(this).addClass("clicked");
                $(this).css("background-color", "lightgray");
            } else {
                $(this).removeClass("clicked");
                $(this).css("background-color", ""); // 원래 색으로 변경
            }
        });

        // "전체"의 선택 상태 토글
        $(this).toggleClass("clicked");

        // "전체"의 배경색을 변경
        if (!isChecked) {
            $(this).css("background-color", "lightgray");
        } else {
            $(this).css("background-color", ""); // 원래 색으로 변경
        }

        // 선택한 카드 이름과 카드 번호 가져오기
        var cardName = $(this).text();
        var cardNumber = $(this).data("card-number");

        // 선택한 카드 이름과 카드 번호를 hidden 필드에 설정합니다.
        $("#selected-card-name").val(cardName);
        $("#selected-card-number").val(cardNumber);
    });


    // 선택한 카드 목록 배열 (카드번호)
    var selectedCards = [];

    //선택한 카드 목록 배열 (카드이름)
    var selectedCardNames = [];

    // 카드 선택을 위한 클릭 이벤트 리스너
    $(".card-list").click(function () {
        // 클릭한 카드 요소
        var clickedCard = $(this);

        // 현재 요소에 "clicked" 클래스가 있는지 확인
        var isClicked = clickedCard.hasClass("clicked");

        // 클릭한 요소에 "clicked" 클래스 토글
        clickedCard.toggleClass("clicked");

        // 만약 클릭한 상태였다면 목록에서 해당 카드 제거
        if (isClicked) {
            var cardIndex = selectedCards.indexOf(clickedCard.data("card-number"));
            if (cardIndex !== -1) {
                selectedCards.splice(cardIndex, 1);
                selectedCardNames.splice(cardIndex, 1);
            }
            clickedCard.css("background-color", ""); // 배경색을 원래대로 설정
        } else {
            // 클릭한 상태가 아니라면 목록에 해당 카드 추가
            selectedCards.push(clickedCard.data("card-number"));
            selectedCardNames.push(clickedCard.text());
            clickedCard.css("background-color", "lightgray");
        }

        console.log("선택한 카드 이름 목록: " + selectedCardNames)
        // 선택한 카드 이름과 카드 번호를 hidden 필드에 설정합니다.
        $("#selected-card-name").val(selectedCardNames.join(", ")); // 선택한 모든 카드 이름
        $("#selected-card-number").val(selectedCards.join(", ")); // 선택한 모든 카드 번호
    });


    // 선택한 "date-list" 요소 추적 변수
    var selectedDateElement = null;

    // 날짜 선택을 위한 클릭 이벤트 리스너
    $(".date-list").click(function () {
        // 현재 클릭한 "date-list" 요소
        var clickedDateElement = $(this);

        // 이미 다른 "date-list" 요소가 선택된 경우, 선택 해제
        if (selectedDateElement !== null && selectedDateElement[0] !== clickedDateElement[0]) {
            selectedDateElement.removeClass("clicked");
            selectedDateElement.css("background-color", ""); // 원래 색으로 변경
        }

        // "date-list" 요소에 "clicked" 클래스 토글
        clickedDateElement.toggleClass("clicked");

        // 만약 선택한 상태였다면 선택 해제
        if (clickedDateElement.hasClass("clicked")) {
            clickedDateElement.css("background-color", "lightgray");
            selectedDateElement = clickedDateElement;
        } else {
            clickedDateElement.css("background-color", ""); // 원래 색으로 변경
            selectedDateElement = null;
        }

        // 선택한 날짜 범위 가져오기
        var selectedDate = clickedDateElement.text();

        // 선택한 날짜 범위를 hidden 필드에 설정합니다.
        $("#selected-date-range").val(selectedDate);
    });


    $(document).ready(function () {
        // 테이블을 DataTables로 초기화
        var dataTable = $('#datatablesSimple').DataTable({
            autoWidth: false,
            searching: true,
            order: [[0, 'desc']], // 이 줄을 추가. 0은 첫 번째 컬럼을 나타냄. 'desc'는 내림차순을 나타냄
            language: {
                paginate: {
                    previous: "이전",
                    next: "다음"
                },
                zeroRecords: "검색 결과가 없습니다.",
                info: "전체 거래내역 _TOTAL_개 중에서 _START_ 번부터 _END_ 번까지의 결과",
                lengthMenu: "_MENU_ 행까지 조회"
            },
            columnDefs: [
                {
                    targets: -1,
                    className: 'dt-body-right'
                },
            ]
        });


        var table = $('#datatablesSimple').DataTable();

        $('#datatablesSimple tbody').on('click', 'tr', function () {
            var data = table.row(this).data();
            console.log('data', data);

            var transactionDate = data[0].replace(/-/g, "");
            var cardNumber ='';

            if (data[1].startsWith("4408")) {
                cardNumber = 4408398742192311;
            }else if(data[1].startsWith("4203")){
                cardNumber = 4203754097906696
            }else if(data[1].startsWith("4439")){
                cardNumber = 4439123764500768
            }

            var transactionIndustryName = data[2];
            var transactionStoreName = data[3];
            var transactionAmount = parseInt(data[4].replace(/[^0-9]/g, ""), 10); /
            console.log('transactionDate', transactionDate, 'cardNumber', cardNumber, 'transactionIndustryName', transactionIndustryName, 'transactionStoreName', transactionStoreName, 'transactionAmount', transactionAmount);
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/member/getTransactionDetail",
                data: {
                    transactionDate: transactionDate,
                    cardNumber: cardNumber,
                    transactionIndustryName: transactionIndustryName,
                    transactionStoreName: transactionStoreName,
                    transactionAmount: transactionAmount
                },
                success: function (response) {
                    console.log("거래 내역 상세 결과: ", response);

                    $("#cardNumber").text(formatCardNumber(response.cardNumber));

                    var rawDate = response.transactionDate;
                    var formattedDate = rawDate.substring(0, 4) + "년 " + rawDate.substring(4, 6) + "월 " + rawDate.substring(6, 8) + "일";
                    $("#transactionDate").text(formattedDate);

                    $("#transactionAmount").text(parseInt(response.transactionAmount).toLocaleString() + "원");

                    if (response.accumulationSum !== 0) {
                        $("#benefitAmount").text(response.accumulationSum.toLocaleString() + "원 (적립)");
                    } else if (response.discountAmount !== 0) {
                        $("#benefitAmount").text(response.discountAmount.toLocaleString() + "원 (할인)");
                    } else {
                        // 둘 다 0인 경우 값을 지워줍니다.
                        $("#benefitAmount").text("");
                    }

                    $("#transactionStoreName").text(response.transactionStoreName);
                    $("#transactionIndustryCode").text(response.transactionIndustryCode);

                    $("#transactionDetailModal").modal('show');
                },

                error: function (error) {
                    console.log(error);
                }
            });
        });

        function formatDate(inputDate) {
            let date = new Date(inputDate);
            let year = date.getFullYear();
            let month = ("0" + (date.getMonth() + 1)).slice(-2);
            let day = ("0" + date.getDate()).slice(-2);
            return year + '-' + month + '-' + day;
        }

        function formatCardNumber(cardNumber) {

            const hyphenatedNumber = cardNumber.replace(/(\d{4})(?=\d)/g, '$1-');

            return hyphenatedNumber.replace(/(\d{4}-)(\d{4}-\d{4})(-\d{4})/, "$1****-****$3");
        }


        function updateTable(response) {

            dataTable.clear().draw();


            for (var i = 0; i < response.length; i++) {
                var transaction = response[i];
                var transactionIndustryName = '';
                if (transaction['transactionIndustryCode'] === 'CS') {
                    transactionIndustryName = '편의점';
                } else if (transaction['transactionIndustryCode'] === 'CE') {
                    transactionIndustryName = '카페';
                } else if (transaction['transactionIndustryCode'] === 'PT') {
                    transactionIndustryName = '대중교통';
                } else if (transaction['transactionIndustryCode'] === 'MT') {
                    transactionIndustryName = '대형마트';
                } else if (transaction['transactionIndustryCode'] === 'SH') {
                    transactionIndustryName = '쇼핑';
                } else if (transaction['transactionIndustryCode'] === 'OL') {
                    transactionIndustryName = '주유';
                } else if (transaction['transactionIndustryCode'] === 'FD') {
                    transactionIndustryName = '요식';
                } else if (transaction['transactionIndustryCode'] === 'CT') {
                    transactionIndustryName = '문화시설';
                } else if (transaction['transactionIndustryCode'] === 'ED') {
                    transactionIndustryName = '교육';
                } else if (transaction['transactionIndustryCode'] === 'MD') {
                    transactionIndustryName = '의료';
                } else if (transaction['transactionIndustryCode'] === 'AP') {
                    transactionIndustryName = '항공';
                } else if (transaction['transactionIndustryCode'] === 'TR') {
                    transactionIndustryName = '여행';
                } else if (transaction['transactionIndustryCode'] === 'AL') {
                    transactionIndustryName = '기타 국내가맹점';
                }

                dataTable.row.add([
                    formatDate(transaction['transactionDate']),
                    formatCardNumber(transaction['cardNumber']),
                    transactionIndustryName,
                    transaction['transactionStoreName'],
                    transaction['transactionAmount'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원'
                ]).draw(false);
            }
        }


        $(".select-button").click(function () {
            $("#table-box").show();
            $(".chart-transactions").show();
            getTransactionList();

        });

        $('#applyDateRange').click(function () {
            startDate = $('#startDate').val();
            endDate = $('#endDate').val();
            console.log('startDate', startDate, 'endDate', endDate);

            $("#table-box").show();
            $(".chart-transactions").show();
            getTransactionList();

            $('#dateRangeModal').modal('hide');
        });

        function populateTable(data) {
            const tableBody = document.getElementById("tableBody");
            let totalAmount = 0;

            const industryCodeMapping = {
                'SH': '쇼핑',
                'FD': '음식',
                'CT': '문화시설',
                'CS': '편의점',
                'CE': '카페',
                'MT': '대형마트',
                'PT': '대중교통',
                'OL': '주유',
                'ED': '교육',
                'AP': '항공',
                'TR': '여행',
                'MD': '의료',
                'AL': '기타 국내가맹점'
            };

            for (let key in data) {
                const row = document.createElement("tr");
                const industryCodeCell = document.createElement("td");

                industryCodeCell.innerText = industryCodeMapping[data[key].transactionIndustryCode] || '알 수 없음';

                const amountCell = document.createElement("td");
                amountCell.classList.add("amount-cell");
                amountCell.innerText = data[key].transactionAmount.toLocaleString() + '원';

                row.appendChild(industryCodeCell);
                row.appendChild(amountCell);

                tableBody.appendChild(row);

                totalAmount += data[key].transactionAmount;  /
            }

            // 합계를 tfooter에 표시
            const totalAmountCell = document.getElementById("totalAmount");
            totalAmountCell.classList.add("amount-cell");
            totalAmountCell.innerText = totalAmount.toLocaleString() + '원';
        }

        function getTransactionList() {
            var cardName = $("#selected-card-name").val();
            var cardNumber = $("#selected-card-number").val();
            var selectedDate = $("#selected-date-range").val();
            console.log("카드 이름: " + cardName);
            console.log("카드 번호: " + cardNumber);
            console.log("날짜 범위: " + selectedDate)
            console.log("startDate: " + startDate);
            console.log("endDate: " + endDate);
            if (startDate == "" && endDate == "") {
                console.log("hi")
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/member/getTransactionList",
                    data: {
                        cardName: cardName,
                        cardNumber: cardNumber,
                        selectedDate: selectedDate
                    },
                    success: function (response) {
                        console.log("거래 목록 결과: " + response);

                        updateTable(response);
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            } else {
                startDate = startDate.replace(/-/g, "");
                endDate = endDate.replace(/-/g, "");
                selectedDate = startDate + endDate;
                console.log("selectedDate: " + selectedDate);
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/member/getTransactionList",
                    data: {
                        cardName: cardName,
                        cardNumber: cardNumber,
                        selectedDate: selectedDate
                    },
                    success: function (response) {
                        console.log("거래 목록 결과: " + response);

                        updateTable(response);
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

            var myChart;
            if (startDate == "" && endDate == "") {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/member/getTransactionChart",
                    data: {
                        cardNumber: cardNumber,
                        selectedDate: selectedDate
                    },
                    success: function (response) {
                        console.log("차트 결과: ", response);

                        populateTable(response);


                        if (myChart) {
                            myChart.destroy();

                        }

                        var labels = response.map(function (item) {
                            if (item.transactionIndustryCode === 'SH') {
                                return '쇼핑';
                            } else if (item.transactionIndustryCode === 'FD') {
                                return '음식';
                            } else if (item.transactionIndustryCode === 'CT') {
                                return '문화시설';
                            } else if (item.transactionIndustryCode === 'CS') {
                                return '편의점'
                            } else if (item.transactionIndustryCode === 'CE') {
                                return '카페'
                            } else if (item.transactionIndustryCode === 'MT') {
                                return '대형마트'
                            } else if (item.transactionIndustryCode === 'PT') {
                                return '대중교통'
                            } else if (item.transactionIndustryCode === 'OL') {
                                return '주유'
                            } else if (item.transactionIndustryCode === 'ED') {
                                return '교육'
                            } else if (item.transactionIndustryCode === 'AP') {
                                return '항공'
                            } else if (item.transactionIndustryCode === 'TR') {
                                return '여행'
                            } else if (item.transactionIndustryCode === 'MD') {
                                return '의료'
                            } else if (item.transactionIndustryCode === 'AL') {
                                return '기타 국내가맹점'
                            }


                            return item.transactionIndustryCode;
                        });
                        var data = response.map(item => item.transactionAmount);


                        var ctx = document.getElementById('myChart').getContext('2d');

                        myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: '사용 금액',
                                    data: data,
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.2)',    // 빨간색
                                        'rgba(255, 159, 64, 0.2)',   // 주황색
                                        'rgba(255, 205, 86, 0.2)',   // 노란색
                                        'rgba(75, 192, 192, 0.2)',   // 청록색
                                        'rgba(54, 162, 235, 0.2)',   // 파란색
                                        'rgba(153, 102, 255, 0.2)',  // 보라색
                                        'rgba(201, 203, 207, 0.2)',  // 회색
                                        'rgba(255, 99, 71, 0.2)',    // 토마토색
                                        'rgba(50, 205, 50, 0.2)',    // 라임그린
                                        'rgba(138, 43, 226, 0.2)',   // 파랑색
                                        'rgba(127, 255, 212, 0.2)',  // 아쿠아
                                        'rgba(222, 49, 99, 0.2)'     // 핑크색
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
                                    text: '업종별 금액',
                                    fontSize: 18
                                },
                                scales: {
                                    yAxes: [{
                                        ticks: {
                                            beginAtZero: true,
                                            callback: function (value, index, values) {
                                                return value.toLocaleString() + '원';
                                            },
                                            fontSize: 14
                                        }
                                    }],
                                    xAxes: [{
                                        ticks: {
                                            fontSize: 14
                                        }
                                    }]
                                },
                                legend: {
                                    display: false
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log(error);
                    }

                });
            } else {
                startDate = startDate.replace(/-/g, "");
                endDate = endDate.replace(/-/g, "");
                selectedDate = startDate + endDate;

                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/member/getTransactionChart",
                    data: {
                        cardNumber: cardNumber,
                        selectedDate: selectedDate
                    },
                    success: function (response) {
                        console.log("차트 결과: ", response);
                        //차트 결과로 표 생성
                        populateTable(response);

                        // 이전 차트 객체 제거
                        if (myChart) {
                            myChart.destroy();

                        }

                        var labels = response.map(function (item) {
                            if (item.transactionIndustryCode === 'SH') {
                                return '쇼핑';
                            } else if (item.transactionIndustryCode === 'FD') {
                                return '음식';
                            } else if (item.transactionIndustryCode === 'CT') {
                                return '문화시설';
                            } else if (item.transactionIndustryCode === 'CS') {
                                return '편의점'
                            } else if (item.transactionIndustryCode === 'CE') {
                                return '카페'
                            } else if (item.transactionIndustryCode === 'MT') {
                                return '대형마트'
                            } else if (item.transactionIndustryCode === 'PT') {
                                return '대중교통'
                            } else if (item.transactionIndustryCode === 'OL') {
                                return '주유'
                            } else if (item.transactionIndustryCode === 'ED') {
                                return '교육'
                            } else if (item.transactionIndustryCode === 'AP') {
                                return '항공'
                            } else if (item.transactionIndustryCode === 'TR') {
                                return '여행'
                            } else if (item.transactionIndustryCode === 'MD') {
                                return '의료'
                            } else if (item.transactionIndustryCode === 'AL') {
                                return '기타 국내가맹점'
                            }


                            return item.transactionIndustryCode;
                        });
                        var data = response.map(item => item.transactionAmount);



                        var ctx = document.getElementById('myChart').getContext('2d');

                        myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: '사용 금액',
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
                                    text: '업종별 금액',
                                    fontSize: 18
                                },
                                scales: {
                                    yAxes: [{
                                        ticks: {
                                            beginAtZero: true,
                                            callback: function (value, index, values) {
                                                return value.toLocaleString() + '원';
                                            },
                                            fontSize: 14
                                        }
                                    }],
                                    xAxes: [{
                                        ticks: {
                                            fontSize: 14
                                        }
                                    }]
                                },
                                legend: {
                                    display: false
                                }
                            }
                        });
                    },
                    error: function (error) {
                        console.log(error);
                    }

                });
            }

        }
    });
</script>



<%--<%@ include file="../include/footer.jsp" %>--%>
</body>
</html>
