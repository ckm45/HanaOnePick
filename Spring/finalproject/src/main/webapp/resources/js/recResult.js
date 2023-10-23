/*
const paymentAmountInput = document.getElementById("paymentAmountInput");

paymentAmountInput.addEventListener("input", function () {
    const paymentAmount = parseInt(paymentAmountInput.value);
    console.log('금액 입력: ' + paymentAmount);

    // Get all elements with the class "card-body"
    const benefits = document.querySelectorAll(".card-body");

    benefits.forEach(function (benefit) {
        const benefitCode = benefit.getAttribute("data-benefitCode");
        const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
        console.log("혜택 최대 금액: " + benefitMax);
        console.log('혜택 종류: ' + benefitCode);
        const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));

        // Find the ".expected-benefit" element inside the current "benefit" element
        const expectedBenefit = benefit.querySelector(".expected-benefit");

        if (benefitCode == null) {
            if (expectedBenefit) { // null이 아닌 경우에만 설정
                expectedBenefit.textContent = ""; // 혜택이 없을 때
            }
        } else {
            if (benefitCode.substring(2, 3) === "P") { // 혜택 비율이 있을 때
                const expectedAmount = (paymentAmount * benefitAmount) / 100;
                console.log("예상 혜택 금액: " + expectedAmount);
                if (benefitCode.substring(0, 2) === "AC") {
                    if (benefitMax > expectedAmount) {
                        if (expectedBenefit) { // null이 아닌 경우에만 설정
                            expectedBenefit.textContent = "예상 혜택 금액 : " + expectedAmount + "원 적립";
                        }
                    } else {
                        if (expectedBenefit) { // null이 아닌 경우에만 설정
                            expectedBenefit.textContent = "예상 혜택 금액 : " + benefitMax + "원 적립";
                        }
                    }
                } else if (benefitCode.substring(0, 2) === "DC") {
                    if (expectedAmount > benefitMax) {
                        if (expectedBenefit) { // null이 아닌 경우에만 설정
                            expectedBenefit.textContent = "예상 혜택 금액 : " + benefitMax + "원 할인";
                        }
                    } else {
                        if (expectedBenefit) { // null이 아닌 경우에만 설정
                            expectedBenefit.textContent = "예상 혜택 금액 : " + expectedAmount + "원 할인";
                        }
                    }
                }
            } else if (benefitCode.substring(2, 3) === "V") {
                const totalBenefitAmount = Math.min(benefitAmount, paymentAmount);
                if (expectedBenefit) { // null이 아닌 경우에만 설정
                    expectedBenefit.textContent = "예상 혜택 금액 : " + totalBenefitAmount + "원";
                }
            } else {
                if (expectedBenefit) { // null이 아닌 경우에만 설정
                    expectedBenefit.textContent = ""; // 혜택이 없을 때
                }
            }
        }
    });
});
*/
/*
paymentAmountInput.addEventListener("input", function () {
    const paymentAmount = parseInt(paymentAmountInput.value);

    const benefits = document.querySelectorAll(".card-body");
    const benefitsData = [];

    benefits.forEach(function (benefit) {
        const benefitCode = benefit.getAttribute("data-benefitCode");
        const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
        const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
        const expectedBenefit = benefit.querySelector(".expected-benefit");
        let expectedAmount = 0;

        if (benefitCode) {
            if (benefitCode.substring(2, 3) === "P") {
                expectedAmount = (paymentAmount * benefitAmount) / 100;
                if (benefitCode.substring(0, 2) === "AC") {
                    expectedAmount = Math.min(benefitMax, expectedAmount);
                } else if (benefitCode.substring(0, 2) === "DC") {
                    expectedAmount = Math.min(benefitMax, expectedAmount);
                }
            } else if (benefitCode.substring(2, 3) === "V") {
                expectedAmount = Math.min(benefitAmount, paymentAmount);
            }
        }

        benefitsData.push({
            element: benefit,
            expectedAmount: expectedAmount
        });
    });

    benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);

    benefitsData.forEach((data, index) => {
        const benefit = data.element;
        const expectedBenefit = benefit.querySelector(".expected-benefit");
        const benefitCode = benefit.getAttribute("data-benefitCode");

        const rankIcon = benefit.querySelector(".rank-icon");
        if (rankIcon) {
            rankIcon.src = `../../resources/img/rank${index + 1}.png`;
        }
        if (benefitCode) {
            if (benefitCode.substring(2, 3) === "P") {
                if (benefitCode.substring(0, 2) === "AC") {
                    if (expectedBenefit) {
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
                    }
                } else if (benefitCode.substring(0, 2) === "DC") {
                    if (expectedBenefit) { // null 체크 추가
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
                    }
                }
            } else if (benefitCode.substring(2, 3) === "V") {
                if (expectedBenefit) { // null 체크 추가
                    expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
                }
            }
        } else {
            if (expectedBenefit) {
                expectedBenefit.textContent = "";
            }
        }

        // Place the sorted benefit cards in the panel
        const panel = benefit.closest(".panel");
        if (panel) {
            panel.insertBefore(benefit.closest(".card.mb-3"), panel.children[index]);
        }
    });
});
*/
/*
paymentAmountInput.addEventListener("input", function () {
    const paymentAmount = parseInt(paymentAmountInput.value);

    const accordionSections = document.querySelectorAll(".accordion-section");

    accordionSections.forEach(accordionSection => {
        const benefits = accordionSection.querySelectorAll(".card-body");
        const benefitsData = [];

        benefits.forEach(function (benefit) {
            const benefitCode = benefit.getAttribute("data-benefitCode");
            const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
            const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            let expectedAmount = 0;

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    expectedAmount = (paymentAmount * benefitAmount) / 100;
                    if (benefitCode.substring(0, 2) === "AC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    expectedAmount = Math.min(benefitAmount, paymentAmount);
                }
            }

            benefitsData.push({
                element: benefit,
                expectedAmount: expectedAmount
            });
        });

        benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);

        benefitsData.forEach((data, index) => {
            const benefit = data.element;
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            const benefitCode = benefit.getAttribute("data-benefitCode");

            const rankIcon = benefit.querySelector(".rank-icon");
            if (rankIcon) {
                rankIcon.src = `../../resources/img/rank${index + 1}.png`;
            }
            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    if (benefitCode.substring(0, 2) === "AC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
                        }
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
                        }
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    if (expectedBenefit) {
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
                    }
                }
            } else {
                if (expectedBenefit) {
                    expectedBenefit.textContent = "";
                }
            }

            // Place the sorted benefit cards in the panel
            const panel = benefit.closest(".panel");
            if (panel) {
                panel.insertBefore(benefit.closest(".card.mb-3"), panel.children[index]);
            }
        });
    });
});
*/


