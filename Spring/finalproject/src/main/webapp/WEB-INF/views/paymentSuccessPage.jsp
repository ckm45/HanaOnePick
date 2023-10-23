<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Untree.co">
    <link rel="shortcut icon" href="favicon.png">

    <meta name="description" content=""/>
    <meta name="keywords" content="bootstrap, bootstrap4"/>

    <!-- Bootstrap CSS -->
    <link href="../../resources/cart/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="../../resources/cart/css/tiny-slider.css" rel="stylesheet">
    <link href="../../resources/cart/css/style.css" rel="stylesheet">
    <script src="/webjars/jquery/3.6.0/jquery.min.js"></script>
    <title>결제 완료 페이지</title>
</head>
<body>

<!-- Start Header/Navigation -->
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

    <div class="container">
        <a href="/shop3" class="navbar-brand ms-4 ms-lg-0">
            <img src="../../resources/shop3/img/starbuckslogo.png" class="me-3">
            스타벅스 코리아
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item ">
                    <a class="nav-link" href="/shop3">Home</a>
                </li>
                <li><a class="nav-link" href="about.html">About us</a></li>
                <li><a class="nav-link" href="services.html">Products</a></li>
            </ul>

            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <li><a class="nav-link" href="/getCartPage"><img src="../../resources/cart/img/cart.svg"></a></li>
            </ul>
        </div>
    </div>

</nav>
<!-- End Header/Navigation -->

<!-- Start Hero Section -->
<div class="hero">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-5">
                <div class="intro-excerpt">
                </div>
            </div>
            <div class="col-lg-7">
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->


<div class="untree_co-section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center pt-5 bg-white">
          <span class="display-3 thankyou-icon text-primary">
            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-cart-check mb-5" fill="currentColor"
                 xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                    d="M11.354 5.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
              <path fill-rule="evenodd"
                    d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm7 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
            </svg>
          </span>
                <h2 class="display-3 text-black">결제 완료!</h2>
                <p class="lead mb-3">결제 장소 : ${storeName}</p>
                <p class="lead mb-3">상품 금액 : <fmt:formatNumber value="${price}" type="number" pattern="#,### 원"/></p>
                <p class="lead mb-3">혜택 금액 :
                    <c:choose>
                        <c:when test="${fn:substring(benefitDTO.benefitCode, 2, 3) eq 'P'}">
                            <c:set var="benefitPrice" value="${price * benefitDTO.benefitAmount / 100}"/>
                            <fmt:formatNumber value="${benefitPrice}" type="number" pattern="#,### 원"/>
                            <c:choose>
                                <c:when test="${fn:substring(benefitDTO.benefitCode, 0, 2) eq 'DC'}">할인</c:when>
                                <c:otherwise>적립</c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${fn:substring(benefitDTO.benefitCode,2 , 3) eq 'V'}">
                            <c:set var="benefitPrice" value="${price - benefitDTO.benefitAmount}"/>
                            <fmt:formatNumber value="${benefitPrice}" type="number" pattern="#,### 원"/>
                        </c:when>
                    </c:choose>
                </p>
                <c:choose>
                    <c:when test="${fn:substring(benefitDTO.benefitCode,0 ,2) eq 'DC'}">
                        <p class="lead mb-3">결제 금액 : <fmt:formatNumber value="${price - benefitPrice}" type="number"
                                                                       pattern="#,### 원"/></p>
                    </c:when>
                    <c:when test="${fn:substring(benefitDTO.benefitCode,0 ,2) eq 'AC'}">
                        <p class="lead mb-3">결제 금액 : <fmt:formatNumber value="${price}" type="number"
                                                                       pattern="#,### 원"/></p>
                    </c:when>
                </c:choose>
                <p class="lead mb-5">이번달에 같은 혜택을 받은 횟수 : ${benefitCount} 회</p>
            </div>
        </div>
    </div>
</div>

<script src="../../resources/cart/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/cart/js/tiny-slider.js"></script>
<script src="../../resources/cart/js/custom.js"></script>
</body>

</html>
