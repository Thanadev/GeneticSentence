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
        // Parent selection
        var maxFitness:Float = 0;

        for (i in 0..._population.length) {
            var fitness = _population[i].getFitnessScore(wantedSentence);

            if (fitness > maxFitness) {
                maxFitness = fitness;
            }
        }

        // map all fitnesses between 0 and 1 according to the max fitness to get the ratio of darwin pool
        var parents = new Array<PopulationElement>();

        for (i in 0..._population.length) {
            var nbToPush = Math.floor(_population[i].getFitnessScore(wantedSentence) / maxFitness * 100);

            for (j in 0...nbToPush) {
                parents.push(_population[i]);
            }
        }

        // Produce a new pop of PopNB Elements
        var children = new Array<PopulationElement>();

        for (i in 0..._population.length) {
            // Crossover phase
            var indexParent1 = Math.floor(parents.length * Math.random());
            var indexParent2 = Math.floor(parents.length * Math.random());
            var parent1 = parents[indexParent1];
            var parent2 = parents[indexParent2];

            var child = new PopulationElement(parent1.getCrossoverPart(true) + parent2.getCrossoverPart(false));
            child.getMutation();

            children.push(child);
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
