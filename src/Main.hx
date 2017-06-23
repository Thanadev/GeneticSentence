package ;

import com.thanadev.geneticsentence.views.MainView;
import org.tamina.html.component.HTMLApplication;

class Main extends HTMLApplication {

    private static var _instance:Main;

    private var _mainView:MainView;

    public static function main() {
        new Main();
    }

    private function new() {
        super();

        trace('loading comps');
        loadComponents();
    }
}
