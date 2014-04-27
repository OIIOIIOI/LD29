package screens;

import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class StartScreen extends Screen {
	
	var button:Button;
	
	public function new () {
		super();
		
		button = new Button(launchIntro, 0xFFFFFF);
		button.x = button.y = 20;
		addChild(button);
	}
	
	function launchIntro () {
		Game.INST.changeScreen(ScreenName.Intro);
	}
	
}
