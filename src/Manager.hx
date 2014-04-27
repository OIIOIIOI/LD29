package ;

/**
 * ...
 * @author 01101101
 */

class Manager {
	
	public static var SCALE:Int = 3;
	
	public static var beacons(default, null):List<Beacon>;
	
	public static function init () {
		beacons = new List<Beacon>();
	}
	
	public static function destroy () {
		
	}
	
}
