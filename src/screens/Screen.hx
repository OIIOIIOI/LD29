package screens ;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Screen extends Sprite {
	
	public function new () {
		super();
	}
	
	public function destroy () {
		
	}
	
}

enum ScreenName {
	Start;
	Intro;
	Play;
	End;
}