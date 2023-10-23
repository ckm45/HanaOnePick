<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HanaOnePick에 오신 것을 환영합니다</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


    <link rel="stylesheet" href="../../resources/css/index.css">
    <link rel="stylesheet" href="../../resources/css/font.css">
</head>
<body>
<script
        src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"></script>
<%@ include file="../include/header.jsp" %>
<div class="bg-color">
    <br><br><br>
    <div class="main-section shadow">
        <div id="carouselExampleDark" class="carousel carousel-dark slide"
             data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="0" class="active" aria-current="true"
                        aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="10000">
                    <div class="main-bg">
                        <div class="main-word">
                            <div class="main-title">카드 결제 전엔 하나OnePick</div>
                            <div class="main-subtitle">
                                내 지갑 속 카드 중<br/> 할인이 많이 되는 카드를<br/> 콕! 찍어 알려드립니다.
                            </div>
                        </div>
                        <div class="character">
                            <img src="../../resources/img/mainbg1.png" alt="character">
                        </div>
                    </div>
                </div>
                <div class="carousel-item" data-bs-interval="2000">
                    <div class="main-bg">
                        <div class="main-word">
                            <div class="main-title">카드 결제 전엔 하나OnePick</div>
                            <div class="main-subtitle">
                                내 주변에서 속속 숨어있는 혜택들<br/> 싹! 찾아드립니다.
                            </div>
                        </div>
                        <div class="character">
                            <img src="../../resources/img/maintest1.png" alt="map_character">
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="main-bg">
                        <div class="main-word">
                            <div class="main-title">카드 결제 전엔 하나OnePick</div>
                            <div class="main-subtitle">
                                내 주변에서<br/> 속속 숨어있는 혜택들을 싹! 찾아드립니다.
                            </div>
                        </div>
                        <div class="character">
                            <img src="../../resources/img/maintest2.png"
                                 alt="character">
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button"
                    data-bs-target="#carouselExampleDark" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button"
                    data-bs-target="#carouselExampleDark" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <br/>
    <br/>
    <br/>
    <div class="main-category">
        <div class="row row-cols-1 row-cols-lg-3">
            <div class="col">
                <div class="p-3 bg-white shadow flex-container">
                    <img src="../../resources/img/money-icon.png" alt="cash_img" class="img-icon"/>
                    <span class="text-label"><a class="shop-link" href="/shop1">내 카드 실적보기</a></span>
                </div>
            </div>
            <div class="col">
                <div class="p-3 bg-white shadow flex-container">
                    <img src="../../resources/img/map-icon.png" alt="cash_img"
                         class="img-icon"/> <span class="text-label"><a class="shop-link" href="/shop2">내 주변 혜택 찾아보기</a></span>
                </div>
            </div>
            <div class="col">
                <div class="p-3 bg-white shadow flex-container">
                    <img src="../../resources/img/search-icon.png" alt="cash_img"
                         class="img-icon"/> <span class="text-label"><a class="shop-link"
                                                                        href="/shop3">특정 매장 찾아보기</a></span>
                </div>
            </div>
        </div>
    </div>
    <br>
    <br>

    <div class="card-row bg-white shadow">
        <div class="row" style="margin-bottom: 2%; margin-top: -3%">
            <div class="col d-flex justify-content-center align-items-center">
                <div class="d-flex align-items-center">
                    <img class="img-icon" src="../../resources/img/credit-card-icon.png" style="margin-right: 10px;">
                    <h2 style="margin-bottom: 3%">추천 카드</h2>
                </div>
            </div>
        </div>
        <!-- 여기부터 카드 리스트 테스트 -->
        <div class="row2">
            <div class="column2">
                <div class="card2">
                    <img src="../../resources/img/hanacard16.png"/>
                    <p class="fs-4">MULTI Any <br>모바일카드</p>
                    <p class="card-desc" style="font-size: 1vw;">전월 실적없이 어디서나 <br> 하나머니 적립</p>
                </div>
            </div>

            <div class="column2">
                <div class="card2">
                    <img src="../../resources/img/hanacard18.png"/>
                    <p class="fs-4">하나멤버스 1Q 카드 Shopping</p>
                    <p class="card-desc" style="font-size: 1vw;">포인트를 현금처럼 쓰는 <br>하나멤버스 신용카드</p>
                </div>
            </div>

            <div class="column2">
                <div class="card2">
                    <img src="../../resources/img/hanacard7.png"/>
                    <p class="fs-4">모두의 건강</p>
                    <br>
                    <p class="card-desc" style="font-size: 1vw;">모두의 건강을 선물합니다!</p>
                </div>
            </div>

            <div class="column2">
                <div class="card2">
                    <img src="../../resources/img/hanacard2.png"/>
                    <p class="fs-4">MULTI Living <br>모바일카드</p>
                    <p class="card-desc" style="font-size: 1vw;">주중/주말/매일 청구할인 혜택이 되는 카드</p>
                </div>
            </div>
        </div>
    </div>

    <br><br><br><br><br>
