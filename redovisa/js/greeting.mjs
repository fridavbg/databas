(function () {
    "use strict";

    const today = new Date();
    const date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    const time = today.getHours();
    const greeting = time < 12 ? "*** GOD FÖRMIDDAG ***" : "***GOD EFTERMIDDAG***";

    document.getElementById("greeting").innerHTML = greeting;
    document.getElementById("date").innerHTML = date;
}());

// function greeting() {
//     const today = new Date();
//     const date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
//     const time = today.getHours();
//     const greeting = time < 12 ? "*** GOD FÖRMIDDAG ***" : "***GOD EFTERMIDDAG***";

//     document.getElementById("greeting").innerHTML = greeting;
//     document.getElementById("date").innerHTML = date;
//     console.log("asdbfjhbsdf");
// }

// export { greeting }
