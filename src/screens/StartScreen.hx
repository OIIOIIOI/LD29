package screens;

import flash.display.Bitmap;
import flash.Lib;
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
	}
	
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
