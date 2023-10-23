<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Untree.co">
    <link rel="shortcut icon" href="favicon.png">

    <meta name="description" content="" />
    <meta name="keywords" content="bootstrap, bootstrap4" />

    <!-- Bootstrap CSS -->
    <link href="../../resources/cart/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="../../resources/cart/css/tiny-slider.css" rel="stylesheet">
    <link href="../../resources/cart/css/style.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <title>장바구니</title>
</head>

<body>

<!-- Start Header/Navigation -->
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

    <div class="container">
        <a href="/shop3" class="navbar-brand ms-4 ms-lg-0">
            <img src="../../resources/shop3/img/starbuckslogo.png" class="me-3">
            스타벅스 코리아
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
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
                    <h1>장바구니</h1>
                </div>
            </div>
            <div class="col-lg-7">

            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->



<div class="untree_co-section before-footer-section">
    <div class="container">
        <div class="row mb-5">
            <form class="col-md-12" method="post">
                <div class="site-blocks-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="product-thumbnail">Image</th>
                            <th class="product-name">Product</th>
                            <th class="product-price">Price</th>
                            <th class="product-quantity">Quantity</th>
                            <th class="product-total">Total</th>
                            <th class="product-remove">Remove</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${cartItems}">
                        <tr>
                            <td class="product-thumbnail">
                                <img src="../../resources/shop3/img/${product.productName}.jpg" alt="Image" class="img-fluid">
                            </td>
                            <td class="product-name">
                                <h2 class="h5 text-black">${product.productName}</h2>
                            </td>
                            <td><fmt:formatNumber value="${product.price}" type="number" pattern="#,### 원"/></td>
                            <td>
                                <div class="input-group mb-3 d-flex align-items-center quantity-container" style="max-width: 120px;">
                                    <div class="input-group-prepend">
                                        <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                    </div>
                                    <input type="text" class="form-control text-center quantity-amount" value="1" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                    </div>
                                </div>

                            </td>
                            <td><fmt:formatNumber value="${product.price}" type="number" pattern="#,### 원"/></td>
                            <td><button type="button" class="btn btn-black btn-sm">X</button></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>

        <div class="row">
            <div class="col-md-12 pl-5">
                <div class="row justify-content-end">
                    <div class="col-md-7 border border-3 rounded-3 p-5" style="background-color: #fffefe">
                        <div class="row">
                            <div class="col-md-12 text-right border-bottom mb-5">
                                <h3 class="text-black h4 text-uppercase">장바구니 총합</h3>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <span class="text-black fs-4">총 금액</span>
                            </div>
                            <div class="col-md-6 text-right fs-4">
                                <c:forEach var="product" items="${cartItems}">
                                    <c:set var="totalPrice" value="${totalPrice + product.price}"/>
                                </c:forEach>
                                <strong class="text-black"><fmt:formatNumber value="${totalPrice}" type="number" pattern="#,### 원"/></strong>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-black btn-lg py-3 btn-block" onclick="window.location='/payForm'">결제 진행하기</button>
                            </div>
                        </div>

                    </div>
                </div>
                <br><br>
                <hr>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $(".btn-black").click(function(event) {
            event.preventDefault();

            var productName = $(this).closest("tr").find(".h5.text-black").text();

            $.ajax({
                url: '/removeFromCart',
                type: 'POST',
                data: { productName: productName },
                success: function(response) {
                    if(response.success) {
                        $(event.target).closest("tr").remove();
                    } else {
                        alert('Error removing item.');
                    }
                },
                error: function(error) {
                    console.error("Error:", error);
                    alert('Failed to remove item. Please try again.');
                }
            });
        });
    });

</script>
<script src="../../resources/cart/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/cart/js/tiny-slider.js"></script>
<script src="../../resources/cart/js/custom.js"></script>
</body>

</html>
