package ;

import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;

/**
 * ...
 * @author 01101101
 */

class KeyboardMan {
	
	public static var INST:KeyboardMan;
	
	var keys:Map<Int, Bool>;
	
	public function new () {
		INST = this;
		
		registerKeys();
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
	}
	
	function registerKeys () {
		if (keys != null)	return;
		keys = new Map<Int, Bool>();
		keys.set(Keyboard.UP, false);
		keys.set(Keyboard.RIGHT, false);
		keys.set(Keyboard.DOWN, false);
		keys.set(Keyboard.LEFT, false);
	}
	
	function keyDownHandler (e:KeyboardEvent) {
		if (keys.exists(e.keyCode))	keys.set(e.keyCode, true);
	}
	
	function keyUpHandler (e:KeyboardEvent) {
		if (keys.exists(e.keyCode))	keys.set(e.keyCode, false);
	}
	
	public function isDown (k:Int) {
		if (!keys.exists(k))	return false;
		return keys.get(k);
	}
	
}