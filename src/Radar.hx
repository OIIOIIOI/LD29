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
		for (b in Test.INST.beacons) {
			if (!contains(b.arrow))	addChild(b.arrow);
			
			angle = Math.atan2(y - b.y, x - b.x);// * 180 / Math.PI;
			//TODO distance and scale
			
			var m = new Matrix();
			m.translate(-30, 0);
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