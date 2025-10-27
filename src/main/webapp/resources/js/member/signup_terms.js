document.addEventListener("DOMContentLoaded", function() {
    const requiredTerms = document.querySelectorAll(".required-term");
    const allCheckbox = document.getElementById("agreeAll");
    const allCheckboxes = document.querySelectorAll(".terms-list input[type='checkbox']");
    const errorMsg = document.getElementById("error-message");
    const termsLinks = document.querySelectorAll(".terms-link");
    const nextBtn = document.getElementById("next-btn");

    // 전체 동의 클릭 시 모든 체크박스 상태 변경
    allCheckbox.addEventListener("change", function() {
    allCheckboxes.forEach(chk => chk.checked = allCheckbox.checked);
    
    // ★ 버튼 상태 업데이트
    updateButtonState();
});

// 개별 체크박스 변경 시 전체동의 상태 및 버튼 상태 업데이트
allCheckboxes.forEach(chk => {
    chk.addEventListener("change", () => {
        const allChecked = Array.from(allCheckboxes).every(c => c.checked);
        allCheckbox.checked = allChecked;

        // ★ 버튼 상태 업데이트
        updateButtonState();
    });
});
    // 제출 시 필수항목 체크 확인
    document.getElementById("terms-form").addEventListener("submit", function(e) {
        const unchecked = Array.from(requiredTerms).filter(c => !c.checked);

        if (unchecked.length > 0) {
            e.preventDefault();
            errorMsg.style.display = "block";
            unchecked.forEach(c => c.classList.add("input-error"));
        } else {
            errorMsg.style.display = "none";
            requiredTerms.forEach(c => c.classList.remove("input-error"));
        }
    });

    // 약관 팝업 관련
    const modal = document.getElementById("terms-modal");
    const modalTitle = document.getElementById("modal-title");
    const modalText = document.getElementById("modal-text");
    const modalClose = document.getElementById("modal-close");

    const termsContent = {
        1: {
            title: "개인정보 이용약관",
            text: "이 약관은 개인정보 수집 및 이용에 관한 내용을 포함하고 있습니다..."
        },
        2: {
            title: "서비스 이용약관",
            text: "서비스 이용약관은 이용자와 회사 간의 서비스 제공 및 이용 조건을 규정합니다..."
        },
        3: {
            title: "위치기반 서비스 이용약관",
            text: "위치정보의 수집, 이용 및 보호에 관한 내용이 포함되어 있습니다..."
        },
        4: {
            title: "(선택) 마케팅 정보 수신",
            text: "이 약관은 이벤트 및 프로모션 정보 수신에 관한 선택 동의 사항입니다..."
        },
        5: {
            title: "(선택) 맞춤형 광고 수신",
            text: "이 약관은 개인 맞춤형 광고 제공을 위한 선택 동의 내용입니다..."
        }
    };

    termsLinks.forEach(link => {
        link.addEventListener("click", (e) => {
            e.preventDefault();
            const termsId = link.dataset.terms;
            const content = termsContent[termsId];
            modalTitle.textContent = content.title;
            modalText.textContent = content.text;
            modal.style.display = "flex";
        });
    });

    modalClose.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
        // 버튼 상태 업데이트 함수
    function updateButtonState() {
    // 필수 체크박스만 확인
    const allRequiredChecked = Array.from(requiredTerms).every(chk => chk.checked);

    if (allRequiredChecked) {
        nextBtn.classList.add("active"); // 활성화 색상
    } else {
        nextBtn.classList.remove("active"); // 비활성화 색상
    }
}
    // 체크박스 상태 변경 시마다 버튼 색상 갱신
    requiredTerms.forEach(chk => {
    chk.addEventListener("change", updateButtonState);
    }); 

    // 다음 버튼 클릭 이벤트
    nextBtn.addEventListener("click", function(e) {
        const unchecked = Array.from(requiredTerms).filter(c => !c.checked);

        if (unchecked.length > 0) {
            e.preventDefault();
            errorMsg.style.display = "block";
            unchecked.forEach(c => c.classList.add("input-error"));
        } else {
            errorMsg.style.display = "none";
            requiredTerms.forEach(c => c.classList.remove("input-error"));
            // document.getElementById('terms-form').submit(); ← 실제 제출 시 사용
        }
    });

    // 초기 버튼 상태 설정
    updateButtonState();
});