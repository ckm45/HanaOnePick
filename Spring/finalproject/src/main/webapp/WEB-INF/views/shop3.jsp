<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>StarBucks</title>
    <!-- Favicon -->
    <link href="../../resources/shop1/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Lora:wght@600;700&display=swap"
          rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../../resources/shop1/lib/animate/animate.min.css" rel="stylesheet">
    <link href="../../resources/shop1/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <link href="../../resources/css/font.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../../resources/shop1/css/bootstrap.min.css" rel="stylesheet">


    <!-- Template Stylesheet -->
    <link href="../../resources/shop1/css/style.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @font-face {
            font-family: 'Hana2-CM';
            src: url('../../resources/fonts/Hana2-CM.ttf') format('truetype');

            font-weight: normal;
            font-style: normal;
        }


        body {
            font-family: 'Hana2-CM', sans-serif !important;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light py-lg-0 px-lg-5 wow fadeIn" data-wow-delay="0.1s"
     style="visibility: visible; animation-delay: 0.1s; animation-name: fadeIn;">
    <a href="/shop3" class="navbar-brand ms-4 ms-lg-0">
        <img src="../../resources/shop3/img/starbuckslogo.png">
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="/shop3" class="nav-item nav-link">Home</a>
            <a href="/shop3" class="nav-item nav-link">About Us</a>
            <a href="/shop3" class="nav-item nav-link active">Products</a>
        </div>
        <div class="d-none d-lg-flex ms-2">
            <a class="btn-sm-square bg-white rounded-circle ms-3" href="/getCartPage">
                <small class="fa fa-shopping-bag text-body"></small>
            </a>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row g-0 gx-5 align-items-end">
        <div class="col-lg-6">
            <div class="section-header text-start mb-5 wow fadeInUp" data-wow-delay="0.1s"
                 style="max-width: 500px; visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                <h1 class="display-5 mb-3">스타벅스 철산역점</h1>
                <p><img src="../../resources/shop3/img/starbuckslogo2.png"></p>
            </div>
        </div>
        <div class="col-lg-6 text-start text-lg-end wow slideInRight" data-wow-delay="0.1s"
             style="visibility: visible; animation-delay: 0.1s; animation-name: slideInRight;">
            <ul class="nav nav-pills d-inline-flex justify-content-end mb-5">
                <li class="nav-item me-2">
                    <a class="btn btn-outline-primary border-2 active" data-bs-toggle="pill" href="/shop3">Coffee</a>
                </li>
                <li class="nav-item me-2">
                    <a class="btn btn-outline-primary border-2" data-bs-toggle="pill" href="/shop3">Menu</a>
                </li>
                <li class="nav-item me-0">
                    <a class="btn btn-outline-primary border-2" data-bs-toggle="pill" href="/shop3">Store</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="tab-content">
        <div id="tab-1" class="tab-pane fade show p-0 active">
            <div class="row g-4">
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s"
                     style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/돌체 콜드 브루.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h5 mb-2" href="#" onclick="submitProduct(this)">돌체 콜드 브루</a>
                            <span class="text-primary me-1" style="color:#000 !important;">6,000원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="돌체 콜드 브루" data-price="6000"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s"
                     style="visibility: visible; animation-delay: 0.3s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/딸기 딜라이트 요거트 블렌디드.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h6 mb-2" href="#" onclick="submitProduct(this)">딸기 딜라이트 요거트 블렌디드</a>
                            <span class="text-primary me-1" style="color: black !important;">6,300원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="딸기 딜라이트 요거트 블렌디드" data-price="6300"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s"
                     style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/망고 패션 티 블렌디드.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h5 mb-2" href="#" onclick="submitProduct(this)">망고 패션 티 블렌디드</a>
                            <span class="text-primary me-1" style="color: black !important;">5,400원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="망고 패션 티 블렌디드" data-price="5400"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.7s"
                     style="visibility: visible; animation-delay: 0.7s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/아이스 자몽 허니 블랙 티.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h5 mb-2" href="#" onclick="submitProduct(this)">아이스 자몽 허니 블랙 티</a>
                            <span class="text-primary me-1" style="color: black !important;">5,700원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="아이스 자몽 허니 블랙 티" data-price="5700"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s"
                     style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/아이스 카페 아메리카노.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h5 mb-2" href="#" onclick="submitProduct(this)">아이스 카페 아메리카노</a>
                            <span class="text-primary me-1" style="color: black !important;">4,500원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="아이스 카페 아메리카노" data-price="4500"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s"
                     style="visibility: visible; animation-delay: 0.3s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/제주 시트러스 허니 콜드 브루.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h6 mb-2" href="#" onclick="submitProduct(this)">제주 시트러스 허니 콜드 브루</a>
                            <span class="text-primary me-1" style="color: black !important;">7,200원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="제주 시트러스 허니 콜드 브루" data-price="7200"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s"
                     style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/제주 유기농 말차로 만든 크림 프라푸치노.jpg"
                                 alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h6 mb-2" href="#" onclick="submitProduct(this)">제주 유기농 말차로 만든 크림 프라푸치노</a>
                            <span class="text-primary me-1" style="color:black !important;">6,300원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="제주 유기농 말차로 만든 크림 프라푸치노" data-price="6300"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.7s"
                     style="visibility: visible; animation-delay: 0.7s; animation-name: fadeInUp;">
                    <div class="product-item">
                        <div class="position-relative bg-light overflow-hidden">
                            <img class="img-fluid w-100" src="../../resources/shop3/img/콜드 브루.jpg" alt="">
                        </div>
                        <div class="text-center p-4">
                            <a class="d-block h5 mb-2" href="#" onclick="submitProduct(this)">콜드 브루</a>
                            <span class="text-primary me-1" STYLE="color: black !important;">4,900원</span>
                        </div>
                        <div class="d-flex border-top">
                            <small class="w-50 text-center border-end py-2">
                                <a class="text-body" href="#" onclick="submitProduct(this)"><i
                                        class="fa fa-eye text-primary me-2"></i>자세히 보기</a>
                            </small>
                            <small class="w-50 text-center py-2">
                                <a class="text-body" data-productname="콜드 브루" data-price="4900"
                                   onclick="addToCart(this)"><i class="fa fa-shopping-bag text-primary me-2"></i>장바구니 담기</a>
                            </small>
                        </div>


                        <script>
                            function addToCart(element) {
                                var productName = element.getAttribute("data-productname");
                                var price = parseFloat(element.getAttribute("data-price"));

                                console.log(productName, price);

                                $.post("/addToCart", {productName: productName, price: price}, function () {
                                    console.log("productName" + productName + "price" + price)
                                    alert("장바구니에 담겼습니다.");
                                }).fail(function () {
                                    console.log("Error: Request failed.");
                                });
                            }
                        </script>
                    </div>
                </div>
                <div class="col-12 text-center wow fadeInUp mt-5" data-wow-delay="0.1s"
                     style="visibility: visible; animation-delay: 0.1s; animation-name: fadeInUp; display: none">
                    <a class="btn btn-primary rounded-pill py-3 px-5" href="">Browse More Products</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer Start -->
<div class="container-fluid bg-dark footer pt-5 wow fadeIn" data-wow-delay="0.1s" style="display: none">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h1 class="fw-bold text-primary mb-4">F<span class="text-secondary">oo</span>dy</h1>
                <p>Diam dolor diam ipsum sit. Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit, sed stet
                    lorem sit clita</p>
                <div class="d-flex pt-2">
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i
                            class="fab fa-twitter"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i
                            class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-1" href=""><i
                            class="fab fa-youtube"></i></a>
                    <a class="btn btn-square btn-outline-light rounded-circle me-0" href=""><i
                            class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Address</h4>
                <p><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                <p><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                <p><i class="fa fa-envelope me-3"></i>info@example.com</p>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Quick Links</h4>
                <a class="btn btn-link" href="">About Us</a>
                <a class="btn btn-link" href="">Contact Us</a>
                <a class="btn btn-link" href="">Our Services</a>
                <a class="btn btn-link" href="">Terms & Condition</a>
                <a class="btn btn-link" href="">Support</a>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-light mb-4">Newsletter</h4>
                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                <div class="position-relative mx-auto" style="max-width: 400px;">
                    <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text"
                           placeholder="Your email">
                    <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid copyright">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->
<!-- JavaScript Libraries -->
<script>
    function submitProduct(link) {
        var productName = link.innerText;
        console.log(productName);
        var price = link.parentElement.querySelector('.text-primary').innerText;
        var productContent = '';
        var product_calory = '';
        var product_natrium = '';
        var product_sugar = '';
        var product_protein = '';
        var product_caffeine = '';
        var product_saturatedFat = '';

        if (productName === '돌체 콜드 브루') {
            productContent = `무더운 여름철,
        동남아 휴가지에서 즐기는 커피를 떠오르게 하는
        스타벅스 음료의 베스트 x 베스트 조합인
        돌체 콜드 브루를 만나보세요!`;
        } else if (productName === '딸기 딜라이트 요거트 블렌디드') {
            productContent = `유산균이 살아있는 리얼 요거트와 풍성한 딸기 과육이
        더욱 상큼하게 어우러진 과일 요거트 블렌디드`;
        } else if (productName === '망고 패션 티 블렌디드') {
            productContent = `망고 패션 프루트 주스와 패션 탱고 티가
상큼하게 어우러진 과일 블렌디드`;
            product_calory = '150'
            product_natrium = '105'
            product_sugar = '29'
            product_protein = '2'
            product_caffeine = '0'
            product_saturatedFat = '0'
        } else if (productName === '아이스 자몽 허니 블랙 티') {
            productContent = `새콤한 자몽과 달콤한 꿀이 깊고 그윽한 풍미의 스타벅스 티바나 블랙 티의 조화.
한정된 기간 동안 판매하는 트렌타 사이즈로 즐겨 보세요.`;
        } else if (productName === '아이스 카페 아메리카노') {
            productContent = `진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피`;
        } else if (productName === '제주 시트러스 허니 콜드 브루') {
            productContent = `제주에서 특별하게 즐기는 커피 & 티 베리에이션 스타일의 콜드 브루 음료
제주 유채꿀, 민트 티, 콜드 브루의 이색적인 조화`;
        } else if (productName === '제주 유기농 말차로 만든 크림 프라푸치노') {
            productContent = `깊고 진한 말차 본연의 맛과 향을 시원하고 부드럽게 즐길 수 있는 프라푸치노`;
        } else {
            productContent = `스타벅스 바리스타의 정성으로 탄생한 콜드 브루!
콜드 브루 전용 원두를 차가운 물로 추출하여 한정된 양만 제공됩니다.
실크같이 부드럽고 그윽한 초콜릿 풍미의 콜드 브루를 만나보세요!`;


        }

        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/shop3/detail");

        var productNameInput = document.createElement("input");
        productNameInput.setAttribute("type", "hidden");
        productNameInput.setAttribute("name", "productName");
        productNameInput.setAttribute("value", productName);

        var priceInput = document.createElement("input");
        priceInput.setAttribute("type", "hidden");
        priceInput.setAttribute("name", "price");
        priceInput.setAttribute("value", price);

        var productContentInput = document.createElement("input");
        productContentInput.setAttribute("type", "hidden");
        productContentInput.setAttribute("name", "productContent");
        productContentInput.setAttribute("value", productContent);

        var product_caloryInput = document.createElement("input");
        product_caloryInput.setAttribute("type", "hidden");
        product_caloryInput.setAttribute("name", "product_calory");
        product_caloryInput.setAttribute("value", product_calory);

        var product_natriumInput = document.createElement("input");
        product_natriumInput.setAttribute("type", "hidden");
        product_natriumInput.setAttribute("name", "product_natrium");
        product_natriumInput.setAttribute("value", product_natrium);

        var product_sugarInput = document.createElement("input");
        product_sugarInput.setAttribute("type", "hidden");
        product_sugarInput.setAttribute("name", "product_sugar");
        product_sugarInput.setAttribute("value", product_sugar);

        var product_proteinInput = document.createElement("input");
        product_proteinInput.setAttribute("type", "hidden");
        product_proteinInput.setAttribute("name", "product_protein");
        product_proteinInput.setAttribute("value", product_protein);

        var product_caffeineInput = document.createElement("input");
        product_caffeineInput.setAttribute("type", "hidden");
        product_caffeineInput.setAttribute("name", "product_caffeine");
        product_caffeineInput.setAttribute("value", product_caffeine);

        var product_saturatedFatInput = document.createElement("input");
        product_saturatedFatInput.setAttribute("type", "hidden");
        product_saturatedFatInput.setAttribute("name", "product_saturatedFat");
        product_saturatedFatInput.setAttribute("value", product_saturatedFat);

        form.appendChild(product_caloryInput);
        form.appendChild(product_natriumInput);
        form.appendChild(product_sugarInput);
        form.appendChild(product_proteinInput);
        form.appendChild(product_caffeineInput);
        form.appendChild(product_saturatedFatInput);
        form.appendChild(productNameInput);
        form.appendChild(priceInput);
        form.appendChild(productContentInput);

        document.body.appendChild(form);
        form.submit();
    }
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/shop1/lib/wow/wow.min.js"></script>
<script src="../../resources/shop1/lib/easing/easing.min.js"></script>
<script src="../../resources/shop1/lib/waypoints/waypoints.min.js"></script>
<script src="../../resources/shop1/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="../../resources/shop1/js/main.js"></script>
</body>
</html>
