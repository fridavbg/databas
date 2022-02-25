(function () {
    "use strict";

    const player = document.createElement("img");
    player.src = "img/player.gif";
    player.alt = "logo";
    player.className = "player";

    function move (obj, valueX, valueY) {
        const currentLeft = getComputedStyle(obj).getPropertyValue("left");
        const currentTop = getComputedStyle(obj).getPropertyValue("top");
        obj.style.left = parseInt(currentLeft) + valueX + "px";
        obj.style.top = parseInt(currentTop) - valueY + "px";
    }

    document.getElementsByTagName("body")[0].appendChild(player);

    const moveSpeed = 20;
    document.addEventListener("keydown", function (event) {
        switch (event.key) {
        case 'w':
        case 'ArrowUp':
            move(player, 0, moveSpeed);
            break;

        case 'a':
        case 'ArrowLeft':
            move(player, -moveSpeed, 0);
            break;

        case 'd':
        case 'ArrowRight':
            move(player, moveSpeed, 0);
            break;

        case 's':
        case 'ArrowDown':
            move(player, 0, -moveSpeed);
            break;

        default:
            console.log("A nonsense key was pressed!");
            break;
        }
    });
}());

// function movePlayer() {

//     const player = document.createElement("img");
//     player.src = "img/player.gif";
//     player.alt = "logo";
//     player.className = "player";

//     function move(obj, valueX, valueY) {
//         const currentLeft = getComputedStyle(obj).getPropertyValue("left");
//         const currentTop = getComputedStyle(obj).getPropertyValue("top");
//         obj.style.left = parseInt(currentLeft) + valueX + "px";
//         obj.style.top = parseInt(currentTop) - valueY + "px";
//     }

//     document.getElementsByTagName("body")[0].appendChild(player);

//     const moveSpeed = 20;
//     document.addEventListener("keydown", function (event) {
//         switch (event.key) {
//             case 'w':
//             case 'ArrowUp':
//                 move(player, 0, moveSpeed);
//                 break;

//             case 'a':
//             case 'ArrowLeft':
//                 move(player, -moveSpeed, 0);
//                 break;

//             case 'd':
//             case 'ArrowRight':
//                 move(player, moveSpeed, 0);
//                 break;

//             case 's':
//             case 'ArrowDown':
//                 move(player, 0, -moveSpeed);
//                 break;

//             default:
//                 console.log("A nonsense key was pressed!");
//                 break;
//         }
//     });
// }

// export { movePlayer }
