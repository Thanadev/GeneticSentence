package com.thanadev.geneticsentence.services;

import com.thanadev.geneticsentence.classes.PopulationElement;

class PopulationService {
    @:isVar static var _instance(get, null):PopulationService;

    @:isVar var _population(get, null):Array<PopulationElement>;

    private function new() {
        _population = new Array<PopulationElement>();
    }

    public function initPopulation(popNb:Int):Void {
        for (i in 0...popNb) {
            _population.push(generateRandomPopElement());
        }
    }

    private function generateRandomPopElement():PopulationElement {
        // TODO

        return new PopulationElement ('TODO');
    }

    public static function get__instance():PopulationService {
        if (_instance == null) {
            _instance = new PopulationService();
        }

        return _instance;
    }

    public function get__population():Array {
        return _population;
    }
}
