<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- 부트스트랩 JavaScript 파일 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<header>
    <div class="nav-bar navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="logo">
                <a href="${pageContext.request.contextPath}/" class="logo-link">
                    <img src="../../resources/img/img-hana-symbol.png" alt="logo" class="nav-logo img-fluid">
                    하나OnePick
                </a>
            </div>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                <ul class="navbar-nav me-auto nav justify-content-end">
                    <%--<li class="nav-item">
                        <a class="nav-link active"
                                            aria-current="page" href="${pageContext.request.contextPath}/member/card">내
                        카드</a></li>--%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            마이페이지
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/card" onclick="return checkLogin();">내 카드 관리</a></li>

                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/getPayList" onclick="return checkLogin();">카드 이용내역</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/getPayReport" onclick="return checkLogin();">내게 맞는 카드</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/search" onclick="return checkLogin();">혜택 찾기</a>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/map" onclick="return checkLogin();">혜택 지도</a>
                    </li>
                    <c:if test="${sessionScope.dto ne null}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.dto eq null}">
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                                                style="width:auto; cursor: pointer;">로그인</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
    <c:if test="${sessionScope.dto ne null}">
        <div class="welcome-msg fs-4">${sessionScope.dto.name}님 환영합니다!</div>
    </c:if>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">로그인</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}member/login" method="post">
                        <img class="mb-4" src="../../resources/img/img-hana-symbol.png" alt="" width="72" height="57">
                        <h1 class="h3 mb-3 fw-normal">하나OnePick</h1>

                        <div class="form-floating">
                            <input type="text" class="form-control mb-3" id="id" name="id" placeholder="아이디를 입력해주세요.">
                            <label for="id">아이디</label>
                        </div>
                        <div class="form-floating">
                            <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력해주세요.">
                            <label for="pw">비밀번호</label>
                        </div>

                        <div class="form-check text-start my-3">

                        </div>
                        <button class="btn btn-dark w-100 py-2 fs-5 mb-4" type="submit" style="cursor:pointer !important;">로그인</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-dark">회원가입</button>
                </div>
            </div>
        </div>
    </div>
<script>
    function checkLogin() {
        if (!<c:out value="${sessionScope.dto ne null}"/>) {
            alert("로그인이 필요합니다.");
            return false;
        }
        return true;
    }
</script>
</header>



</body>
</html>