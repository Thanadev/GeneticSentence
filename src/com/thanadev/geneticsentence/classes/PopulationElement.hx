package com.thanadev.geneticsentence.classes;

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
        }

        return fitness;
    }

    public function get__sentence():String {
        return _sentence;
    }
}
