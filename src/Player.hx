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
	var anim:PlayerAnim;
	
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
		setAnim(PlayerAnim.Walk);
		
		updateFrame();
		
		bmp.x = -Std.int(bmp.width / 2);
		bmp.y = -Std.int(bmp.height / 2);
	}
	
	public function setAnim (anim:PlayerAnim) {
		this.anim = anim;
		frames = [];
		addChild(shadow);
		switch (anim) {
			case PlayerAnim.LookUp:
				frames.push( { rect:new Rectangle(28, 32, 15, 11), duration:10 } );
			case PlayerAnim.Dig:
				frames.push( { rect:new Rectangle(43, 32, 15, 11), duration:10 } );
				frames.push( { rect:new Rectangle(58, 32, 15, 11), duration:10 } );
				removeChild(shadow);
			case PlayerAnim.Win:
				frames.push( { rect:new Rectangle(73, 32, 15, 11), duration:10 } );
				frames.push( { rect:new Rectangle(88, 32, 15, 11), duration:10 } );
				removeChild(shadow);
			case PlayerAnim.Lose:
				frames.push( { rect:new Rectangle(103, 32, 15, 11), duration:10 } );
				frames.push( { rect:new Rectangle(118, 32, 15, 11), duration:10 } );
				removeChild(shadow);
			default:
				frames.push( { rect:new Rectangle(0, 32, 14, 11), duration:15 } );
				frames.push( { rect:new Rectangle(14, 32, 14, 11), duration:15 } );
		}
		curFrame = 0;
		updateFrame();
	}
	
	override public function update () {
		switch (anim) {
			case PlayerAnim.Walk:
				if (!moving)	return;
			case PlayerAnim.Dig:
				scaleX = scaleY += 0.002;
			default:
		}
		super.update();
	}
	
}

enum PlayerAnim {
	Walk;
	LookUp;
	Dig;
	Win;
	Lose;
}










