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
	
	public var beacons(default, null):List<Beacon>;
	public var tick(default, null):Int;
	
	public static function init () {
		if (INST != null)	throw new Error("Manager already instanciated");
		INST = new Manager();
	}
	
	public function new () {
		
	}
	
	public function reset () {
		beacons = new List<Beacon>();
		tick = 0;
	}
	
	public function update () {
		tick++;
	}
	
	public function destroy () {
		beacons = null;
	}
	
}