</div>



<!-- Notification Modal -->
<div class="modal fade" id="notificationModal" tabindex="-1" role="dialog" aria-labelledby="notificationModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="notificationModalLabel">혜택과 유용한 이벤트 정보를 알려드릴까요?</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p style="text-align: left; font-size: 1vw;">고객님의 똑똑한 카드 생활을 위해 마케팅 수신에 동의해주세요.</p>
                <div class="terms-container">
                    <input type="checkbox" id="term1" name="term1">
                    <label for="term1" onclick="showTermModal(1)">위치기반서비스</label><br>

                    <input type="checkbox" id="term2" name="term2">
                    <label for="term2" onclick="showTermModal(2)">마케팅정보 수신 동의 약관</label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="allowButton" disabled>허용</button>
            </div>
        </div>
    </div>
</div>

<!-- Term Modal 1 -->
<div class="modal fade" id="termModal1" tabindex="-1" aria-labelledby="termModal1Label" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="termModal1Label"
                    style="border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px;">하나원픽 위치기반서비스
                    약관</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style="text-align: left; overflow-y: auto; max-height: 70%;">
                <h3>제 1 조 (목적)</h3>
                <p style="text-align: left">본 약관은 회원(하나카드 위치기반서비스 약관에 동의한 자를 말합니다. 이하 “회원”이라고 합니다.)이 하나카드 주식회사(이하 “회사”라고
                    합니다.)가 제공하는
                    위치기반서비스(이하 “서비스”라고 합니다.)를 이용함에 있어 회사와 회원의 권리∙의무 및 책임사항을 규정함을 목적으로 합니다.</p>

                <h3>제 2 조 (이용약관의 효력 및 변경)</h3>
                <p style="text-align: left">① 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회
                    사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.<br>
                    ② 회원은 회사가 제시하는 방식(온라인, 서면, TM상담, ARS 등)으로 본 약관에 대한 사
                    항을 확인하고 동의를 표명한 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하
                    였으며, 그 적용에 동의한 것으로 봅니다.<br>
                    ③ 회사는 위치정보의 보호 및 이용 등에 관한 법률, 콘텐츠산업 진흥법, 전자상거래 등
                    에서의 소비자보호에 관한 법률, 소비자기본법, 약관의 규제에 관한 법률 등 관련법
                    령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.<br>
                    ④ 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개
                    정사유를 명시하여 기존약관과 함께 그 적용일자 10일 전부터 적용일 이후 상당한
                    기간 동안 공지만을 하고, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일
                    전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하거나 회
                    원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다.<br>
                    ⑤ 회사가 전항에 따라 회원에게 통지하면서 공지 또는 공지∙고지일로부터 개정약관 시
                    행일 7일 후까지 거부의사를 표시하지 아니하면 이용약관에 승인한 것으로 봅니다.
                    회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.</p>

                <h3>제 3 조 (관계법령의 적용)</h3>
                <p style="text-align: left"> 본 약관은 신의성실의 원칙에 따라 공정하게 적용하며, 본 약관에 명시되지 아니한 사항
                    에 대하여는 관계법령 또는 상관례에 따릅니다.</p>

                <h3>제 4 조 (서비스의 내용)</h3>
                <p style="text-align: left">회사가 제공하는 서비스는 아래와 같습니다.
                    서비스명 서비스 내용
                    하나카드 위치기반서비스
                    - 당사 및 제휴사 상품 서비스 정보 제공
                    - 당사 및 제휴사 마케팅 서비스 제공
                    - 당사 및 제휴사 프로모션 혜택 알림 제공</p>
                <ul>
                    <li>서비스명 서비스 내용</li>
                    <li>하나카드 위치기반서비스</li>
                    <ul>
                        <li>- 당사 및 제휴사 상품 서비스 정보 제공</li>
                        <li>- 당사 및 제휴사 마케팅 서비스 제공</li>
                        <li>- 당사 및 제휴사 프로모션 혜택 알림 제공</li>
                    </ul>
                </ul>

                <h3>제 5 조 (서비스 이용요금)</h3>
                <p style="text-align: left"> ① 회사가 제공하는 서비스는 기본적으로 무료입니다. 단, 별도의 유료 서비스의 경우
                    해당 서비스에 명시된 요금을 지불하여야 사용 가능합니다.<br>
                    ② 회사는 유료 서비스 이용요금을 회사와 계약한 전자지불업체에서 정한 방법에 의하
                    거나 회사가 정한 청구서에 합산하여 청구할 수 있습니다.<br>
                    ③ 유료서비스 이용을 통하여 결제된 대금에 대한 취소 및 환불은 회사의 결제 이용약
                    관 등 관계법에 따릅니다.<br>
                    ④ 회원의 개인정보도용 및 결제 사기로 인한 환불요청 또는 결제자의 개인정보 요구는
                    법률이 정한 경우 외에는 거절될 수 있습니다.<br>
                    ⑤ 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며 가입한 각 이동통신사의
                    정책에 따릅니다.<br>
                    ⑥ MMS 등으로 게시물을 등록할 경우 발생하는 요금은 이동통신사의 정책에 따릅니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Modal for Term 2 -->
