package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;

/**
 * ...
 * @author 01101101
 */

class AnimEntity extends Entity {
	
	public static var SPRITES:BitmapData;
	static var P:Point = new Point();
	
	var frames:Array<Frame>;
	var curFrame:Int;
	
	var bmpData:BitmapData;
	var bmp:Bitmap;
	
	var tick:Int;
	
	public function new (mapX:Float = 0, mapY:Float = 0) {
		if (SPRITES == null)	SPRITES = Assets.getBitmapData("img/sprites.png");
		super(mapX, mapY);
	}
	
	public function update () {
		if (frames == null || frames.length <= 1 || tick <= 0)	return;
		tick--;
		if (tick == 0) {
			curFrame++;
			if (curFrame == frames.length)	curFrame = 0;
			updateFrame();
		}
	}
	
	function updateFrame () {
		var f = frames[curFrame];
		if (bmpData == null) {
			bmpData = new BitmapData(Std.int(f.rect.width), Std.int(f.rect.height), true, 0x00000000);
			bmp = new Bitmap(bmpData);
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
		} else {
			bmpData.fillRect(bmpData.rect, 0x00000000);
		}
		bmpData.copyPixels(SPRITES, f.rect, P);
		tick = frames[curFrame].duration;
	}
	
}

typedef Frame = {
	rect:Rectangle,
	duration:Int
}
