package ;

import flash.geom.Rectangle;
import Radar;

/**
 * ...
 * @author 01101101
 */

class Beacon extends AnimEntity {
	
	public var arrow(default, null):RadarArrow;
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		super(mapX, mapY);
		
		arrow = new RadarArrow();
		
		frames = new Array();
		frames.push( { rect:new Rectangle(99, 17, 10, 14), duration:60 } );
		frames.push( { rect:new Rectangle(111, 17, 10, 14), duration:10 } );
		
		curFrame = 0;
		
		updateFrame();
		
		bmp.x = -Std.int(bmp.width / 2);
		bmp.y = -Std.int(bmp.height / 2);
	}
	
}