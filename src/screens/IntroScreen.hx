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

class IntroScreen extends Screen {
	
	var button:Button;
	var bg:Bitmap;
	var f:Int;
	
	public function new () {
		super();
		
		f = 1;
		bg = new Bitmap(Assets.getBitmapData("img/screen_intro_" + f + ".jpg"));
		addChild(bg);
		
		button = new Button(next, 0xFF00FF, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		addChild(button);
	}
	
	override public function update () {
		if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			next();
		}
	}
	
	function next () {
		if (f < 5) {
			bg.bitmapData.dispose();
			f++;
			bg.bitmapData = Assets.getBitmapData("img/screen_intro_" + f + ".jpg");
		} else {
			Game.INST.changeScreen(ScreenName.Play);
		}
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
