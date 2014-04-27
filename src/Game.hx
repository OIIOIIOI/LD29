package ;

import flash.display.Sprite;
import screens.EndScreen;
import screens.IntroScreen;
import screens.PlayScreen;
import screens.Screen;
import screens.StartScreen;

/**
 * ...
 * @author 01101101
 */

class Game extends Sprite {
	
	public static var INST:Game;
	
	var screen:Screen;
	
	public function new () {
		INST = this;
		super();
		changeScreen(ScreenName.Start);
	}
	
	public function changeScreen (name:ScreenName) {
		// Old one
		if (screen != null) {
			removeChild(screen);
			screen.destroy();
		}
		// New one
		screen = switch (name) {
			case ScreenName.Start: new StartScreen();
			case ScreenName.Intro: new IntroScreen();
			case ScreenName.Play: new PlayScreen();
			case ScreenName.End: new EndScreen();
		}
		addChild(screen);
	}
	
}
