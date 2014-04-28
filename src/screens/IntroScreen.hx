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
	
	var bg:Bitmap;
	var button:Button;
	var text:Text;
	
	var f:Int;
	var timeLeft:Int;
	
	public function new () {
		super();
		
		f = 1;
		timeLeft = 60;
		
		bg = new Bitmap(Assets.getBitmapData("img/screen_intro_1.jpg"));
		addChild(bg);
		
		button = new Button(skip, 0xFFFFFF, 0.3, 160, 50);
		button.x = bg.width - button.width;
		button.y = bg.height - button.height;
		addChild(button);
		
		text = new Text(32, true, Manager.COl_ORANGE, 160);
		text.text = "skip intro";
		text.x = button.x;
		text.y = button.y;
		addChild(text);
	}
	
	override public function update () {
		if (timeLeft >= 0)	timeLeft--;
		else				next();
	}
	
	function next () {
		if (f < 5) {
			bg.bitmapData.dispose();
			f++;
			bg.bitmapData = Assets.getBitmapData("img/screen_intro_" + f + ".jpg");
			timeLeft = switch (f) {
				default: 60;
			};
		} else {
			Game.INST.changeScreen(ScreenName.Play);
		}
	}
	
	function skip () {
		Game.INST.changeScreen(ScreenName.Play);
	}
	
	override public function destroy () {
		super.destroy();
		
		removeChild(bg);
		if (bg.bitmapData != null) {
			bg.bitmapData.dispose();
			bg.bitmapData = null;
		}
		bg = null;
		
		//button.destroy();
		//removeChild(button);
		//button = null;
	}
	
}
