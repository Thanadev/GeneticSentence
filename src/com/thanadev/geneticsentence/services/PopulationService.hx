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

        // Init
        for (fitness in 0...wantedSentence.length) {
            fitnessMap.arrayWrite(fitness, new Array<PopulationElement>());
        }

        // Get fitness and order them in map
        for (i in 0..._population.length) {
            var key = _population[i].getFitnessScore(wantedSentence);
            if (fitnessMap.exists(key)) {
                fitnessMap.get(key).push(_population[i]);
            } else{
                trace("Inexistant fitness score : " + key);
            }
        }

        // Prepare parents with probabilities
        var parents = new Array<PopulationElement>();

        // key is Int
        for (key in fitnessMap.keys()) {
            var popSegment:Array<PopulationElement> = fitnessMap.get(key);

            for (childCount in 0...popSegment.length) {
                for (repetition in 0...key) {
                    parents.push(popSegment[childCount]);
                }
            }
        }

        // Produce a new pop of PopNB Elements
        var children = new Array<PopulationElement>();

        for (i in 0..._population.length) {
            var index = Math.floor(parents.length * Math.random());
            children.push(parents[index]);
        }

        _population = children;

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
