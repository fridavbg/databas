(function () {
    "use strict";

    const throwDice = document.getElementById("throw");
    const reset = document.getElementById("reset");
    const dice = document.getElementsByClassName("dice")[0];
    const sum = document.getElementById("sum");
    const gameoverMessage = document.getElementById("gameover");
    let gameover;

    throwDice.addEventListener("click", newRoll);
    reset.addEventListener("click", resetGame);
    window.addEventListener("unload", saveProgress);

    loadProgress();

    function newRoll () {
        if (gameover === false) {
            const newThrough = Math.floor((Math.random() * 6) + 1);
            sum.innerHTML = parseInt(sum.innerHTML) + newThrough;
            dice.classList = "dice roll-" + newThrough;
            if (newThrough === 1) {
                gameover = true;
                gameoverMessage.innerHTML = "*** GAME OVER ***";
            }
        }
    }

    function resetGame () {
        sum.innerHTML = 0;
        dice.classList = "dice";
        gameover = false;
        gameoverMessage.innerHTML = "";
        localStorage.clear();
    }

    function loadProgress () {
        sum.innerHTML = localStorage.sum || 0;
        dice.classList = localStorage.roll || "dice";
        gameover = localStorage.gameover === "true"; // får skriva såhär eftersom localStorage
        // inte kan spara bool-värden!
        console.log(gameover);
        gameoverMessage.innerHTML = localStorage.gameoverMessage || "";
    }

    function saveProgress () {
        localStorage.setItem("sum", parseInt(sum.innerHTML));
        localStorage.setItem("roll", dice.classList);
        localStorage.setItem("gameover", gameover); // obs, sparas som string och inte som bool!
        localStorage.setItem("gameoverMessage", gameoverMessage.innerHTML);
        // localStorage.value = parseInt(sum.innerHTML) // ett annat sätt att skriva ovanstående!
    }
}());
