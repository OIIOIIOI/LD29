package;

import flash.display.Sprite;
import flash.Lib;
import openfl.display.FPS;

/**
 * ...
 * @author 01101101
 */

class Main extends Sprite {
	
	public static function main () {
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		
		// Add game
		Lib.current.addChild(new Game());
		Lib.current.addChild(new FPS(0, 0, 0xFFFFFF));
	}
	
}
