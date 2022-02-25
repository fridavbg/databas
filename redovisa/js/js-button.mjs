(function () {
    "use strict";

    const button = document.getElementById("button");
    const logoSpawnPos = document.getElementById("spawn-pos");
    let count = 1;

    button.addEventListener("click", pressedButton);
    button.addEventListener("mouseenter", function (event) {
        event.target.style.filter = "brightness(100%)";
    });
    button.addEventListener("mouseleave", function (event) {
        event.target.style.filter = "brightness(80%)";
    });

    function pressedButton () {
        for (let i = 0; i < count; i++) {
            const logo = document.createElement("img");
            logo.className = "logos";
            logo.src = "img/logo.png";
            logo.alt = "logo";
            // logoSpawnPos.appendChild(logo);
            logoSpawnPos.insertBefore(logo, logoSpawnPos.firstChild);

            logo.addEventListener("mouseenter", function (event) {
                event.target.style.width = "50px";
                event.target.style.height = "50px";
                event.target.style.filter = "brightness(100%)";
            });
            logo.addEventListener("click", function (event) {
                event.target.style.width = "100px";
                event.target.style.height = "100px";
            });
            logo.addEventListener("dblclick", function (event) {
                event.target.style.transform = "rotate(180deg)";
            });
        }
        count++;
    }
}());

// function jsButton() {

//     const button = document.getElementById("button");
//     const logoSpawnPos = document.getElementById("spawn-pos");
//     let count = 1;

//     button.addEventListener("click", pressedButton);
//     button.addEventListener("mouseenter", function (event) {
//         event.target.style.filter = "brightness(100%)";
//     });
//     button.addEventListener("mouseleave", function (event) {
//         event.target.style.filter = "brightness(80%)";
//     });

//     function pressedButton() {
//         for (let i = 0; i < count; i++) {
//             const logo = document.createElement("img");
//             logo.className = "logos";
//             logo.src = "img/logo.png";
//             logo.alt = "logo";
//             // logoSpawnPos.appendChild(logo);
//             logoSpawnPos.insertBefore(logo, logoSpawnPos.firstChild);

//             logo.addEventListener("mouseenter", function (event) {
//                 event.target.style.width = "50px";
//                 event.target.style.height = "50px";
//                 event.target.style.filter = "brightness(100%)";
//             });
//             logo.addEventListener("click", function (event) {
//                 event.target.style.width = "100px";
//                 event.target.style.height = "100px";
//             });
//             logo.addEventListener("dblclick", function (event) {
//                 event.target.style.transform = "rotate(180deg)";
//             });
//         }
//         count++;
//     }
// }

// export { jsButton }
