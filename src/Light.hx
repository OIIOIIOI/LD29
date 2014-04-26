package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */

class Light extends Sprite {
	
	var bmpData:BitmapData;
	var bmp:Bitmap;
	
	public function new () {
		super();
		
		var c:Shape = new Shape();
		c.graphics.beginFill(0x000011);
		c.graphics.drawRect(0, 0, 100, 100);
		c.graphics.endFill();
		c.graphics.beginFill(0xFFFFFF);
		c.graphics.drawCircle(50, 50, 20);
		c.graphics.endFill();
		
		bmpData = new BitmapData(100, 100, true, 0x00000000);
		bmpData.draw(c);
		bmpData.applyFilter(bmpData, bmpData.rect, new Point(), new BlurFilter(30, 30));
		
		c.graphics.clear();
		c.graphics.beginFill(0xFFFFFF);
		c.graphics.drawCircle(50, 50, 20);
		c.graphics.endFill();
		bmpData.draw(c);
		bmpData.applyFilter(bmpData, bmpData.rect, new Point(), new BlurFilter(30, 30));
		
		bmp = new Bitmap(bmpData);
		bmp.scaleX = bmp.scaleY = 4;
		
		addChild(bmp);
	}
	
}
