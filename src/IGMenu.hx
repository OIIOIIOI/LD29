package ;

import flash.display.Sprite;
import flash.Lib;
import flash.ui.Keyboard;

/**
 * ...
 * @author 01101101
 */

class IGMenu extends Sprite {
	
	var overlay:Sprite;
	var bg:Sprite;
	
	public var active(default, null):Bool;
	
	public function new () {
		super();
		
		overlay = new Sprite();
		overlay.graphics.beginFill(0x000000, 0.8);
		overlay.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		overlay.graphics.endFill();
		
		bg = new Sprite();
		bg.graphics.beginFill(0xFFFFFF, 1);
		bg.graphics.drawRect(0, 0, 700, 200);
		bg.graphics.endFill();
		bg.x = (overlay.width - bg.width) / 2;
		bg.y = (overlay.height - bg.height) / 2;
		
		active = false;
	}
	
	public function open (v:Bool = true) {
		if (v) {
			addChild(overlay);
			addChild(bg);
		} else {
			removeChild(overlay);
			removeChild(bg);
		}
		active = v;
	}
	
	public function update () {
		if (active) {
			if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed)	open(false);
		}
	}
	
}