/**세번쨰*/
/*
paymentAmountInput.addEventListener("input", function () {
    const paymentAmount = parseInt(paymentAmountInput.value);

    const panels = document.querySelectorAll(".panel");

    panels.forEach(panel => {
        const benefits = panel.querySelectorAll(".card-body");
        const benefitsData = [];

        benefits.forEach(function (benefit) {
            const benefitCode = benefit.getAttribute("data-benefitCode");
            const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
            const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            let expectedAmount = 0;

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    expectedAmount = (paymentAmount * benefitAmount) / 100;
                    if (benefitCode.substring(0, 2) === "AC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    expectedAmount = Math.min(benefitAmount, paymentAmount);
                }
            }

            benefitsData.push({
                element: benefit,
                expectedAmount: expectedAmount,
                originalParent: benefit.parentElement,
            });
        });

        benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);

        benefitsData.forEach((data, index) => {
            const benefit = data.element;
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            const benefitCode = benefit.getAttribute("data-benefitCode");

            // 순위 이미지를 설정합니다.
            const rankIcon = benefit.querySelector(".rank-icon");
            if (rankIcon) {
                rankIcon.src = `../../resources/img/rank${index + 1}.png`;
            }
            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    if (benefitCode.substring(0, 2) === "AC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
                        }
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
                        }
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    if (expectedBenefit) {
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
                    }
                }
            } else {
                if (expectedBenefit) {
                    expectedBenefit.textContent = "";
                }
            }

            data.originalParent.appendChild(benefit);
        });
    });
});
*/

/*paymentAmountInput.addEventListener("input", function () {
    const paymentAmount = parseInt(paymentAmountInput.value);

    const panels = document.querySelectorAll(".panel");

    panels.forEach(panel => {
        const cards = panel.querySelectorAll(".card");
        const benefitsData = [];

        cards.forEach(function (card) {
            const benefit = card.querySelector(".card-body");
            const benefitCode = benefit.getAttribute("data-benefitCode");
            const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
            const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            let expectedAmount = 0;

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    expectedAmount = (paymentAmount * benefitAmount) / 100;
                    if (benefitCode.substring(0, 2) === "AC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    expectedAmount = Math.min(benefitAmount, paymentAmount);
                }
            }

            benefitsData.push({
                element: card,
                expectedAmount: expectedAmount,
            });
        });

        benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);

        benefitsData.forEach((data, index) => {
            const card = data.element;
            const benefit = card.querySelector(".card-body");
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            const benefitCode = benefit.getAttribute("data-benefitCode");

            const rankIcon = benefit.querySelector(".rank-icon");
            if (rankIcon) {
                rankIcon.src = `../../resources/img/rank${index + 1}.png`;
            }

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    if (benefitCode.substring(0, 2) === "AC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
                        }
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        if (expectedBenefit) {
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
                        }
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    if (expectedBenefit) {
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
                    }
                }
            } else {
                if (expectedBenefit) {
                    expectedBenefit.textContent = "";
                }
            }

            panel.appendChild(card);
        });
    });
});*/


/*0927작업*/

