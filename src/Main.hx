package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

/**
 * ...
 * @author 01101101
 */

class Main extends Sprite {
	
	public static function main () {
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
	
	var testwave:SoundWave;
	
	public function new () {
		super();
		testwave = new SoundWave("prout", 50, 10, 100, 100);
		addChild(testwave);
		addChild(new TestBtn(0xFFFFFF,300,300,changerange));
	}
	
	function changerange(e:MouseEvent) {
		testwave.AimedWaveFreq = 1;
		testwave.AimedWaveRange = 100;
	};
}
