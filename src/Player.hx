package ;

import flash.display.BlendMode;
import flash.display.Shape;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

class Player extends AnimEntity {
	
	public var moving:Bool;
	var shadow:Shape;
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		super(mapX, mapY);
		
		moving = false;
		
		shadow = new Shape();
		shadow.graphics.beginFill(0x000000, 0.2);
		shadow.graphics.drawCircle(0, 8, 17);
		shadow.graphics.endFill();
		shadow.blendMode = BlendMode.DARKEN;
		addChild(shadow);
		
		frames = new Array();
		frames.push( { rect:new Rectangle(0, 0, 14, 11), duration:15 } );
		frames.push( { rect:new Rectangle(0, 11, 14, 11), duration:15 } );
		
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
