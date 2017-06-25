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
    @skinpart('') private var _generationLabel:Element;

    private var _sentenceWanted:String;
    private var _popService:PopulationService;
    private var _generationCount:Int;
    private var timer:Timer;

    override public function createdCallback():Void {
        super.createdCallback();

        _popService = PopulationService.get__instance();
        _sentenceWanted = "";
        _generationCount = 0;
        NotificationService.get__instance().get__populationActualizedSignal().add(actualizePop);
    }

    public function startProcess(sentence:String):Void {
        _sentenceWanted = sentence;
        _popService.initPopulation(Settings.POPULATION_NUMBER, sentence.length);

        actualizePop();

        timer = new Timer(100);
        timer.run = function():Void {
            _generationCount++;
            _generationLabel.innerText = Std.string(_generationCount);
            _popService.startReproductionProcess(_sentenceWanted);
        };
    }

    private function actualizePop():Void {
        _sentencesLabel.innerHTML = "";
        var popStocked = _popService.get__population();

        for (i in 0...popStocked.length) {
            if (popStocked[i].isWantedSentence(_sentenceWanted)) {
                timer.stop();
                NotificationService.get__instance().get__wantedSentenceFoundSignal().dispatch(popStocked[i].get__sentence());
            }
            _sentencesLabel.innerHTML += "<p>" + popStocked[i].get__sentence() + " : " +  popStocked[i].getFitnessScore(_sentenceWanted) + "</p>";
        }
    }
}
