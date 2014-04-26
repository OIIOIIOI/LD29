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

class Level {
	
	public static var SCALE:Int = 2;
	
	static var GRID_SIZE:Int = 16;
	static var TILES:BitmapData;
	
	var levelData:BitmapData;
	var renderData:BitmapData;
	public var render:Bitmap;
	
	public function new () {
		if (TILES == null)	TILES = Assets.getBitmapData("img/tiles.png");
	}
	
	public function load (path:String) {
		levelData = Assets.getBitmapData(path);
		renderData = new BitmapData(levelData.width * GRID_SIZE, levelData.height * GRID_SIZE, false, 0xFF33281F);
		renderLevel();
		render = new Bitmap(renderData);
		render.scaleX = render.scaleY = SCALE;
	}
	
	function renderLevel () {
		var r = new Rectangle(0, 0, GRID_SIZE, GRID_SIZE);
		var p = new Point();
		for (y in 0...levelData.height) {
			for (x in 0...levelData.width) {
				if (levelData.getPixel(x, y) == 0xFFFFFF)	r.x = 16 * GRID_SIZE;
				else										r.x = getValue(x, y) * GRID_SIZE;
				p.x = x * GRID_SIZE;
				p.y = y * GRID_SIZE;
				renderData.copyPixels(TILES, r, p);
			}
		}
	}
	
	function getValue (x:Int, y:Int) :Int {
		var n:Int = 0;
		if (levelData.getPixel(x, y - 1) == 0x000000)	n += 1;
		if (levelData.getPixel(x + 1, y) == 0x000000)	n += 2;
		if (levelData.getPixel(x, y + 1) == 0x000000)	n += 4;
		if (levelData.getPixel(x - 1, y) == 0x000000)	n += 8;
		return n;
	}
	
}
