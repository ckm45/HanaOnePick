<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>StarBucks Products</title>

    <link rel="apple-touch-icon" href="../../resources/shop1-detail/assets/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/shop1-detail/assets/img/favicon.ico">

    <link rel="stylesheet" href="../../resources/shop1-detail/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../resources/shop1-detail/assets/css/templatemo.css">
    <link rel="stylesheet" href="../../resources/shop1-detail/assets/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="../../resources/shop1-detail/assets/css/fontawesome.min.css">

    <!-- Slick -->
    <link rel="stylesheet" type="text/css" href="../../resources/shop1-detail/assets/css/slick.min.css">
    <link rel="stylesheet" type="text/css" href="../../resources/shop1-detail/assets/css/slick-theme.css">


    <!-- nav바 -->

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

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../../resources/shop1/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
<section class="bg-light">
    <div class="container pb-5">
        <div class="row">
            <div class="col-lg-5 mt-5">
                <div class="card mb-3">
                    <img class="card-img img-fluid" src="../../resources/shop3/img/${productName}.jpg"
                         alt="Card image cap" id="product-detail">
                </div>
                <div class="row">
                    <!--Start Controls-->
                    <div class="col-1 align-self-center">
                        <a href="#multi-item-example" role="button" data-bs-slide="prev">
                            <i class="text-dark fas fa-chevron-left"></i>
                            <span class="sr-only">Previous</span>
                        </a>
                    </div>
                    <!--End Controls-->
                    <!--Start Carousel Wrapper-->
                    <div id="multi-item-example" class="col-10 carousel slide carousel-multi-item pointer-event"
                         data-bs-ride="carousel">
                        <!--Start Slides-->
                        <div class="carousel-inner product-links-wap" role="listbox">

                            <!--First slide-->
                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 1">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image2">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 3">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!--/.First slide-->

                            <!--Second slide-->
                            <div class="carousel-item">
                                <div class="row">
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 4">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 5">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 6">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!--/.Second slide-->

                            <!--Third slide-->
                            <div class="carousel-item">
                                <div class="row">
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 7">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 8">
                                        </a>
                                    </div>
                                    <div class="col-4">
                                        <a href="#">
                                            <img class="card-img img-fluid"
                                                 src="../../resources/shop3/img/${productName}.jpg"
                                                 alt="Product Image 9">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!--/.Third slide-->
                        </div>
                        <!--End Slides-->
                    </div>
                    <!--End Carousel Wrapper-->
                    <!--Start Controls-->
                    <div class="col-1 align-self-center">
                        <a href="#multi-item-example" role="button" data-bs-slide="next">
                            <i class="text-dark fas fa-chevron-right"></i>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <!--End Controls-->
                </div>
            </div>
            <!-- col end -->
            <div class="col-lg-7 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h1 class="h2">${productName}</h1>
                        <p class="h3 py-2">${price}</p>
                        <p class="py-2">
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <span class="list-inline-item text-dark">Rating 4.8 | 36 Comments</span>
                        </p>
                        <ul class="list-inline">
                            <li class="list-inline-item">
                                <h6>Brand:</h6>
                            </li>
                            <li class="list-inline-item">
                                <p class="text-muted"><strong>StarBucks</strong></p>
                            </li>
                        </ul>

                        <h6>Description:</h6>
                        <p>${productContent}</p>
                        <ul class="list-inline">
                            <li class="list-inline-item">
                                <h6>Avaliable Color :</h6>
                            </li>
                            <li class="list-inline-item">
                                <p class="text-muted"><strong>ICE / HOT</strong></p>
                            </li>
                        </ul>

                        <h6>제품 영양 정보:</h6>
                        <table class="table table-bordered table-striped">
                            <tbody>
                            <tr>
                                <th scope="row">1회 제공량 (kcal)</th>
                                <td>${product_calory}</td>
                            </tr>
                            <tr>
                                <th scope="row">나트륨 (mg)</th>
                                <td>${product_natrium}</td>
                            </tr>
                            <tr>
                                <th scope="row">포화지방 (g)</th>
                                <td>${product_saturatedFat}</td>
                            </tr>
                            <tr>
                                <th scope="row">당류 (g)</th>
                                <td>${product_sugar}</td>
                            </tr>
                            <tr>
                                <th scope="row">카페인 (mg)</th>
                                <td>${product_caffeine}</td>
                            </tr>
                            <tr>
                                <th scope="row">단백질 (g)</th>
                                <td>${product_protein}</td>
                            </tr>
                            </tbody>
                        </table>

                        <form action="/payForm" method="POST">
                            <input type="hidden" name="productName" value="${productName}">
                            <input type="hidden" name="productPrice" value="${price}">
                            <input type="hidden" name="storeName" value="스타벅스 철산역점">
                            <input type="hidden" name="storeCategoryCode" value="CE">
                            <input type="hidden" name="product-title" value="Activewear">
                            <div class="row">
                                <div class="col-auto">
                                    <ul class="list-inline pb-3">
                                        <li class="list-inline-item text-right">
                                            Quantity
                                            <input type="hidden" name="product-quanity" id="product-quanity" value="1">
                                        </li>
                                        <li class="list-inline-item"><span class="btn btn-success"
                                                                           id="btn-minus">-</span></li>
                                        <li class="list-inline-item"><span class="badge bg-secondary"
                                                                           id="var-value">1</span></li>
                                        <li class="list-inline-item"><span class="btn btn-success"
                                                                           id="btn-plus">+</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="row pb-3">
                                <div class="col d-grid">
                                    <button type="submit" class="btn btn-success btn-lg" name="submit" value="buy">
                                        구매하기
                                    </button>
                                </div>
                                <div class="col d-grid">
                                    <button type="submit" class="btn btn-success btn-lg" name="submit" value="addtocard"
                                            data-productname='${productName}' data-price='${price}'
                                            onclick="addToCart(this, event)">장바구니 담기
                                    </button>
                                </div>
                            </div>
                        </form>
                        <script>
                            function formatPrice(priceString) {
                                return priceString.replace(/,|원/g, '').trim();
                            }

                            function addToCart(element, event) {
                                event.preventDefault();
                                var productName = element.getAttribute("data-productname");
                                var price = element.getAttribute("data-price");

                                console.log(productName, price);

                                $.post("/addToCart", {productName: productName, price: formatPrice(price)}, function () {
                                    console.log("productName" + productName + "price" + formatPrice(price))
                                    alert("장바구니에 담겼습니다.");
                                }).fail(function () {
                                    console.log("Error: Request failed.");
                                });
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Start Script -->
<script src="../../resources/shop1-detail/assets/js/jquery-1.11.0.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/jquery-migrate-1.2.1.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/templatemo.js"></script>
<script src="../../resources/shop1-detail/assets/js/custom.js"></script>
<!-- End Script -->

<!-- Start Slider Script -->
<script src="../../resources/shop1-detail/assets/js/slick.min.js"></script>
<script>
    $('#carousel-related-product').slick({
        infinite: true,
        arrows: false,
        slidesToShow: 4,
        slidesToScroll: 3,
        dots: true,
        responsive: [{
            breakpoint: 1024,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3
            }
        },
            {
                breakpoint: 600,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 3
                }
            }
        ]
    });
</script>


<script src="../../resources/shop1/lib/wow/wow.min.js"></script>
<script src="../../resources/shop1/lib/easing/easing.min.js"></script>
<script src="../../resources/shop1/lib/waypoints/waypoints.min.js"></script>
<script src="../../resources/shop1/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="../../resources/shop1/js/main.js"></script>


<!-- Start Script -->
<script src="../../resources/shop1-detail/assets/js/jquery-1.11.0.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/jquery-migrate-1.2.1.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../resources/shop1-detail/assets/js/templatemo.js"></script>
<script src="../../resources/shop1-detail/assets/js/custom.js"></script>
<!-- End Script -->

<!-- Start Slider Script -->
<script src="../../resources/shop1-detail/assets/js/slick.min.js"></script>
<script>
    $('#carousel-related-product').slick({
        infinite: true,
        arrows: false,
        slidesToShow: 4,
        slidesToScroll: 3,
        dots: true,
        responsive: [{
            breakpoint: 1024,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3
            }
        },
            {
                breakpoint: 600,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 3
                }
            }
        ]
    });
</script>
<!-- End Slider Script -->

<!-- End Slider Script -->
</body>
</html>
