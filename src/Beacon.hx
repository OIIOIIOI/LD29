package ;

import Radar;

/**
 * ...
 * @author 01101101
 */

class Beacon extends Entity {
	
	public var arrow(default, null):RadarArrow;
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		var c = Std.random(0xFFFFFF);
		super(mapX, mapY, c, 1, 10, true);
		
		arrow = new RadarArrow(c);
	}
	
}