(function () {
    "use strict";

    const button = document.getElementById("button");
    let sizeChange = 2;

    button.addEventListener("click", pressedButton);
    button.addEventListener("mouseenter", function (event) {
        event.target.style.filter = "brightness(100%)";
    });
    button.addEventListener("mouseleave", function (event) {
        event.target.style.filter = "brightness(80%)";
    });

    function pressedButton() {
        button.style.height = button.offsetHeight + sizeChange + "px";
        button.style.width = button.offsetWidth + sizeChange * 2 + "px";
        const currentLeft = getComputedStyle(button).getPropertyValue("left");

        const currentTop = getComputedStyle(button).getPropertyValue("top");

        button.style.left = parseInt(currentLeft) - sizeChange * 2 / 2 + "px";
        button.style.top = parseInt(currentTop) - sizeChange / 2 + "px";
        sizeChange *= 1.5;
    }
}());
