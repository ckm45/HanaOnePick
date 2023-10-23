<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>HanaOnePick Data Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author"/>

    <!-- App css -->
    <link href="../../resources/admin/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../resources/admin/css/app-modern.min.css" rel="stylesheet" type="text/css" id="light-style"/>

    <link href="../../resources/css/adminData.css" rel="stylesheet">

    <!-- RANK Css -->
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet">

</head>

<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>

<!-- Bootstrap JS, Popper.js, jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
                        <span class="fs-3 fw-bold">통계/분석</span>
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
                            <h4 class="page-title">통계/분석</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col">
                        <div class="card">
                            <h2 class="mb-3 mx-auto">사용자의 검색기록 업종별 통계 차트</h2>
                            <div id="monthCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
                                <!-- The slideshow -->
                                <div class="carousel-inner">
                                    <div class="carousel-item" data-month="2">
                                        <div class="d-block w-100 text-center mt-2 fs-3">7월</div>
                                    </div>
                                    <div class="carousel-item" data-month="1">
                                        <div class="d-block w-100 text-center mt-2 fs-3">8월</div>
                                    </div>
                                    <div class="carousel-item active" data-month="0">
                                        <div class="d-block w-100 text-center mt-2 fs-3">9월</div>
                                    </div>
                                </div>

                                <!-- Left and right controls -->
                                <a class="carousel-control-prev mt-2" href="#monthCarousel" role="button"
                                   data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"
                                          style="filter: invert(1);"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next mt-2" href="#monthCarousel" role="button"
                                   data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"
                                          style="filter: invert(1);"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>

                            <!-- Separate canvas outside the carousel -->
                            <canvas id="searchChart"></canvas>

                            <script>
                                var searchChartList = [
                                    <c:forEach items="${searchChartList}" var="list" varStatus="status">
                                        ${status.count > 1 ? "," : ""}{
                                        items: [
                                            <c:forEach items="${list}" var="item" varStatus="itemStatus">
                                                ${itemStatus.count > 1 ? "," : ""}{
                                                searchIndustryCode: "${item.searchIndustryCode}",
                                                searchCount: ${item.searchCount}
                                            }
                                            </c:forEach>
                                        ]
                                    }
                                    </c:forEach>
                                ];
                                var myChart;
                                $('#monthCarousel').on('slid.bs.carousel', function () {
                                    var monthIdx = $('#monthCarousel .carousel-item.active').data('month');
                                    if (myChart) {
                                        myChart.destroy();
                                    }
                                    drawChart('searchChart', searchChartList[monthIdx].items);
                                });

                                // 첫 페이지 로드 시 9월의 차트를 그립니다.
                                drawChart('searchChart', searchChartList[0].items);

                                function drawChart(chartId, dataList) {
                                    var labels = [];
                                    var data = [];

                                    for (var i = 0; i < dataList.length; i++) {
                                        var item = dataList[i];
                                        var label = '';
                                        var searchIndustryCode = item.searchIndustryCode;

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
                                        data.push(item.searchCount);
                                    }

                                    var ctx = document.getElementById(chartId).getContext('2d');
                                    myPieChart = new Chart(ctx, {
                                        type: 'bar',
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
                                                text: '< 검색 데이터 >',
                                                fontSize: 25,
                                                padding: 30
                                            },
                                            legend: {
                                                display: false,
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
                                }
                            </script>


                        </div> <!-- end card-->
                    </div> <!-- end col-->
                </div>
                <!-- end row -->


                <div class="row">
                    <div class="col-xl-9 col-lg-12 order-lg-2 order-xl-1">
                        <div class="card">
                            <div class="card-body">

                                <div class="header-title mt-2 mb-3 fs-3">9월달 검색내역 변화 추이</div>
                                <c:set var="searchChart2" value="${searchChartList[1]}"/>
                                <div class="table-responsive">
                                    <table class="table table-centered table-nowrap table-hover mb-0">
                                        <thead>
                                        <tr class="fs-4">
                                            <th scope="col">업종</th>
                                            <th scope="col">8월</th>
                                            <th scope="col">9월</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach varStatus="status" items="${searchChartList[0]}" var="searchChart">
                                            <c:set var="searchChartAugust" value="${searchChartList[1][status.index]}"/>
                                            <tr class="fs-4">
                                                <c:if test="${searchChart.searchIndustryCode eq 'SH'}">
                                                    <td>쇼핑</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'FD'}">
                                                    <td>음식</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'CT'}">
                                                    <td>문화시설</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'CS'}">
                                                    <td>편의점</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'CE'}">
                                                    <td>카페</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'MT'}">
                                                    <td>대형마트</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'PT'}">
                                                    <td>대중교통</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'OL'}">
                                                    <td>주유</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'ED'}">
                                                    <td>교육</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'AP'}">
                                                    <td>항공</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'TR'}">
                                                    <td>여행</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'MD'}">
                                                    <td>의료</td>
                                                </c:if>
                                                <c:if test="${searchChart.searchIndustryCode == 'UNKNOWN'}">
                                                    <td>기타</td>
                                                </c:if>
                                                <td><fmt:formatNumber value="${searchChartAugust.searchCount}"
                                                                      type="number" pattern="#,### 회"/></td>
                                                <td><fmt:formatNumber value="${searchChart.searchCount}" type="number"
                                                                      pattern="#,### 회"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div> <!-- end table-responsive-->
                        </div> <!-- end card-body-->
                    </div> <!-- end card-->
                    <!-- end col-->

                    <div class="col-xl-3 col-lg-6 order-lg-1">
                        <div class="card">
                            <div class="card-body">
                                <div class="header-title mt-2 mb-3 fs-4 fw-bold">이번달 검색 내역 변동량</div>

                                <div class="chart-widget-list">
                                    <table class="table table-centered table-nowrap table-hover mb-0">
                                        <thead>
                                        <tr class="fs-4">
                                            <th>업종</th>
                                            <th>이번 달 변화량</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${searchRankList}" var="mapEntry">
                                            <c:forEach items="${mapEntry}" var="entry">
                                                <tr class="fs-4">
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
                                                            <span>${entry.value}</span>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${entry.value < 0}">
                                                        <td class="text-danger">
                                                            <i class="mdi mdi-arrow-down-bold me-1"></i>
                                                            <span>${entry.value}</span>
                                                        </td>
                                                    </c:if>
                                                        <%--                                                <td>${entry.value}</td>--%>
                                                </tr>
                                            </c:forEach>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->

                    <!-- end col -->
                </div>
                <div class="row">
                    <c:forEach items="${cardDTOList}" var="card">
                    <div class="col-xl-3 col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="header-title mt-2 mb-3 fs-3">이번달 검색 순위 관련 카드</div>
                                    <img class="img-fluid mb-3" src="../../resources/img/hanacard${card.cardId}.png">
                                <div class="chart-widget-list">
                                    <ul class="fs-4 fw-semibold">
                                        <c:if test="${card.cardTypeCode =='2'}">
                                            <p>신용카드</p>
                                        </c:if>
                                        <c:if test="${card.cardTypeCode =='1'}">
                                            <p>체크카드</p>
                                        </c:if>
                                        <p>${card.cardName}</p>
                                        <p>${card.cardSubTitle}</p>
                                        <p>연회비: <fmt:formatNumber value="${card.annualFee}"
                                                                  type="number" pattern="#,### 원"/></p>
                                    </ul>

                                    <form action="/sendMail" method="get">

                                        <input type="hidden" name="cardId" value="${card.cardId}" />

                                        <button class="btn btn-dark" type="submit">메일 전송</button>
                                    </form>
                                </div>

                            </div> <!-- end card-body-->
                        </div>
                    </div>
                    </c:forEach>
                </div>
                <!-- end row -->
            </div> <!-- End Content -->

            <!-- Footer Start -->
            <footer class="footer">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <script>document.write(new Date().getFullYear())</script>
                            © HanaOnePick
                        </div>
                        <div class="col-md-6">
                            <div class="text-md-end footer-links d-none d-md-block">
                                <a>About</a>
                                <a>Support</a>
                                <a>Contact Us</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- end Footer -->

        </div>
        <!-- content-page -->

    </div> <!-- end wrapper-->

    <!-- END Container -->
