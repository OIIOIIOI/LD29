package ;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
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
	var cross:Shape;
	
	public function new () {
		super();
		INST = this;
		TILES = Assets.getBitmapData("img/tiles.png");
		
		// Init keyboard manager
		KeyboardMan.init();
		
		// Init gloal manager
		Manager.init();
		
		cross = new Shape();
		cross.graphics.beginFill(0xFFFFFF, 0.2);
		cross.graphics.drawRect(Lib.current.stage.stageWidth / 2 - 2, 0, 4, Lib.current.stage.stageHeight);
		cross.graphics.drawRect(0, Lib.current.stage.stageHeight / 2 - 2, Lib.current.stage.stageWidth, 4);
		cross.graphics.endFill();
		
		changeScreen(ScreenName.Play);
		
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
			case ScreenName.End: new EndScreen();
		}
		addChild(screen);
		addChild(cross);
		// Reset focus
		Lib.current.stage.focus = null;
	}
	
	function update (e:Event) {
		screen.update();
		KeyboardMan.INST.update();
	}
	
}
