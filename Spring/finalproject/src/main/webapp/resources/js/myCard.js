function sendAuthNumber() {
    var authNumber = $('input[aria-label="auth-number"]').val();
    console.log(authNumber);

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/auth", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    var data = JSON.stringify({authNumber: authNumber});

    xhr.send(data);

    xhr.onload = function () {
        if (xhr.status === 200 && xhr.responseText === 'Success') {
            $('#myModal').modal('hide');

            var cardItem = $('.carousel-inner').find('.active');

            var cardNumberField = cardItem.find('.card-number-field');
            var hiddenCardNumber = cardItem.find('.hidden-card-number');
            var cardValidationField = cardItem.find('.card-validation-field');
            var hiddenCardValidation = cardItem.find('.hidden-card-validation');

            if (cardNumberField.is(':visible')) {

                cardNumberField.hide();
                hiddenCardNumber.show();
                cardValidationField.hide();
                hiddenCardValidation.show();
            } else {

                cardNumberField.show();
                hiddenCardNumber.hide();
                cardValidationField.show();
                hiddenCardValidation.hide();
            }

            alert("인증이 성공적으로 완료되었습니다.");
        } else {
            alert("인증에 실패했습니다. 다시 시도해주세요.");
        }
    };
}

function generateRandomSixDigitNumber() {

    const randomNumber = Math.floor(100000 + Math.random() * 900000);

    const sixDigitNumber = randomNumber.toString().padStart(6, '0');

    return sixDigitNumber;
}

function sendSmsRequest() {

    var selectedPrefix = document.getElementById("phone-prefix").value;

    var enteredNumber = document.getElementById("phone-input").value;

    var recipientPhoneNumber = selectedPrefix + enteredNumber;

    const randomSixDigitNumber = generateRandomSixDigitNumber();

    console.log(recipientPhoneNumber)
    const requestData = {
        recipientPhoneNumber: recipientPhoneNumber,
        content: `[sms테스트] 인증번호 :` + randomSixDigitNumber,
        randomNumber: randomSixDigitNumber
    };

    fetch('/user/sms', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestData)
    })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error sending SMS request:', error);
            alert('인증번호 전송 중 오류가 발생했습니다.');
        });
}


