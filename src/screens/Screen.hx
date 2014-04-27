package screens ;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Screen extends Sprite {
	
	public function new () {
		super();
		trace("created " + this);
	}
	
	public function destroy () {
		trace("destroyed " + this);
	}
	
}

enum ScreenName {
	Start;
	Intro;
	Play;
	End;
}
