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
	
	public static var SCALE:Int = 3;
	
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
		renderData = new BitmapData((levelData.width + 12) * GRID_SIZE, (levelData.height + 12) * GRID_SIZE, false, 0xFFCC00CC);
		renderLevel();
		render = new Bitmap(renderData);
		render.scaleX = render.scaleY = SCALE;
	}
	
	function renderLevel () {
		var r = new Rectangle(0, 0, GRID_SIZE, GRID_SIZE);
		var p = new Point();
		for (y in 0...levelData.height) {
			for (x in 0...levelData.width) {
				if (levelData.getPixel(x, y) == 0xFFFFFF)	r.x = 0;
				else										r.x = 4 * GRID_SIZE;
				p.x = x * GRID_SIZE;
				p.y = y * GRID_SIZE;
				renderData.copyPixels(TILES, r, p);
			}
		}
	}
	
}
