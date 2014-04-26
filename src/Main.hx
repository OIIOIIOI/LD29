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
		
		var l = new Level();
		l.load("img/level_demo.png");
		Lib.current.addChild(l.render);
	}
	
}
