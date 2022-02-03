/**
 * A module for game Guess the number I'm thinking of
 */

"use strict";

class Game {
    /**
     * @constructor
     */
    constructor() {
        this.thinking = -1;
    }

    /**
     * Init the game and guess the number
     */
    init() {
        this.thinking = Math.round(Math.random() * 100 + 1);
    }

    /**
     * Check if the guess is correct or not
     *
     * @param (integer) guess The number being guessed
     *
     * @returns (boolean) True if guess mathces thinking, else false
     *
     */
    check(guess) {
        return guess === this.thinking;
    }

    /**
     * Check if the correct number
     *
     * @returns (int) right number
     *
     */
    cheat() {
        return this.thinking;
    }

    /**
     * Check if the correct number
     *
     * @param - number guessed by user
     *
     * @returns (string) "Higher" if guess_num > this.thinking, "Lower" < this.thinking
     *
     */
    compare(guess) {
        if (this.thinking < guess) {
            return "Lower";
        }
        return "Higher";
    }
}

module.exports = Game;
