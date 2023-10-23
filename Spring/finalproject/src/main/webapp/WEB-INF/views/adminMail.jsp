<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>HanaOnePick Mail Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description"/>
    <meta content="Coderthemes" name="author"/>

    <!-- App css -->
    <link href="../../resources/admin/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../resources/admin/css/app-modern.min.css" rel="stylesheet" type="text/css" id="light-style"/>


</head>

<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                            <div class="page-title fs-3">메일 송부</div>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <!-- Customers Card -->
                    <div class="col-md-6">
                        <div class="card widget-flat">
                            <div class="card-body">
                                <h4 class="mb-4 fs-3">보내고자 하는 카드 정보</h4>
                                <div class="text-center mb-4">
                                    <img src="../../resources/img/hanacard${cardDTO.cardId}.png" class="img-fluid mb-3"
                                         style="max-width: 80%; border-radius: 15px; box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);">
                                    <div class="fs-3 fw-bold">${cardDTO.cardName}</div>
                                    <input id="cardName" value="${cardDTO.cardName}" type="hidden">
                                    <p class="fs-4 fw-semibold">${cardDTO.cardSubTitle}</p>
                                    <input id="cardSubTitle" value="${cardDTO.cardSubTitle}" type="hidden">
                                    <p class="fs-4 fw-semibold">연회비: <fmt:formatNumber
                                            value="${cardDTO.annualFee}" type="number"
                                            pattern="#,### 원"/></p>
                                    <input id="annualFee" value="${cardDTO.annualFee}" type="hidden">
                                </div>
                                <div class="row">
                                    <h3>주요혜택</h3>
                                    <c:forEach var="entry" items="${benefitIndustryMap}">
                                        <div class="col-md-6">
                                            <!-- 혹은 원하는 열 너비로 설정하십시오. 예: col-md-4 또는 col-md-3 -->
                                            <ul class="list-unstyled">
                                                <li class="mb-2 fs-4 p-1">
                                                    <strong class="fs-4 mb-1">혜택업종 : </strong>
                                                    <c:if test="${entry.key == 'AL'}">국내 가맹점</c:if>
                                                    <c:if test="${entry.key == 'SH'}">쇼핑</c:if>
                                                    <c:if test="${entry.key == 'FD'}">국내 음식점</c:if>
                                                    <c:if test="${entry.key == 'CT'}">문화시설</c:if>
                                                    <c:if test="${entry.key == 'CS'}">편의점</c:if>
                                                    <c:if test="${entry.key == 'CE'}">카페</c:if>
                                                    <c:if test="${entry.key == 'PT'}">대중교통</c:if>
                                                    <c:if test="${entry.key == 'ED'}">교육</c:if>
                                                    <c:if test="${entry.key == 'MT'}">마트</c:if>
                                                    <c:if test="${entry.key == 'MD'}">의료</c:if>
                                                    <c:if test="${entry.key == 'OL'}">주유</c:if>
                                                    <br>
                                                    <strong class="fs-4 mb-1">혜택가맹점:</strong>
                                                    <c:forEach var="storeName" items="${entry.value.storeNames}"
                                                               varStatus="status">
                                                        ${storeName}
                                                        <c:if test="${not status.last}">, </c:if>
                                                    </c:forEach>
                                                    <br>
                                                    <c:if test="${entry.value.benefitCode eq 'DCVC '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> <fmt:formatNumber
                                                            value="${entry.value.benefitAmount}" type="number"
                                                            pattern="#,### 원"/>
                                                        할인 월 최대 ${entry.value.benefitMax}회
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'DCPC '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> ${entry.value.benefitAmount}% 할인 월 최대 ${entry.value.benefitMax}회
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'DCVA '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> <fmt:formatNumber
                                                            value="${entry.value.benefitAmount}" type="number"
                                                            pattern="#,### 원"/>
                                                        할인 월 최대 ${entry.value.benefitMax}원
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'DCPA '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> ${entry.value.benefitAmount}% 할인 월 최대 ${entry.value.benefitMax}원
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'ACPC '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> ${entry.value.benefitAmount}% 적립 월 최대 ${entry.value.benefitMax}회
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'ACVC '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> <fmt:formatNumber
                                                            value="${entry.value.benefitAmount}" type="number"
                                                            pattern="#,### 원"/>
                                                        적립 월 최대 ${entry.value.benefitMax}회
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'ACPA '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> ${entry.value.benefitAmount}% 적립 월 최대 ${entry.value.benefitMax}원
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'ACVA '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> <fmt:formatNumber
                                                            value="${entry.value.benefitAmount}" type="number"
                                                            pattern="#,### 원"/>
                                                        적립 월 최대 ${entry.value.benefitMax}원
                                                    </c:if>
                                                    <c:if test="${entry.value.benefitCode eq 'ACPN '}">
                                                        <strong class="fs-4 mb-1">혜택내용:</strong> ${entry.value.benefitAmount}% 적립 월 한도 없음
                                                    </c:if>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">

                            <div class="card widget-flat">
                                <div class="card-body mb-5">
                                    <div class="mb-4 fs-3 fw-bold">보내고자 하는 메일 내용</div>
                                    <div class="mb-4">
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label fs-4 fw-semibold">작성자</label>
                                            <input type="email" class="form-control fs-3" id="exampleFormControlInput1" placeholder="HanaOnePick" value="HanaOnePick">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlTextarea1" class="form-label fs-4 fw-semibold">내용</label>
                                            <textarea class="form-control fs-4" id="exampleFormControlTextarea1" rows="12"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="formFileLg" class="form-label fs-4 fw-semibold">사진 업로드</label>
                                            <input class="form-control form-control-lg" id="formFileLg" type="file">
                                        </div>
                                        <input id= "benefitIndustryMap" type="hidden" value="${benefitIndustryMap}">
                                    </div>
                                </div>
                            </div>

                    </div>
                </div>
                <!-- end row -->
                <div class="row">
                    <div class="col">
                        <div class="card mb-4">
                            <!-- Card header -->
                            <div class="card-header align-items-center card-header-height d-flex justify-content-between align-items-center fs-3">
                                고객 리스트
                            </div>
                            <!-- Card body -->
                            <div class="card-body table-responsive">
                                <table class="table table align-middle fs-4">
                                    <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox" id="selectAll"></th> <!-- 전체 선택 체크 박스 -->
                                        <th scope="col">이름</th>
                                        <th scope="col">비밀번호</th>
                                        <th scope="col">E-mail</th>
                                        <th scope="col">가입날짜</th>
                                        <th scope="col">성별</th>
                                        <th scope="col">주소</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="member" items="${memberList}">
                                        <tr>
                                            <td><input type="checkbox" name="selectedMembers" value="${member.email}">
                                            </td> <!-- 고객별 체크 박스 -->
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
                                <button class="btn btn-dark" id="sendEmail">메일 전송</button> <!-- 메일 전송 버튼 -->
                            </div>
                        </div>


                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                        <script>
                            document.getElementById('selectAll').addEventListener('change', function() {
                                const checkboxes = document.querySelectorAll('input[name="selectedMembers"]');
                                for (let checkbox of checkboxes) {
                                    checkbox.checked = this.checked;
                                }
                            });

                            document.getElementById('sendEmail').addEventListener('click', function() {
                                const selectedEmails = document.querySelectorAll('input[name="selectedMembers"]:checked');
                                if (selectedEmails.length === 0) {
                                    alert('메일을 전송할 고객을 선택해주세요.');
                                    return;
                                }

                                let emailArray = [];
                                selectedEmails.forEach(emailCheckbox => {
                                    emailArray.push(emailCheckbox.value);
                                });

                                const author = document.getElementById('exampleFormControlInput1').value;
                                const cardName = document.getElementById('cardName').value;
                                const cardSubTitle = document.getElementById('cardSubTitle').value;
                                const annualFee = document.getElementById('annualFee').value;

                                const benefitIndustryMap = document.getElementById('benefitIndustryMap').value;

                                const matches = benefitIndustryMap.matchAll(/(\w+)=GroupedBenefit\(storeNames=\[([^\]]+)\], benefitAmount=(\d+\.\d+), benefitCode=(\w+)\s?, benefitMax=(\d+)\)/g);

                                const benefitIndustryMapJSON = {};

                                for (const match of matches) {
                                    const [, key, storeNames, benefitAmount, benefitCode, benefitMax] = match;
                                    benefitIndustryMapJSON[key] = {
                                        storeNames: storeNames.split(', '),
                                        benefitAmount: parseFloat(benefitAmount),
                                        benefitCode,
                                        benefitMax: parseInt(benefitMax)
                                    };
                                }
                                console.log(benefitIndustryMap)
                                console.log(benefitIndustryMapJSON)
                                const content = document.getElementById('exampleFormControlTextarea1').value;

                                const uploadedFile = document.getElementById('formFileLg').files[0];
                                const uploadedFileName = uploadedFile ? uploadedFile.name : null;
                                let payload = {
                                    email: emailArray,
                                    author: author,
                                    content: content,
                                    fileName: uploadedFileName,
                                    cardName: cardName,
                                    cardSubTitle: cardSubTitle,
                                    annualFee: annualFee,
                                    benefitIndustryMap: benefitIndustryMapJSON
                                };
                                $.ajax({
                                    type: "POST",
                                    url: "/mailConfirm",
                                    contentType: 'application/json',
                                    data: JSON.stringify(payload),
                                    success: function (data) {
                                        alert("이메일 발송이 완료되었습니다.")
                                        console.log("data : " + data);
                                    },
                                    error: function (error) {
                                        alert("error")
                                        console.log("Error sending data to server: " + error);
                                    }
                                });

                                // 여기서 emailArray를 사용하여 메일 전송 로직을 작성하면 됩니다.
                                console.log(emailArray); // 선택된 이메일 주소들 출력
                            });
                        </script>
                    </div> <!-- end col-->

                </div>
                <!-- end row -->
            </div> <!-- End Content -->

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


