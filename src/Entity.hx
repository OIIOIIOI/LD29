package ;

import flash.display.Sprite;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */
class Entity extends Sprite {
	
	public var mapPos(default, null):Point;
	
	public function new (mapX:Float, mapY:Float, color:UInt = 0xFFFF00, alpha:Float = 0.5, radius:Int = 15) {
		super();
		
		mapPos = new Point(mapX, mapY);
		
		graphics.beginFill(color, alpha);
		graphics.drawCircle(0, 0, radius);
		graphics.endFill();
		graphics.lineStyle(2);
		graphics.moveTo(0, 0);
		graphics.lineTo(0, -radius);
	}
	
	public function resetPos (mapX:Float, mapY:Float) {
		mapPos.x = mapX;
		mapPos.y = mapY;
	}
	
}