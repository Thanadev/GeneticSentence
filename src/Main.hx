package ;

import com.thanadev.geneticsentence.controllers.MainController;
import org.tamina.html.component.HTMLApplication;

class Main extends HTMLApplication {

    private static var _instance:Main;

    private var _mainView:MainController;

    public static function main() {
        new Main();
    }

    private function new() {
        super();
        trace("loading components...");
        loadComponents();
    }
}
