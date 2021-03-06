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
	
	override public function update () {
		super.update();
		var angle:Float;
		var dist:Float;
		for (b in Manager.INST.beacons) {
			var dx = x - b.x;
			var dy = y - b.y;
			angle = Math.atan2(dy, dx);// * 180 / Math.PI;
			dist = Math.sqrt(dx * dx + dy * dy);
			// Hide arrow if close
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
	
	static var cols:Array<UInt>;
	
	public function new () {
		super();
		
		graphics.lineStyle(1, 0x000000);
		graphics.beginFill(getColor(), 1);
		graphics.moveTo(-20, 0);
		graphics.lineTo(0, 7);
		graphics.lineTo(0, -7);
		graphics.lineTo(-20, 0);
		graphics.endFill();
	}
	
	function getColor () :UInt {
		if (cols == null)	cols = new Array();
		if (cols.length == 0)	cols = [0x00a0b0, 0xffc915, 0xec2232, 0x5cb421, 0xffffff];
		return cols.pop();
	}
	
}















