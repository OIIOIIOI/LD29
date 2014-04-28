package screens;

import flash.display.Bitmap;
import openfl.Assets;
import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class EndScreen extends Screen {
	
	var button:Button;
	var bg:Bitmap;
	
	public function new (win:Bool = false) {
		super();
		
		var path:String = "img/screen_lose.jpg";
		if (win)	path = "img/screen_win.jpg";
		
		bg = new Bitmap(Assets.getBitmapData(path));
		addChild(bg);
		
		button = new Button(endGame, 0xFFFFFF);
		button.x = button.y = 20;
		addChild(button);
	}
	
	function endGame () {
		Game.INST.changeScreen(ScreenName.Start);
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
		
		Manager.INST.destroy();
	}
	
}
