package com.thanadev.geneticsentence.classes;

import Math;

class PopulationElement {

    @:isVar var _sentence(get, null):String;

    public function new(sentence:String) {
        _sentence = sentence;
    }

    public function getFitnessScore (wantedSentence:String):Int {
        var fitness = 0;

        for (i in 0..._sentence.length) {
            if (wantedSentence.indexOf(_sentence.charAt(i)) > -1) {
                fitness++;
            }

            // It's well placed, add another point
            if (wantedSentence.charAt(i) == _sentence.charAt(i)) {
                fitness++;
            }
        }

        return fitness;
    }

    public function getCrossoverPart(roundToSup:Bool):String {
        var geneticPart = "";

        if (roundToSup) {
            geneticPart = _sentence.substr(0, Math.round(_sentence.length / 2));
        } else {
            geneticPart = _sentence.substr(0, Math.floor(_sentence.length / 2));
        }

        return geneticPart;
    }

    public function get__sentence():String {
        return _sentence;
    }
}
