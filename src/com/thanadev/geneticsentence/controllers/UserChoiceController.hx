package com.thanadev.geneticsentence.controllers;

import org.tamina.events.html.MouseEventType;
import js.html.ButtonElement;
import js.html.InputElement;
import org.tamina.html.component.HTMLComponent;

@view("com/thanadev/geneticsentence/views/UserChoiceView.html")
class UserChoiceController extends HTMLComponent {

    @skinpart("") private var _sentenceInput:InputElement;
    @skinpart("") private var _submitButton:ButtonElement;

    override public function createdCallback():Void {
        super.createdCallback();

        addListeners();
    }

    private function addListeners():Void {
        _submitButton.addEventListener(MouseEventType.CLICK, submitClickedHandler);
    }

    private function submitClickedHandler():Void {
        trace("Clicked with text " + _sentenceInput.value);
    }
}
