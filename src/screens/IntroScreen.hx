package screens;

import flash.display.Bitmap;
import flash.Lib;
import flash.ui.Keyboard;
import haxe.Timer;
import openfl.Assets;
import screens.Screen;
import SoundMan;

/**
 * ...
 * @author 01101101
 */

class IntroScreen extends Screen {
	
	var bg:Bitmap;
	var button:Button;
	var text:Text;
	
	var f:Int;
	var timer:Timer;
	
	public function new () {
		super();
		
		f = 1;
		//timeLeft = 120;
		
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
		
		SoundMan.play(Track.IntroTrack, false);
		
		timer = new Timer(3954);
		timer.run = next;
	}
	
	function next () {
		timer.stop();
		timer = null;
		//
		if (f < 5) {
			bg.bitmapData.dispose();
			f++;
			bg.bitmapData = Assets.getBitmapData("img/screen_intro_" + f + ".jpg");
			
			var delay = switch (f) {
				case 2: 4150;
				case 3: 2040;
				case 4: 3900;
				default: 10000;
			}
			timer = new Timer(delay);
			timer.run = next;
			//Timer.delay(next, delay);
		} else {
			skip();
		}
	}
	
	function skip () {
		if (timer != null) {
			timer.stop();
			timer = null;
		}
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
		
		button.destroy();
		removeChild(button);
		button = null;
	}
	
}