<div class="modal fade" id="termModal2" tabindex="-1" aria-labelledby="termModal2Label" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="termModal2Label">하나원픽 마케팅정보 수신 동의 약관</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h3>1. 마케팅 및 광고에의 활용</h3>
                <ul>
                    <li>신규 기능 개발 및 맞춤 서비스 제공</li>
                    <li>뉴스레터 발송, 새로운 기능의 안내</li>
                    <li>할인 및 쿠폰 등 이벤트 등의 광고성 정보 제공</li>
                </ul>

                <h3>2. 마케팅 정보 제공</h3>
                <p style="text-align: left">
                    회사는 서비스를 운용하는 과정에서 각종 정보를 푸시알림, 이메일, SMS 및 카카오 친구톡 등의 방법으로 회원에게 제공할 수 있습니다. 단, 광고성 정보
                    이외에 의무적으로 안내되어야 하는 정보성 내용은
                    수신동의 여부와 무관하게 제공합니다.
                </p>

                <h3>3. 수신 동의 및 철회</h3>
                <p style="text-align: left">
                    수신 동의 이후에도 의사에 따라 동의를 철회할 수 있으며, 수신을 동의하지 않아도 회사에서 제공하는 기본적인 서비스를 이용할 수 있으나 회사가 제공하는 마케팅
                    정보를 수신하지 못할 수 있습니다. 고객이
                    본
                    수신 동의를 철회하고자 할 경우 앱내 알림 설정 또는 고객센터를 통하여 수신 동의 철회를 요청할 수 있습니다. 또한 향후 마케팅정보 수신에 새롭게 동의하고자 할 경우 앱내 알림 설정에서 동의하실 수
                    있습니다.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    window.isLogged = <c:out value="${not empty sessionScope.dto}" default="false" />;
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const checkboxes = document.querySelectorAll('.terms-container input[type="checkbox"]');
        const allowButton = document.getElementById('allowButton');

        function updateButtonState() {
            let allChecked = true;
            checkboxes.forEach(checkbox => {
                if (!checkbox.checked) {
                    allChecked = false;
                }
            });

            allowButton.disabled = !allChecked;
        }

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateButtonState);
        });
    });


    function showTermModal(termId) {
        var modalId = 'termModal' + termId;
        var termModal = new bootstrap.Modal(document.getElementById(modalId), {});
        termModal.show();
    }

    function closeTermModal(termId) {
        var modalId = 'termModal' + termId;
        var termModal = bootstrap.Modal.getInstance(document.getElementById(modalId));
        termModal.hide();
    }
</script>
<script type="module" src="../../resources/js/index.js"></script>
<%@ include file="../include/footer.jsp" %>
</body>

</html>