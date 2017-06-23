package com.thanadev.geneticsentence.classes;

class PopulationElement {

    @:isVar var _sentence(get, null):String;

    public function new(sentence:String) {
        _sentence = sentence;
    }

    function get__sentence():String {
        return _sentence;
    }
}
