package com.thanadev.geneticsentence.controllers;


import org.tamina.html.component.HTMLComponent;

@view("com/thanadev/geneticsentence/views/MainView.html")
class MainController extends HTMLComponent {

    @skinpart('') private var _userChoiceElement:UserChoiceController;

    override public function createdCallback():Void {
        super.createdCallback();
    }
}
