(function () {
    "use strict";

    class Figure {
        constructor (size, color, pos, rot) {
            this.size = size;
            this.color = color;
            this.pos = pos;
            this.rot = rot;

            this.draw = function () {
                const fig = document.createElement("img");
                fig.style.position = "absolute";
                fig.style.margin = "5px";

                fig.src = "img/player.gif";
                fig.alt = "logo";
                fig.className = "player";

                fig.style.top = this.pos.t + "%";
                fig.style.left = this.pos.l + "%";
                fig.style.width = this.size + "px";
                fig.style.background = this.color;
                fig.style.transform = "rotate(" + this.rot + "deg)";

                document.getElementsByTagName("body")[0].appendChild(fig);
            };
        }
    }

    const fig1 = new Figure(60, "green", { t: 10, l: 88 }, 20);
    const fig2 = new Figure(76, "red", { t: 15, l: 80 }, 50);
    const fig3 = new Figure(118, "cornflowerBlue", { t: 30, l: 87 }, -100);

    const figArray = [fig1, fig2, fig3];

    appendFig(figArray);

    function appendFig (figArray) {
        for (const i of figArray) {
            i.draw();
        }
    }
}());