// paymentAmountInput.addEventListener("input", function () {
//
//         const paymentAmount = parseInt(paymentAmountInput.value);
//         const panels = document.querySelectorAll(".panel");
//
//         panels.forEach(panel => {
//             const cards = panel.querySelectorAll(".card");
//             const benefitsData = [];
//
//             cards.forEach(function (card) {
//                 const benefit = card.querySelector(".card-body");
//                 const benefitCode = benefit.getAttribute("data-benefitCode");
//                 const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
//                 const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
//                 const expectedBenefit = benefit.querySelector(".expected-benefit");
//                 let expectedAmount = 0;
//
//                 if (benefitCode) {
//                     if (benefitCode.substring(2, 3) === "P") {
//                         expectedAmount = (paymentAmount * benefitAmount) / 100;
//                         if (benefitCode.substring(0, 2) === "AC") {
//                             expectedAmount = Math.min(benefitMax, expectedAmount);
//                         } else if (benefitCode.substring(0, 2) === "DC") {
//                             expectedAmount = Math.min(benefitMax, expectedAmount);
//                         }
//                     } else if (benefitCode.substring(2, 3) === "V") {
//                         expectedAmount = Math.min(benefitAmount, paymentAmount);
//                     }
//                 }
//
//                 benefitsData.push({
//                     element: card,
//                     expectedAmount: expectedAmount,
//                 });
//             });
//
//             benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);
//
//             benefitsData.forEach((data, index) => {
//                 const card = data.element;
//                 const benefit = card.querySelector(".card-body");
//                 const expectedBenefit = benefit.querySelector(".expected-benefit");
//                 const benefitCode = benefit.getAttribute("data-benefitCode");
//
//                 const rankIcon = benefit.querySelector(".rank-icon");
//                 if (rankIcon) {
//                     rankIcon.src = `../../resources/img/rank${index + 1}.png`;
//                 }
//
//                 if (benefitCode) {
//                     if (benefitCode.substring(2, 3) === "P") {
//                         if (benefitCode.substring(0, 2) === "AC") {
//                             if (expectedBenefit) {
//                                 expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
//                             }
//                         } else if (benefitCode.substring(0, 2) === "DC") {
//                             if (expectedBenefit) {
//                                 expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
//                             }
//                         }
//                     } else if (benefitCode.substring(2, 3) === "V") {
//                         if (expectedBenefit) {
//                             expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
//                         }
//                     }
//                 } else {
//                     if (expectedBenefit) {
//                         expectedBenefit.textContent = "";
//                     }
//                 }
//
//                 panel.appendChild(card);
//             });
//         });
//
// });


function applyBenefits() {
    const inputValue = document.getElementById("paymentAmountInput").value;
    const paymentAmount = parseInt(inputValue.replace(/,/g, ''), 10);

    const panels = document.querySelectorAll(".panel");

    panels.forEach(panel => {
        const cards = panel.querySelectorAll(".card");
        const benefitsData = [];

        cards.forEach(function (card) {
            const benefit = card.querySelector(".card-body");
            const benefitCode = benefit.getAttribute("data-benefitCode");
            const benefitMax = parseInt(benefit.getAttribute("data-benefitMax"));
            const benefitAmount = parseFloat(benefit.getAttribute("data-benefitAmount"));
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            let expectedAmount = 0;

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    expectedAmount = (paymentAmount * benefitAmount) / 100;
                    if (benefitCode.substring(0, 2) === "AC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        expectedAmount = Math.min(benefitMax, expectedAmount);
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    expectedAmount = Math.min(benefitAmount, paymentAmount);
                }
            }

            benefitsData.push({
                element: card,
                expectedAmount: expectedAmount,
            });
        });

        benefitsData.sort((a, b) => b.expectedAmount - a.expectedAmount);

        benefitsData.forEach((data, index) => {
            const card = data.element;
            const benefit = card.querySelector(".card-body");
            const expectedBenefit = benefit.querySelector(".expected-benefit");
            const benefitCode = benefit.getAttribute("data-benefitCode");

            const rankIcon = benefit.querySelector(".rank-icon");
            if (rankIcon) {
                rankIcon.src = `../../resources/img/rank${index + 1}.png`;
            }

            if (benefitCode) {
                if (benefitCode.substring(2, 3) === "P") {
                    if (benefitCode.substring(0, 2) === "AC") {
                        if (expectedBenefit) {
                            console.log(data.expectedAmount, 1)
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 적립";
                        }
                    } else if (benefitCode.substring(0, 2) === "DC") {
                        if (expectedBenefit) {
                            console.log(data.expectedAmount, 2)
                            data.expectedAmount = data.expectedAmount.toLocaleString('en-US');
                            console.log(data.expectedAmount);  // 출력: "4,425"
                            expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원 할인";
                        }
                    }
                } else if (benefitCode.substring(2, 3) === "V") {
                    if (expectedBenefit) {
                        console.log(data.expectedAmount, 3)
                        expectedBenefit.textContent = "예상 혜택 금액 : " + data.expectedAmount + "원";
                    }
                }
            } else {
                if (expectedBenefit) {
                    expectedBenefit.textContent = "";
                }
            }

            panel.appendChild(card);
        });
    });

}
const paymentAmountInput = document.getElementById("paymentAmountInput");
paymentAmountInput.addEventListener("input", applyBenefits);

const applyButton = document.getElementById("yourButtonId");
applyButton.addEventListener("click", applyBenefits);