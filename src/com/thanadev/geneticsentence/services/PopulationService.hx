package com.thanadev.geneticsentence.services;

import com.thanadev.geneticsentence.classes.Settings;
import com.thanadev.geneticsentence.classes.PopulationElement;

class PopulationService {
    @:isVar static var _instance(get, null):PopulationService;

    @:isVar var _population(get, null):Array<PopulationElement>;

    private function new() {
        _population = new Array<PopulationElement>();
    }

    public function initPopulation(popNb:Int, charNb:Int):Void {
        for (i in 0...popNb) {
            _population.push(generateRandomPopElement(charNb));
        }
    }

    private function generateRandomPopElement(charNb:Int):PopulationElement {
        var sentence = "";
        for (i in 0...charNb) {
            var index = Math.floor(Settings.POSSIBLE_CHARS.length * Math.random());
            sentence += Settings.POSSIBLE_CHARS[index];
        }

        return new PopulationElement (sentence);
    }

    public static function get__instance():PopulationService {
        if (_instance == null) {
            _instance = new PopulationService();
        }

        return _instance;
    }

    public function get__population():Array<PopulationElement> {
        return _population;
    }
}