</div>
<!-- Right Sidebar -->

<div class="rightbar-overlay"></div>
<!-- /End-bar -->


<!-- bundle -->
<script src="../../resources/admin/js/vendor.min.js"></script>
<script src="../../resources/admin/js/app.min.js"></script>


<!-- demo app -->
<script src="../../resources/admin/js/demo.dashboard.js"></script>
<!-- end demo js-->

</body>
</html>


<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>

<%--<head>--%>
<%--    <!-- Required meta tags -->--%>
<%--    <meta charset="utf-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1">--%>

<%--    <title>HanaOnePickAdmin</title>--%>

<%--    <link href="../../resources/css/admin.css" rel="stylesheet">--%>

<%--    <link--%>
<%--            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"--%>
<%--            rel="stylesheet"--%>
<%--            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"--%>
<%--            crossorigin="anonymous">--%>
<%--</head>--%>

<%--<body>      <!-- Card -->--%>
<%--            <div class="card mb-4">--%>
<%--                <!-- Card header -->--%>
<%--                <div class="card-header align-items-center card-header-height d-flex justify-content-between align-items-center">--%>
<%--                    멤버리스트--%>
<%--                </div>--%>
<%--                <!-- Card body -->--%>
<%--                <div class="card-body table-responsive">--%>
<%--                    <table class="table table align-middle">--%>
<%--                        <thead>--%>
<%--                        <tr>--%>
<%--                            <th scope="col">이름</th>--%>
<%--                            <th scope="col">주민등록번호</th>--%>
<%--                            <th scope="col">비밀번호</th>--%>
<%--                            <th scope="col">E-mail</th>--%>
<%--                            <th scope="col">가입날짜</th>--%>
<%--                            <th scope="col">성별</th>--%>
<%--                            <th scope="col">주소</th>--%>
<%--                        </tr>--%>
<%--                        </thead>--%>
<%--                        <tbody>--%>

