<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>HanaOnePick Admin Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author"/>

    <!-- App css -->
    <link href="../../resources/admin/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../resources/admin/css/app-modern.min.css" rel="stylesheet" type="text/css" id="light-style"/>

    <link href="https://cdn.jsdelivr.net/npm/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet">


</head>

<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
<!-- jQuery CDN -->
<script src="../../resources/admin/js/vendor.min.js"></script>
<!--pagination -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>

<!-- Start Content-->
<div class="container-fluid">

    <!-- Begin page -->
    <div class="wrapper">

        <!-- ========== Left Sidebar Start ========== -->
        <div class="leftside-menu leftside-menu-detached">

            <div class="leftbar-user">
                <a href="javascript: void(0);">
                    <img src="../../resources/img/img-hana-symbol.png" alt="user-image" height="42"
                         class="rounded-circle shadow-sm">
                    <span class="leftbar-user-name fs-3">HanaOnePick</span>
                </a>
            </div>

            <!--- Sidemenu -->
            <ul class="side-nav">

                <li class="side-nav-item mb-3">
                    <a href="/admin" class="side-nav-link">
                        <img class="w-25 me-2" src="../../resources/img/dashboard.png"/>
                        <span class="fs-4 fw-bold">대시보드</span>
                    </a>
                </li>

                <li class="side-nav-item mb-3">
                    <a href="/adminData" class="side-nav-link">
                        <img class="w-25 me-2" src="../../resources/img/data-management.png"/>
                        <span class="fs-4 fw-bold">통계/분석</span>
                    </a>
                </li>

                <li class="side-nav-item mb-3">
                    <a href="apps-chat.html" class="side-nav-link">
                        <img class="w-25 me-2" src="../../resources/img/mail.png"/>
                        <span class="fs-4 fw-bold">메일 송부</span>
                    </a>
                </li>

            </ul>

        </div>
        <!-- Left Sidebar End -->

        <div class="content-page">
            <div class="content">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box">
                            <div class="page-title-right">
                            </div>
                            <h4 class="page-title">Dashboard</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <!-- Customers Card -->
                    <div class="col-sm-3">
                        <div class="card widget-flat">
                            <div class="card-body">
                                <div class="float-end">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-people widget-icon" viewBox="0 0 16 16">
                                        <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8Zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022ZM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816ZM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0Zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4Z"/>
                                    </svg>
                                </div>
                                <h5 class="text-muted fw-normal mt-0 fs-3" title="Number of Customers">고객 수</h5>
                                <h3 class="mt-3 mb-3"><fmt:formatNumber value="${memberCount}" type="number"
                                                                        pattern="#,### 명"/></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Orders Card -->
                    <div class="col-sm-3">
                        <div class="card widget-flat">
                            <div class="card-body">
                                <div class="float-end">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-credit-card-2-front widget-icon bg-success-lighten text-success"
                                         viewBox="0 0 16 16">
                                        <path d="M14 3a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h12zM2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2z"/>
                                        <path d="M2 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z"/>
                                    </svg>
                                </div>
                                <h5 class="text-muted fw-normal mt-0 fs-3" title="Number of Orders">고객 보유 카드 수</h5>
                                <h3 class="mt-3 mb-3"><fmt:formatNumber value="${cardCount}"
                                                                        type="number" pattern="#,### 장"/></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue Card -->
                    <div class="col-sm-3">
                        <div class="card widget-flat">
                            <div class="card-body">
                                <div class="float-end">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-search widget-icon bg-success-lighten text-success"
                                         viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                    </svg>
                                </div>
                                <h5 class="text-muted fw-normal mt-0 fs-3" title="Average Revenue">장소 검색 수</h5>
                                <h3 class="mt-3 mb-3"><fmt:formatNumber value="${searchCount}"
                                                                        type="number" pattern="#,### 회"/></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Growth Card -->
                    <div class="col-sm-3">
                        <div class="card widget-flat">
                            <div class="card-body">
                                <div class="float-end">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-cash-coin widget-icon" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd"
                                              d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0z"/>
                                        <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1h-.003zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195l.054.012z"/>
                                        <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083c.058-.344.145-.678.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1H1z"/>
                                        <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 5.982 5.982 0 0 1 3.13-1.567z"/>
                                    </svg>
                                </div>
                                <h5 class="text-muted fw-normal mt-0 fs-3" title="Growth">전체 소비 금액</h5>
                                <h3 class="mt-3 mb-3"><fmt:formatNumber value="${payAmount}"
                                                                        type="number" pattern="#,### 원"/></h3>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body" style="margin-bottom: 4%;">
                                <div class="dropdown float-end">
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                    </div>
                                </div>
                                <div class="header-title mb-3 fs-3">'혜택 매장 찾기' 검색기록 통계</div>

                                <div class="chart-content-bg">
                                    <div class="row text-center">
                                        <div class="search-chart">
                                            <canvas id="searchChart"></canvas>
                                        </div>
                                        <script>
                                            var labels = [];
                                            var data = [];

                                            <c:forEach var="item" items="${searchChartList}" varStatus="loop">
                                            var label = '';
                                            var searchIndustryCode = '${item.searchIndustryCode}'; // JSP 변수를 JavaScript 변수로 할당
                                            if (searchIndustryCode === 'SH') {
                                                label = '쇼핑';
                                            } else if (searchIndustryCode === 'FD') {
                                                label = '음식';
                                            } else if (searchIndustryCode === 'CT') {
                                                label = '문화시설';
                                            } else if (searchIndustryCode === 'CS') {
                                                label = '편의점';
                                            } else if (searchIndustryCode === 'CE') {
                                                label = '카페';
                                            } else if (searchIndustryCode === 'MT') {
                                                label = '대형마트';
                                            } else if (searchIndustryCode === 'PT') {
                                                label = '대중교통';
                                            } else if (searchIndustryCode === 'OL') {
                                                label = '주유';
                                            } else if (searchIndustryCode === 'ED') {
                                                label = '교육';
                                            } else if (searchIndustryCode === 'AP') {
                                                label = '항공';
                                            } else if (searchIndustryCode === 'TR') {
                                                label = '여행';
                                            } else if (searchIndustryCode === 'MD') {
                                                label = '의료';
                                            } else if (searchIndustryCode === 'UNKNOWN') {
                                                label = '기타';
                                            }
                                            labels.push(label);
                                            data.push(${item.searchCount});
                                            </c:forEach>

                                            var ctx = document.getElementById('searchChart').getContext('2d');
                                            var myPieChart = new Chart(ctx, {
                                                type: 'bar',
                                                data: {
                                                    labels: labels,
                                                    datasets: [{
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
                                                        text: '< 검색 데이터 >',
                                                        fontSize: 25,
                                                        padding: 30
                                                    },
                                                    legend: {
                                                        display: false, // 기본 legend 숨김
                                                    },
                                                    scales: {
                                                        yAxes: [{
                                                            ticks: {
                                                                beginAtZero: true,
                                                                callback: function (value, index, values) {
                                                                    return value.toLocaleString() + '회';
                                                                },
                                                                fontSize: 14
                                                            }
                                                        }],
                                                        xAxes: [{
                                                            ticks: {
                                                                fontSize: 14
                                                            }
                                                        }]
                                                    }
                                                }
                                            });
                                        </script>
                                    </div>
                                </div>


                                <div dir="ltr">
                                    <div id="revenue-chart" class="apex-charts mt-3"
                                         data-colors="#536de6,#10c469"></div>
                                </div>

                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->

                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="header-title fs-3">이번달 검색 급상승 순위</div>
                                <div class="mb-5">
                                    <div class="chart-widget-list">
                                        <table class="table table-centered table-nowrap table-hover mb-0">
                                            <thead>
                                            <tr class="fs-3">
                                                <th>업종</th>
                                                <th>이번 달 변화량</th>
                                            </tr>
                                            </thead>
                                            <tbody class="fs-4">
                                            <c:forEach items="${searchRankList}" var="mapEntry">
                                                <c:forEach items="${mapEntry}" var="entry">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${entry.key == 'CS'}">편의점</c:when>
                                                                <c:when test="${entry.key == 'MT'}">대형마트</c:when>
                                                                <c:when test="${entry.key == 'OL'}">주유</c:when>
                                                                <c:when test="${entry.key == 'SH'}">쇼핑</c:when>
                                                                <c:when test="${entry.key == 'FD'}">음식</c:when>
                                                                <c:when test="${entry.key == 'CE'}">카페</c:when>
                                                                <c:otherwise>기타</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <c:if test="${entry.value > 0}">
                                                            <td class="text-success">
                                                                <i class="mdi mdi-arrow-up-bold me-1"></i>
                                                                <span>${entry.value} 회</span>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${entry.value < 0}">
                                                            <td class="text-danger">
                                                                <i class="mdi mdi-arrow-down-bold me-1"></i>
                                                                <span>${entry.value} 회</span>
                                                            </td>
                                                        </c:if>
                                                            <%--                                                <td>${entry.value}</td>--%>
                                                    </tr>
                                                </c:forEach>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->
                </div>
                <!-- end row -->


                <div class="row">
                    <div class="col-xl-6 col-lg-12 order-lg-2 order-xl-1">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mt-2 mb-3 fs-3">업종별 고객 소비 통계</h4>

                                <div class="table-responsive">
                                    <table class="table table-centered table-nowrap table-hover mb-0">
                                        <tbody>
                                        <c:forEach items="${transactionChartList}" var="transactionChart">
                                            <tr>
                                                <td>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'CS'}">
                                                        <div class="fs-4 my-1 fw-normal">편의점</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'MT'}">
                                                        <div class="fs-4 my-1 fw-normal">대형마트</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'OL'}">
                                                        <div class="fs-4 my-1 fw-normal">주유</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'SH'}">
                                                        <div class="fs-4 my-1 fw-normal">쇼핑</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'FD'}">
                                                        <div class="fs-4 my-1 fw-normal">음식</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'CE'}">
                                                        <div class="fs-4 my-1 fw-normal">카페</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'TR'}">
                                                        <div class="fs-4 my-1 fw-normal">여행</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'AP'}">
                                                        <div class="fs-4 my-1 fw-normal">항공</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'PT'}">
                                                        <div class="fs-4 my-1 fw-normal">대중교통</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'ED'}">
                                                        <div class="fs-4 my-1 fw-normal">교육</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'MD'}">
                                                        <div class="fs-4 my-1 fw-normal">의료</div>
                                                    </c:if>
                                                    <c:if test="${transactionChart.transactionIndustryCode == 'CT'}">
                                                        <div class="fs-4 my-1 fw-normal">문화시설</div>
                                                    </c:if>

                                                </td>
                                                <td style="text-align: right">
                                                    <span class="text-muted fs-4"><fmt:formatNumber
                                                            value="${transactionChart.transactionAmount}" type="number"
                                                            pattern="#,### 원"/></span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div> <!-- end table-responsive-->
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->
                    <div class="col-xl-6 col-lg-12 order-lg-2 order-xl-1">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mt-2 mb-3 fs-3">회원 리스트</h4>

                                <div class="table-responsive">
                                    <table class="table table-centered table-nowrap table-hover mb-0">
                                        <thead>
                                        <tr class="fs-4">
                                            <th>이름</th>
                                            <th>비밀번호</th>
                                            <th>이메일</th>
                                            <th>등록 날짜</th>
                                            <th>성별</th>
                                            <th>주소</th>
                                        </tr>
                                        </thead>
                                        <tbody id="member-list">
                                        <c:forEach var="member" items="${memberList}">
                                            <tr class="fs-4">
                                                <td>${member.name}</td>
                                                <td>${member.password}</td>
                                                <td>${member.email}</td>
                                                <fmt:parseDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss"
                                                               var="parsedDate"/>
                                                <td><fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/></td>
                                                <td>${member.gender}</td>
                                                <td>${member.address} ${member.detailAddress}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div id="pagination-container"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        jQuery(document).ready(function ($) {
                            const rowsPerPage = 12;
                            const rows = $("#member-list tr");
                            const totalPages = Math.ceil(rows.length / rowsPerPage);

                            function displayPage(page) {
                                rows.hide();
                                for (let i = (page - 1) * rowsPerPage; i < page * rowsPerPage && i < rows.length; i++) {
                                    $(rows[i]).show();
                                }
                            }

                            // 초기 페이지 로딩 시 첫 번째 페이지를 보여줍니다.
                            displayPage(1);

                            $('#pagination-container').twbsPagination({
                                totalPages: totalPages,
                                visiblePages: 5,
                                first: '처음',
                                prev: '이전',
                                next: '다음',
                                last: '마지막',
                                onPageClick: function (event, page) {
                                    displayPage(page);
                                }
                            });

                        });
                    </script>

                    <!-- Footer Start -->
                    <footer class="footer">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-6">
                                    <script>document.write(new Date().getFullYear())</script>
                                    © Hyper - Coderthemes.com
                                </div>
                                <div class="col-md-6">
                                    <div class="text-md-end footer-links d-none d-md-block">
                                        <a href="javascript: void(0);">About</a>
                                        <a href="javascript: void(0);">Support</a>
                                        <a href="javascript: void(0);">Contact Us</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </footer>
                    <!-- end Footer -->

                </div>
                <!-- content-page -->

            </div> <!-- end wrapper-->
        </div>
        <!-- END Container -->

    </div>
</div>
<!-- bundle -->

<script src="../../resources/admin/js/app.min.js"></script>


<!-- demo app -->
<script src="../../resources/admin/js/demo.dashboard.js"></script>
<!-- end demo js-->

</body>
</html>
