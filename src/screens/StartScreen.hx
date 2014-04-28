package screens;

import flash.display.Bitmap;
import flash.Lib;
import flash.ui.Keyboard;
import openfl.Assets;
import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class StartScreen extends Screen {
	
	var button:Button;
	var bg:Bitmap;
	
	public function new () {
		super();
		
		bg = new Bitmap(Assets.getBitmapData("img/screen_title.jpg"));
		addChild(bg);
		
		button = new Button(launchIntro, 0xFF00FF, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		addChild(button);
		
		var t = new Text(36, true, Manager.COl_ORANGE, 400);
		t.text = "click to start";
		t.x = 400;
		t.y = 460;
		addChild(t);
	}
	
	/*override public function update () {
		if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			launchIntro();
		}
	}*/
	
	function launchIntro () {
		Game.INST.changeScreen(ScreenName.Intro);
	}
	
	override public function destroy () {
		super.destroy();
		
		removeChild(bg);
		if (bg.bitmapData != null) {
			bg.bitmapData.dispose();
			bg.bitmapData = null;
		}
		bg = null;
		
		button.destroy();
		removeChild(button);
		button = null;
	}
	
}
