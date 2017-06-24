package com.thanadev.geneticsentence.controllers;

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
    }

    public function startProcess(sentence:String):Void {
        _sentenceWanted = sentence;
        _popService.initPopulation(Settings.POPULATION_NUMBER, sentence.length);

        for (i in 0..._popService.get__population().length) {
            _sentencesLabel.innerHTML += "<p>" + _popService.get__population()[i].get__sentence() + "</p>";
        }
    }
}
