package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import SoundWave;

/**
 * ...
 * @author 01101101
 */

class Main extends Sprite {
	
	public static function main () {
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		
		//Lib.current.addChild(new Game());
		Lib.current.addChild(new Test());
	}
	
}
