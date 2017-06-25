package com.thanadev.geneticsentence.services;

import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

class NotificationService {

    @:isVar static var _instance(get, null):NotificationService;

    @:isVar var _userValidateSignal(get, null):Signal1<String>;
    @:isVar var _populationActualizedSignal(get, null):Signal0;

    private function new() {
        _userValidateSignal = new Signal1<String>();
        _populationActualizedSignal = new Signal0();
    }

    public static function get__instance():NotificationService {
        if (_instance == null) {
            _instance = new NotificationService();
        }

        return _instance;
    }

    public function get__userValidateSignal():Signal1<String> {
        return _userValidateSignal;
    }

    public function get__populationActualizedSignal():Signal0 {
        return _populationActualizedSignal;
    }
}