<!-- Right Sidebar -->
<div class="end-bar">

    <div class="rightbar-title">
        <a href="javascript:void(0);" class="end-bar-toggle float-end">
            <i class="dripicons-cross noti-icon"></i>
        </a>
        <h5 class="m-0">Settings</h5>
    </div>

    <div class="rightbar-content h-100" data-simplebar>

        <div class="p-3">
            <div class="alert alert-warning" role="alert">
                <strong>Customize </strong> the overall color scheme, sidebar menu, etc.
            </div>

            <!-- Settings -->
            <h5 class="mt-3">Color Scheme</h5>
            <hr class="mt-1"/>

            <div class="form-check form-switch mb-1">
                <input type="checkbox" class="form-check-input" name="color-scheme-mode" value="light"
                       id="light-mode-check" checked/>
                <label class="form-check-label" for="light-mode-check">Light Mode</label>
            </div>

            <div class="form-check form-switch mb-1">
                <input type="checkbox" class="form-check-input" name="color-scheme-mode" value="dark"
                       id="dark-mode-check"/>
                <label class="form-check-label" for="dark-mode-check">Dark Mode</label>
            </div>

            <!-- Left Sidebar-->
            <h5 class="mt-4">Left Sidebar</h5>
            <hr class="mt-1"/>

            <div class="form-check form-switch mb-1">
                <input type="checkbox" class="form-check-input" name="compact" value="fixed" id="fixed-check"
                       checked/>
                <label class="form-check-label" for="fixed-check">Scrollable</label>
            </div>

            <div class="form-check form-switch mb-1">
                <input type="checkbox" class="form-check-input" name="compact" value="condensed"
                       id="condensed-check"/>
                <label class="form-check-label" for="condensed-check">Condensed</label>
            </div>

            <div class="d-grid mt-4">
                <button class="btn btn-primary" id="resetBtn">Reset to Default</button>

                <a href="https://themes.getbootstrap.com/product/hyper-responsive-admin-dashboard-template/"
                   class="btn btn-danger mt-3" target="_blank"><i class="mdi mdi-basket me-1"></i> Purchase
                    Now</a>
            </div>
        </div> <!-- end padding-->

    </div>
</div>

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

