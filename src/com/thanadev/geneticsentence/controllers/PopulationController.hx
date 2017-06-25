package com.thanadev.geneticsentence.controllers;

import haxe.Timer;
import com.thanadev.geneticsentence.services.NotificationService;
import com.thanadev.geneticsentence.classes.Settings;
import com.thanadev.geneticsentence.services.PopulationService;
import js.html.Element;
import org.tamina.html.component.HTMLComponent;

@view("com/thanadev/geneticsentence/views/PopulationView.html")
class PopulationController extends HTMLComponent {

    @skinpart('') private var _sentencesLabel:Element;

    private var _sentenceWanted:String;
    private var _popService:PopulationService;

    override public function createdCallback():Void {
        super.createdCallback();

        _popService = PopulationService.get__instance();
        _sentenceWanted = "";
        NotificationService.get__instance().get__populationActualizedSignal().add(actualizePop);
    }

    public function startProcess(sentence:String):Void {
        _sentenceWanted = sentence;
        _popService.initPopulation(Settings.POPULATION_NUMBER, sentence.length);

        actualizePop();

        var timer = new Timer(1000);
        timer.run = function():Void {
            _popService.startReproductionProcess(_sentenceWanted);
        };
    }

    private function actualizePop():Void {
        _sentencesLabel.innerHTML = "";
        var popStocked = _popService.get__population();

        for (i in 0...popStocked.length) {
            _sentencesLabel.innerHTML += "<p>" + popStocked[i].get__sentence() + " : " +  popStocked[i].getFitnessScore(_sentenceWanted) + "</p>";
        }
    }
}
