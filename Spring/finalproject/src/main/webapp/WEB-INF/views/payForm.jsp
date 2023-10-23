<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>구매 페이지</title>
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
                    <h1>결제하기</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<div class="untree_co-section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 mb-5 mb-md-0">
                <h2 class="h3 mb-3 text-black">결제 정보</h2>
                <div class="p-3 p-lg-5 border bg-white">
                    <h1>결제 장소 : ${storeName}</h1>
                    <br>
                    <form id="paymentForm" action="/submitPayment" method="post">
                        <h5>결제할 카드를 골라주세요.</h5>
                        <select class="form-select w-25" aria-label="Default select example" name="cardId"
                                id="cardSelect">
                            <option selected>Open this select menu</option>
                            <c:forEach items="${myCardList}" var="card">
                                <option value="${card.cardId}">${card.cardName}</option>
                            </c:forEach>
                        </select>

                        <br>
                        <div id="cardImageContainer">
                        </div>

                        <br>
                        <br>
                        <br>

                        <table class="table site-block-order-table mb-5">
                            <thead>
                            <th class="fs-4">Product</th>
                            <th class="fs-4">Total</th>
                            </thead>
                            <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td class="fs-5">${item.productName}</td>
                                    <td class="fs-5"><fmt:formatNumber value="${item.price}" type="number" pattern="#,### 원"/></td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td class="text-black font-weight-bold fs-5"><strong>전체 결제 금액</strong></td>
                                <td class="text-black fs-5"><c:forEach var="product" items="${cartItems}">
                                    <c:set var="totalPrice" value="${totalPrice + product.price}"/>
                                </c:forEach>
                                    <strong class="text-black"><fmt:formatNumber value="${totalPrice}" type="number"
                                                                                 pattern="#,### 원"/></strong></td>
                            </tr>
                            </tbody>
                        </table>
                        <input type="hidden" name="storeName" value="${storeName}">
                        <input type="hidden" name="price" value="${totalPrice}">
                        <input type="hidden" name="storeCategoryCode" value="${storeCategoryCode}">
                        <button type="submit" class="btn btn-primary">결제하기</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- </form> -->
    </div>
</div>

<script>

    document.getElementById('cardSelect').addEventListener('change', function () {

        var selectedCardId = this.value;

        var cardImageContainer = document.getElementById('cardImageContainer');

        cardImageContainer.innerHTML = '<img src="../../resources/img/hanacard' + selectedCardId + '.png" alt="Card Image">';
    });
</script>

<script src="../../resources/cart/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/cart/js/tiny-slider.js"></script>
<script src="../../resources/cart/js/custom.js"></script>
</body>

</html>

