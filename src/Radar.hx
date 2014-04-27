package ;

import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */

class Radar extends Entity {
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		super(mapX, mapY);
		
	}
	
	public function update () {
		var angle:Float;
		var dist:Float;
		for (b in Test.INST.beacons) {
			var dx = x - b.x;
			var dy = y - b.y;
			angle = Math.atan2(dy, dx);// * 180 / Math.PI;
			dist = Math.sqrt(dx * dx + dy * dy);
			if (dist < 50) {
				if (contains(b.arrow))	removeChild(b.arrow);
			} else {
				if (!contains(b.arrow))	addChild(b.arrow);
			}
			
			var m = new Matrix();
			m.translate(-20, 0);
			m.rotate(angle);
			b.arrow.transform.matrix = m;
		}
	}
	
}

class RadarArrow extends Sprite {
	
	public function new (color:UInt) {
		super();
		
		graphics.lineStyle(1, 0xFFFFFF);
		graphics.beginFill(color, 0.8);
		graphics.moveTo(-20, 0);
		graphics.lineTo(0, 7);
		graphics.lineTo(0, -7);
		graphics.lineTo(-20, 0);
		graphics.endFill();
	}
	
}