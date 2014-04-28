package ;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import openfl.Assets;
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
	public static var TILES:BitmapData;
	
	var screen:Screen;
	
	public function new () {
		super();
		INST = this;
		TILES = Assets.getBitmapData("img/tiles.png");
		
		// Init keyboard manager
		KeyboardMan.init();
		
		// Init gloal manager
		Manager.init();
		
		changeScreen(ScreenName.Start);
		
		addEventListener(Event.ENTER_FRAME, update);
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
			case ScreenName.Win: new EndScreen(true);
			case ScreenName.Lose: new EndScreen();
		}
		addChild(screen);
	}
	
	function update (e:Event) {
		screen.update();
		KeyboardMan.INST.update();
	}
	
}