<%--                        <c:forEach var="member" items="${memberList}">--%>
<%--                            <tr>--%>
<%--                                <td>${member.name}</td>--%>
<%--                                <td>${member.personalIdNumber}</td>--%>
<%--                                <td>${member.password}</td>--%>
<%--                                <td>${member.email}</td>--%>
<%--                                <td>${member.regDate}</td>--%>
<%--                                <td>${member.gender}</td>--%>
<%--                                <td>${member.address} + ' ' + ${member.detailAddress} </td>--%>
<%--                                <td>--%>
<%--                                    <button class="btn btn-dark" id="checkEmail">메일 전송</button>--%>
<%--                                </td>--%>
<%--                            </tr>--%>
<%--                        </c:forEach>--%>

<%--                        </tbody>--%>
<%--                    </table>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        var $checkEmail = $("#checkEmail");--%>
<%--        $checkEmail.click(function () {--%>
<%--            $.ajax({--%>
<%--                type: "POST",--%>
<%--                url: "/mailConfirm",--%>
<%--                data: {--%>
<%--                    "email": "ckm45@naver.com"--%>
<%--                },--%>
<%--                success: function (data) {--%>
<%--                    alert("해당 이메일로 인증번호 발송이 완료되었습니다. \n 확인부탁드립니다.")--%>
<%--                    console.log("data : " + data);--%>
<%--                },--%>
<%--                error: function (error) {--%>
<%--                    alert("error")--%>
<%--                    console.log("Error sending data to server: " + error);--%>
<%--                }--%>
<%--            })--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
