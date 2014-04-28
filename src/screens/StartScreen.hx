package screens;

import flash.display.Bitmap;
import flash.Lib;
import flash.ui.Keyboard;
import openfl.Assets;
import screens.Screen;
import SoundMan;

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
		
		var xx = 400;
		
		var t = new Text(28, true, Manager.COl_LIGHT_GREY, 350);
		t.text = "Pay attention to the sounds of the outside world";
		t.x = xx;
		t.y = 250;
		addChild(t);
		
		t = new Text(28, true, Manager.COl_LIGHT_GREY, 350);
		t.text = "Use your map to pinpoint the right spot";
		t.x = xx;
		t.y = 277;
		addChild(t);
		
		t = new Text(28, true, Manager.COl_LIGHT_GREY, 350);
		t.text = "Dig up to the surface and get the gold!";
		t.x = xx;
		t.y = 304;
		addChild(t);
		
		var yy = 380;
		
		t = new Text(36, true, Manager.COl_GREY, 350);
		t.text = "choose a level";
		t.x = xx;
		t.y = yy;
		addChild(t);
		
		button = new Button(selectEasy, 0xFFFFFF, 0.2, 100, 70);
		button.x = xx + 10;
		button.y = yy + 35;
		addChild(button);
		t = new Text(48, true, Manager.COl_ORANGE, 100);
		t.text = "easy";
		t.x = button.x;
		t.y = button.y;
		addChild(t);
		
		button = new Button(selectNormal, 0xFFFFFF, 0.2, 130, 70);
		button.x = 510;
		button.y = yy + 35;
		addChild(button);
		t = new Text(48, true, Manager.COl_ORANGE, 130);
		t.text = "normal";
		t.x = button.x;
		t.y = button.y;
		addChild(t);
		
		button = new Button(selectHard, 0xFFFFFF, 0.2, 100, 70);
		button.x = 640;
		button.y = yy + 35;
		addChild(button);
		t = new Text(48, true, Manager.COl_ORANGE, 100);
		t.text = "hard";
		t.x = button.x;
		t.y = button.y;
		addChild(t);
		
		SoundMan.play(Track.StartTrack, true);
	}
	
	function selectEasy () {
		Manager.diff = 0;
		launchIntro();
	}
	
	function selectNormal () {
		Manager.diff = 1;
		launchIntro();
	}
	
	function selectHard () {
		Manager.diff = 2;
		launchIntro();
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
