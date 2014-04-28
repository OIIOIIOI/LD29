package;

import flash.display.Sprite;
import flash.Lib;

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
		
		/*var dist = 10;
		var angle = 27 * Math.PI / 180;
		
		var dx = dist * Math.cos(angle);
		var dy = dist * Math.sin(angle);
		trace(dx + " / " + dy);
		
		var dist2 = Math.sqrt(dx * dx + dy * dy);
		trace(dist2);
		
		dx = 0;
		var dist2 = Math.sqrt(dx * dx + dy * dy);
		trace(dist2);*/
	}
	
}
