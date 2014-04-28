package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */

class Light extends Sprite {
	
	var scale:Int = 5;
	
	var shape:Shape;
	var bmpData:BitmapData;
	var bmp:Bitmap;
	
	public function new () {
		super();
		
		scale = 5;
		
		shape = new Shape();
		bmpData = new BitmapData(Math.ceil(Manager.SCREEN_SIZE / scale), Math.ceil(Manager.SCREEN_SIZE / scale), true, 0xFF000000);
		
		reset();
		
		bmp = new Bitmap(bmpData);
		bmp.blendMode = BlendMode.MULTIPLY;
		bmp.scaleX = bmp.scaleY = scale;
		
		addChild(bmp);
	}
	
	public function reset () {
		var size:Float = 0.95;
		
		shape.graphics.clear();
		shape.graphics.beginFill(0xB36298);//0xB36298//0x663456
		shape.graphics.drawCircle(Manager.SCREEN_SIZE / 2 / scale, Manager.SCREEN_SIZE / 2 / scale, Manager.SCREEN_SIZE / 2 / scale * size);
		shape.graphics.endFill();
		shape.graphics.beginFill(0xFFEFBF);//0xFFEFBF//0xFBE08F
		shape.graphics.drawCircle(Manager.SCREEN_SIZE / 2 / scale, Manager.SCREEN_SIZE / 2 / scale, Manager.SCREEN_SIZE / 2 / scale * size / 2);
		shape.graphics.endFill();
		
		bmpData.fillRect(bmpData.rect, 0xFF000000);
		bmpData.draw(shape);
		Manager.TAP.setTo(0, 0);
		//bmpData.applyFilter(bmpData, bmpData.rect, Manager.TAP, new BlurFilter(10 * size, 10 * size));
		bmpData.applyFilter(bmpData, bmpData.rect, Manager.TAP, new BlurFilter(5, 5));
	}
	
}
