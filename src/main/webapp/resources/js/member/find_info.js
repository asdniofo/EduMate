document.addEventListener("DOMContentLoaded", () => {
    const tabId = document.getElementById("tab-id");
    const tabPw = document.getElementById("tab-pw");
    const formId = document.getElementById("find-id-form");
    const formPw = document.getElementById("find-pw-form");

    tabId.addEventListener("click", () => {
        tabId.classList.add("active");
        tabPw.classList.remove("active");
        formId.classList.add("active");
        formPw.classList.remove("active");
    });

    tabPw.addEventListener("click", () => {
        tabPw.classList.add("active");
        tabId.classList.remove("active");
        formPw.classList.add("active");
        formId.classList.remove("active");
    });
});
