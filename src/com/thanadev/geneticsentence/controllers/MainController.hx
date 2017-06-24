package com.thanadev.geneticsentence.controllers;


import com.thanadev.geneticsentence.services.NotificationService;
import js.html.Element;
import org.tamina.html.component.HTMLComponent;

@view("com/thanadev/geneticsentence/views/MainView.html")
class MainController extends HTMLComponent {

    @skinpart('') private var _userChoiceElement:UserChoiceController;
    @skinpart('') private var _populationElement:PopulationController;
    @skinpart('') private var _sentenceLabel:Element;

    private var _sentenceWanted:String;

    override public function createdCallback():Void {
        super.createdCallback();

        _sentenceWanted = "";

        NotificationService.get__instance().get__userValidateSignal().add(userValidatedHandler);
    }

    private function userValidatedHandler(sentence:String):Void {
        _sentenceWanted = sentence;
        _sentenceLabel.innerText = _sentenceWanted;
        _populationElement.startProcess(_sentenceWanted);
    }
}
