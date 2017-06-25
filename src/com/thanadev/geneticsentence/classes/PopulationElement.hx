package com.thanadev.geneticsentence.classes;

import Math;

class PopulationElement {

    @:isVar var _sentence(get, null):String;

    public function new(sentence:String) {
        _sentence = sentence;
    }

    public function isWantedSentence(wantedSentence:String):Bool {
        var isValid = false;

        if (_sentence == wantedSentence) {
            isValid = true;
        }

        return isValid;
    }

    /**
    * Returns the percentage of correct letters
    **/
    public function getFitnessScore (wantedSentence:String):Float {
        var fitness = 0;

        for (i in 0..._sentence.length) {
            // It's well placed, add another point
            if (wantedSentence.charAt(i) == _sentence.charAt(i)) {
                fitness ++;
            }
        }

        return fitness/_sentence.length;
    }

    public function getMutation():Void {
        var randomness = Math.random();

        if (randomness < Settings.MUTATION_RATE) {
            var indexToMutate = Math.floor(_sentence.length * Math.random());
            var mutation:String = Settings.POSSIBLE_CHARS[Math.floor(Settings.POSSIBLE_CHARS.length * Math.random())];
            var mutatedSentence = "";

            for (i in 0..._sentence.length) {
                if (i == indexToMutate) {
                    mutatedSentence += mutation;
                } else {
                    mutatedSentence += _sentence.charAt(i);
                }
            }

            _sentence = mutatedSentence;
        }
    }

    public function getCrossoverPart(part1:Bool):String {
        var geneticPart = "";

        if (part1) {
            geneticPart = _sentence.substr(0, Math.round(_sentence.length / 2));
        } else {
            geneticPart = _sentence.substr(Math.round(_sentence.length / 2), _sentence.length);
        }

        return geneticPart;
    }

    public function get__sentence():String {
        return _sentence;
    }
}
