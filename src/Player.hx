package ;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

class Player extends AnimEntity {
	
	public var moving:Bool;
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		super(mapX, mapY);
		
		moving = false;
		
		frames = new Array();
		frames.push( { rect:new Rectangle(14, 0, 14, 11), duration:15 } );
		frames.push( { rect:new Rectangle(14, 11, 14, 11), duration:15 } );
		
		curFrame = 0;
		
		updateFrame();
		
		bmp.x = -Std.int(bmp.width / 2);
		bmp.y = -Std.int(bmp.height / 2);
	}
	
	override public function update () {
		//trace(moving);
		if (moving)	super.update();
	}
	
}
