<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous">
    <link rel="stylesheet" href="../../resources/css/header.css">
</head>
<body>
<div class="container">
    <footer
            class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
        <div class="col-md-4 d-flex align-items-center">
            <a href="/"
               class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">

                <img src="../../resources/img/img-hana-symbol.png" alt="logo"
                     class="nav-logo" width="30" height="24">
            </a> <span class="mb-3 mb-md-0 text-body-secondary">© 2023
                    Company, Inc</span>
        </div>
        <div class="nav col-md-4 justify-content-end list-unstyled d-flex" style="margin-bottom : 1% !important;">
            <!-- Default dropend button -->
            <div class="btn-group dropend">
                <button type="button" class="btn dropdown-toggle"
                        data-bs-toggle="dropdown" aria-expanded="false" style="color: white">패밀리 사이트</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="https://www.hanafn.com:8002/main/index.do">하나금융그룹</a></li>
                    <li><a class="dropdown-item" href="https://www.kebhana.com/">하나은행</a></li>
                    <li><a class="dropdown-item" href="https://www.hanacard.co.kr/">하나카드</a></li>
                    <li><a class="dropdown-item" href="https://www.hanaw.com/main/main/index.cmd">하나증권</a></li>
                    <li><a class="dropdown-item" href="https://www.hanacapital.co.kr/index.hnc">하나캐피탈</a></li>
                    <li><a class="dropdown-item" href="https://www.hanalife.co.kr/">하나생명</a></li>
                    <li><a class="dropdown-item" href="https://www.hanati.co.kr/kor/main.jsp">하나금융티아이</a></li>
                </ul>
            </div>

        </div>
    </footer>
</div>
</body>
</html>