$(document).ready(function () {
    // 내 카드의 혜택보기
    $('.show-benefit-btn').click(function () {
        var cardNumber = $(this).closest('.card-body').find('input[name="cardNumber"]').val();
        console.log("cardNumber: " + cardNumber);
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/getBenefitList",
            data: {cardNumber: cardNumber},
            success: function (response) {
                console.log("혜택 조회 결과: " + response);

                var modalBody = $('#benefitModal').find('.modal-body');
                modalBody.empty();

                var groupedBenefits = groupByCardPerformance(response);

                // 모달에 혜택 정보 추가
                var modalBody = $('#benefitModal').find('.modal-body');
                modalBody.empty();

                for (var performance in groupedBenefits) {
                    var groupBenefits = groupedBenefits[performance];
                    performance = performance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    var groupHtml = '<h5>카드 실적: ' + performance + '원</h5>';



                    var tableHtml = '<table class="table table-bordered">' +
                        '<thead>' +
                        '<tr>' +
                        '<th>업종</th>' +
                        '<th>가맹점 이름</th>' +
                        '<th>혜택 금액</th>' +
                        '<th>혜택 최대값</th>' +
                        '<th>혜택 설명</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody>';

                    for (var industryCode in groupBenefits) {
                        var industryBenefits = groupBenefits[industryCode];
                        var storeNames = industryBenefits.map(function (benefit) {
                            return benefit.benefitStoreName;
                        }).join(', ');

                        var benefitAmount = industryBenefits[0].benefitAmount; // 혜택 금액 (모두 같다고 가정)
                        benefitAmount = benefitAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        var benefitMax = industryBenefits[0].benefitMax; // 혜택 최대값 (모두 같다고 가정)
                        var industryName = '';
                        if (industryCode === 'CE') {
                            industryName = '카페';
                        } else if (industryCode === 'CS') {
                            industryName = '편의점';
                        } else if (industryCode === 'PT') {
                            industryName = '대중교통';
                        } else if (industryCode === 'MT') {
                            industryName = '대형마트';
                        } else if (industryCode === 'SH') {
                            industryName = '쇼핑';
                        } else if (industryCode === 'OL') {
                            industryName = '주유';
                        } else if (industryCode === 'FD') {
                            industryName = '요식';
                        } else if (industryCode === 'CT') {
                            industryName = '문화시설';
                        } else if (industryCode === 'ED') {
                            industryName = '교육';
                        } else if (industryCode === 'MD') {
                            industryName = '의료';
                        } else if (industryCode === 'AP') {
                            industryName = '항공';
                        } else if (industryCode === 'TR') {
                            industryName = '여행';
                        } else if (industryCode === 'AL') {
                            industryName = '국내가맹점';
                        }

                        let benefitContent = '일치하지 않는 경우';

                        console.log(industryBenefits[0].benefitCode);
                        if (industryBenefits[0].benefitCode === 'DCVC ') {
                            benefitContent = benefitAmount + '원 할인 월 최대 ' + benefitMax + '회';
                        } else if (industryBenefits[0].benefitCode === 'DCPC ') {
                            benefitContent = benefitAmount + '% 할인 월 최대 ' + benefitMax + '회';
                        } else if (industryBenefits[0].benefitCode === 'DCVA ') {
                            benefitContent = benefitAmount + '원 할인 월 최대 ' + benefitMax + '원';
                        } else if (industryBenefits[0].benefitCode === 'DCPA ') {
                            benefitContent = benefitAmount + '% 할인 월 최대 ' + benefitMax + '원';
                        } else if (industryBenefits[0].benefitCode === 'ACPC ') {
                            benefitContent = benefitAmount + '% 적립 월 최대 ' + benefitMax + '회';
                        } else if (industryBenefits[0].benefitCode === 'ACVC ') {
                            benefitContent = benefitAmount + '원 적립 월 최대 ' + benefitMax + '회';
                        } else if (industryBenefits[0].benefitCode === 'ACPA ') {
                            benefitContent = benefitAmount + '% 적립 월 최대 ' + benefitMax + '원';
                        } else if (industryBenefits[0].benefitCode === 'ACVA ') {
                            benefitContent = benefitAmount + '원 적립 월 최대 ' + benefitMax + '원';
                        }


                        // 행 추가
                        tableHtml += '<tr>' +
                            '<td>' + industryName + '</td>' +
                            '<td>' + storeNames + '</td>' +
                            '<td>' + benefitAmount + '</td>' +
                            '<td>' + benefitMax + '</td>' +
                            '<td>' + benefitContent + '</td>' +
                            '</tr>';
                    }

                    // 표 닫기
                    tableHtml += '</tbody></table>';
                    groupHtml += tableHtml;
                    modalBody.append(groupHtml);
                }

                // 모달 열기
                $('#benefitModal').modal('show');
            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    function groupByCardPerformance(data) {
        var grouped = {};
        for (var i = 0; i < data.length; i++) {
            var benefit = data[i];
            var performance = benefit.cardPerformance.toString();
            var benefitIndustryCode = benefit.benefitIndustryCode.toString();

            if (!grouped[performance]) {
                grouped[performance] = {};
            }

            if (!grouped[performance][benefitIndustryCode]) {
                grouped[performance][benefitIndustryCode] = [];
            }

            grouped[performance][benefitIndustryCode].push(benefit);
        }
        console.log(grouped);
        return grouped;
    }

    $('.show-card-number-btn').click(function () {

        $('#myModal').modal('show');

    });

    // 카드 아이디를 보내는 Ajax 호출 함수 (카드 실적 가져오기)
    function sendCardId(cardId, lastMonthTotal) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/getPerformanceLevel",
            data: {cardId: parseInt(cardId)},
            success: function (response) {
                console.log("response: " + response);
                // Update the progress bar based on the returned value
                updateProgressBar(response, lastMonthTotal);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    // 테이블을 DataTables로 초기화
    var dataTable = $('#datatablesSimple').DataTable({
        autoWidth: false,
        searching: true,
        language: {
            paginate: {
                previous: "이전",
                next: "다음"
            },
            zeroRecords: "검색 결과가 없습니다.",
            info: "전체 거래내역 _TOTAL_개 중에서 _START_ 번부터 _END_ 번까지의 결과",
            lengthMenu: "_MENU_ 행까지 조회"
        }
        , columnDefs: [
            {
                targets: -1,
                className: 'dt-body-center'
            },

        ]
    });


    function updateTable(response) {
        // 기존 DataTables 데이터 삭제
        dataTable.clear().draw();

        // 거래내역 데이터를 테이블에 추가
        for (var i = 0; i < response.length; i++) {
            var transaction = response[i];
            var transactionIndustryName = '';
            // 조건에 따라 값 변환
            if (transaction['transactionIndustryCode'] === 'CS') {
                transactionIndustryName = '편의점';
            } else if (transaction['transactionIndustryCode'] === 'CE') {
                transactionIndustryName = '카페';
            } else if (transaction['transactionIndustryCode'] === 'PT') {
                transactionIndustryName = '대중교통';
            } else if (transaction['transactionIndustryCode'] === 'MT') {
                transactionIndustryName = '대형마트';
            } else if (transaction['transactionIndustryCode'] === 'SH') {
                transactionIndustryName = '쇼핑';
            } else if (transaction['transactionIndustryCode'] === 'OL') {
                transactionIndustryName = '주유';
            } else if (transaction['transactionIndustryCode'] === 'FD') {
                transactionIndustryName = '요식';
            } else if (transaction['transactionIndustryCode'] === 'CT') {
                transactionIndustryName = '문화시설';
            } else if (transaction['transactionIndustryCode'] === 'ED') {
                transactionIndustryName = '교육';
            } else if (transaction['transactionIndustryCode'] === 'MD') {
                transactionIndustryName = '의료';
            } else if (transaction['transactionIndustryCode'] === 'AP') {
                transactionIndustryName = '항공';
            } else if (transaction['transactionIndustryCode'] === 'TR') {
                transactionIndustryName = '여행';
            } else if (transaction['transactionIndustryCode'] === 'AL') {
                transactionIndustryName = '기타 국내가맹점';
            }

            dataTable.row.add([
                transaction['transactionDate'],
                transaction['cardNumber'],
                transactionIndustryName,
                transaction['transactionStoreName'],
                transaction['transactionAmount']
            ]).draw(false);
        }
    }

    // 카드 번호를 보내는 Ajax 호출 함수 (해당 카드 번호의 거래내역 가져오기)
    function getTransactionList(cardNumber) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/getTransactionList",
            data: {cardNumber: cardNumber},
            success: function (response) {
                console.log("transactionList 결과: " + response);

                updateTable(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function drawVerticalLines(numbers, referenceNumber, lastMonthTotal) {
        var stepBar = $("#step-bar");
        stepBar.empty();

        var referencePosition = (lastMonthTotal / referenceNumber) * 100;

        var moneyBarLeftOffsetInStepBar = stepBar.width() * (referencePosition / 100);
        var stepBarOffsetInContainer = ($("#progressContainer").width() - stepBar.width()) / 2;

        var moneyBarTotalOffset = moneyBarLeftOffsetInStepBar + stepBarOffsetInContainer;

        $('.speech-bubble').css('left', moneyBarTotalOffset - ($('.speech-bubble').width() / 2) + "px");

        for (var j = 0; j < numbers.length; j++) {
            var position = (numbers[j] / referenceNumber) * 100;
            var label = numbers[j];
            stepBar.append('<div class="vertical-line" style="left: ' + position + '%;"><div class="label">' + label + '</div></div>');
        }

        stepBar.append('<div class="special-bar" style="width: ' + referencePosition + '%;"></div>');
        stepBar.append('<div class="vertical-line reference" id="money-bar" style="left: ' + referencePosition + '%;"><div class="label"><div class="lastMonthTotal">' + lastMonthTotal + '</div></div></div>');
    }

    function updateProgressBar(performanceValue, money) {
        var progressBar = $("#progressContainer .progressbar");
        progressBar.empty();
        progressBar.append('<li class="active">0</li>');

        var maxPfv = Math.max(...performanceValue);

        for (var i = 0; i < performanceValue.length; i++) {
            var pfv = performanceValue[i];
            console.log("pfv: " + pfv);
            progressBar.append('<li class="active">' + pfv + '</li>');
        }

        var result = maxPfv - money;
        console.log("실적result: " + result);
        if (result > 0) {
            $('.speech-bubble').text('남은 실적까지 : ' + result + ' 원');
        } else {
            $('.speech-bubble').text('축하합니다! 실적 달성!');
        }


        drawVerticalLines(performanceValue, maxPfv, money);
    }

    function updateOnSlideChange() {
        var activeSlide = $(".carousel-item.active");
        var currentCardIdBtn = activeSlide.find(".send-card-id-btn");

        if (currentCardIdBtn.length > 0) {
            var cardId = currentCardIdBtn.data("card-id");
            var lastMonthTotal = activeSlide.find('input[name="lastMonthMoney"]').val();
            var cardNumber = activeSlide.find('input[name="cardNumber"]').val();
            sendCardId(cardId, lastMonthTotal);
            getTransactionList(cardNumber);
        }
    }

    $("#carouselExample").on('slid.bs.carousel', updateOnSlideChange);

});
