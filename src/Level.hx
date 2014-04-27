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
	
	static var GRID_SIZE:Int = 16;
	static var TILES:BitmapData;
	
	public var levelData(default, null):BitmapData;
	public var renderData(default, null):BitmapData;
	
	//public var collData:BitmapData;
	
	public function new () {
		if (TILES == null)	TILES = Assets.getBitmapData("img/tiles.png");
		//if (TILES == null)	TILES = Assets.getBitmapData("img/tiles_base.png");
	}
	
	public function load (path:String) {
		levelData = Assets.getBitmapData(path);
		//collData = levelData.clone();
		renderData = new BitmapData(levelData.width * GRID_SIZE, levelData.height * GRID_SIZE, false, 0xFF33281F);
		renderLevel();
	}
	
	public function isSolid (x:Float, y:Float, radius:Int = 0) :Bool {
		var xx = Std.int(x / GRID_SIZE);
		var yy = Std.int(y / GRID_SIZE);
		if (radius == 0) {
			if (levelData.getPixel(xx, yy) == 0x000000) {
				//collData.setPixel(xx, yy, 0xFF0000);
				return true;
			}
		} else {
			for (i in 0...6) {
				var angle = i * 2 * Math.PI / 6;
				var tx = radius / Test.SCALE * Math.cos(angle);
				var ty = radius / Test.SCALE * Math.sin(angle);
				if (isSolid(x + tx, y + ty))	return true;
			}
		}
		return false;
	}
	
	function renderLevel () {
		var r = new Rectangle(0, 0, GRID_SIZE, GRID_SIZE);
		var r2 = new Rectangle(0, 0, GRID_SIZE / 2, GRID_SIZE / 2);
		var p = new Point();
		var v:Int = 0;
		for (y in 0...levelData.height) {
			for (x in 0...levelData.width) {
				if (levelData.getPixel(x, y) == 0xFFFFFF)	v = 17;
				else										v = getValue(x, y);
				r.x = v * GRID_SIZE;
				p.x = x * GRID_SIZE;
				p.y = y * GRID_SIZE;
				renderData.copyPixels(TILES, r, p);
				//
				if (v == 15) {
					if (levelData.getPixel(x - 1, y - 1) == 0xFFFFFF) {
						r2.x = 16 * GRID_SIZE;
						r2.y = 0;
						p.x = x * GRID_SIZE;
						p.y = y * GRID_SIZE;
						renderData.copyPixels(TILES, r2, p);
					}
					if (levelData.getPixel(x + 1, y - 1) == 0xFFFFFF) {
						r2.x = 16.5 * GRID_SIZE;
						r2.y = 0;
						p.x = (x + 0.5) * GRID_SIZE;
						p.y = y * GRID_SIZE;
						renderData.copyPixels(TILES, r2, p);
					}
					if (levelData.getPixel(x - 1, y + 1) == 0xFFFFFF) {
						r2.x = 16 * GRID_SIZE;
						r2.y = 0.5 * GRID_SIZE;
						p.x = x * GRID_SIZE;
						p.y = (y + 0.5) * GRID_SIZE;
						renderData.copyPixels(TILES, r2, p);
					}
					if (levelData.getPixel(x + 1, y + 1) == 0xFFFFFF) {
						r2.x = 16.5 * GRID_SIZE;
						r2.y = 0.5 * GRID_SIZE;
						p.x = (x + 0.5) * GRID_SIZE;
						p.y = (y + 0.5) * GRID_SIZE;
						renderData.copyPixels(TILES, r2, p);
					}
				}
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
