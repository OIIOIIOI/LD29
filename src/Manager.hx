package ;

import flash.errors.Error;
import flash.geom.Point;
import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class Manager {
	
	public static var INST:Manager;
	
	public static var TAP:Point = new Point();
	public static var SCALE:Int = 3;
	public static var SCREEN_SIZE:Int = 600;
	public static var SS_HALF:Int;
	
	static var SIZE_DELAY:Int = 90;// Delay between light size reductions
	
	public var beacons(default, null):List<Beacon>;
	public var tick(default, null):Int;
	
	public var lightSize(default, null):Float;
	
	public var win:Bool;
	public var perfect:Bool;
	
	public static function init () {
		if (INST != null)	throw new Error("Manager already instanciated");
		INST = new Manager();
		SS_HALF = Std.int(SCREEN_SIZE / 2);
	}
	
	public function new () {
		reset();
	}
	
	public function reset () {
		beacons = new List<Beacon>();
		tick = 0;
		win = perfect = false;
		lightSize = 0.95;
	}
	
	public function update () {
		tick++;
		if (tick % SIZE_DELAY == 0 && lightSize > 0.4) {
			lightSize -= 0.01;
		}
	}
	
	public function destroy () {
		beacons = null;
	}
	
}
