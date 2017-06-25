package com.thanadev.geneticsentence.services;

import com.thanadev.geneticsentence.classes.Settings;
import com.thanadev.geneticsentence.classes.PopulationElement;

class PopulationService {
    @:isVar static var _instance(get, null):PopulationService;

    @:isVar var _population(get, null):Array<PopulationElement>;
    private var populationNumber:Int;

    private function new() {
        _population = new Array<PopulationElement>();
    }

    public function initPopulation(popNb:Int, charNb:Int):Void {
        populationNumber = popNb;

        for (i in 0...popNb) {
            _population.push(generateRandomPopElement(charNb));
        }
    }

    public function startReproductionProcess(wantedSentence:String):Void {
        var fitnessMap = new Map<Int, Array<PopulationElement>>();

        for (fitness in 0...wantedSentence.length) {
            fitnessMap.arrayWrite(fitness, new Array<PopulationElement>());
        }

        for (i in 0..._population.length) {
            var key = _population[i].getFitnessScore(wantedSentence);
            if (fitnessMap.exists(key)) {
                fitnessMap.get(key).push(_population[i]);
            } else{
                trace("Inexistant fitness score : " + key);
            }
        }

        _population = new Array<PopulationElement>();

        for (fitness in fitnessMap.keys()) {
            for (popElement in fitnessMap.get(fitness)) {
                _population.push(popElement);
            }
        }

        _population.reverse();

        NotificationService.get__instance().get__populationActualizedSignal().dispatch();
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
