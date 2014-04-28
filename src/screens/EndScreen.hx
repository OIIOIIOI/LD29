package screens;

import flash.display.Bitmap;
import openfl.Assets;
import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class EndScreen extends Screen {
	
	var bg:Bitmap;
	var titleText:Text;
	var captionText:Text;
	var mapButton:Button;
	var mapButtonText:Text;
	var backButton:Button;
	var backButtonText:Text;
	
	public function new () {
		super();
		
		var path:String = "img/screen_lose.jpg";
		if (Manager.INST.win)	path = "img/screen_win.jpg";
		
		bg = new Bitmap(Assets.getBitmapData(path));
		addChild(bg);
		
		// Title
		titleText = new Text(58, true, Manager.COl_ORANGE, 600, !Manager.INST.win);
		if (Manager.INST.win) {
			if (Manager.INST.perfect)	titleText.text = "PERFECT!";
			else						titleText.text = "WELL DONE!";
			titleText.x = 20;
			titleText.y = 230;
		} else {
			titleText.text = "GAME OVER";
			titleText.x = Std.int((bg.width - titleText.width) / 2);
			titleText.y = 350;
		}
		addChild(titleText);
		
		// Caption
		captionText = new Text(28, false, Manager.COl_GREY, 600, !Manager.INST.win);
		if (Manager.INST.win) {
			if (Manager.INST.perfect)	captionText.text = "You were right on the spot";
			else						captionText.text = "You surfaced near the treasure";
			captionText.x = titleText.x;
			captionText.y = titleText.y + 60;
		} else {
			captionText.text = "You missed it completely";
			captionText.x = Std.int((bg.width - captionText.width) / 2);
			captionText.y = titleText.y + 60;
		}
		addChild(captionText);
		
		// Back button
		backButton = new Button(endGame, 0xFFFFFF, 0.3, 160, 40);
		if (Manager.INST.win)	backButton.x = 15;
		else					backButton.x = Std.int((bg.width - backButton.width) / 2);
		backButton.y = bg.height - backButton.height - 15;
		addChild(backButton);
		
		backButtonText = new Text(28, true, Manager.COl_ORANGE, 160);
		backButtonText.text = "back to title";
		backButtonText.x = backButton.x;
		backButtonText.y = backButton.y;
		addChild(backButtonText);
		
		// Map button
		mapButton = new Button(viewMap, 0xFFFFFF, 0.3, 160, 45);
		if (Manager.INST.win)	mapButton.x = 15;
		else					mapButton.x = Std.int((bg.width - mapButton.width) / 2);
		mapButton.y = backButton.y - mapButton.height - 10;
		addChild(mapButton);
		
		mapButtonText = new Text(32, true, Manager.COl_ORANGE, 160);
		mapButtonText.text = "view map";
		mapButtonText.x = mapButton.x;
		mapButtonText.y = mapButton.y;
		addChild(mapButtonText);
	}
	
	override public function update () {
		Manager.INST.map.update();
	}
	
	function viewMap () {
		Manager.INST.map.closedHandler = closeMap;
		addChild(Manager.INST.map);
		Manager.INST.map.active = true;
	}
	
	function closeMap () {
		removeChild(Manager.INST.map);
		Manager.INST.map.active = false;
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
		
		backButton.destroy();
		removeChild(backButton);
		backButton = null;
		
		Manager.INST.destroy();
	}
	
}
