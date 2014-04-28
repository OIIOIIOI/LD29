package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;
import TreasureMap;

/**
 * ...
 * @author 01101101
 */

class Level {
	
	public static var GRID_SIZE:Int = 16;
	
	public var levelData(default, null):BitmapData;
	public var renderData(default, null):BitmapData;
	
	public var spawn:Point;
	public var goal:Spot;
	public var spots:List<Spot>;
	public var map(default, null):TreasureMap;
	
	//public var collData:BitmapData;
	
	public function new () {
		spots = new List<Spot>();
	}
	
	public function load (path:String) {
		levelData = Assets.getBitmapData(path);
		//collData = levelData.clone();
		renderData = new BitmapData(levelData.width * GRID_SIZE, levelData.height * GRID_SIZE, false, 0xFF33281F);
		renderLevel();
		createMap();
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
				var tx = radius / Manager.SCALE * Math.cos(angle);
				var ty = radius / Manager.SCALE * Math.sin(angle);
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
		var col:UInt;
		for (y in 0...levelData.height) {
			for (x in 0...levelData.width) {
				v = 17;// Default to walkable tile
				col = levelData.getPixel(x, y);
				switch (col) {
					// Metadatas
					case 0x00FF00:
						spawn = new Point((x + 0.5) * GRID_SIZE, (y + 0.5) * GRID_SIZE);
					case 0xFF0000:
						goal = new Spot(col, x, y);
					case 0x0000FF, 0x3333FF, 0x6666FF, 0x9999FF, 0xCCCCFF:
						spots.add(new Spot(col, x, y));
					// Regular terrain
					case 0xFFFFFF:
						if (Std.random(8) == 0)	v = 18 + Std.random(3);
					default:
						v = getValue(x, y);// Wall
				}
				// Copy pixels
				r.x = v * GRID_SIZE;
				p.x = x * GRID_SIZE;
				p.y = y * GRID_SIZE;
				renderData.copyPixels(Game.TILES, r, p);
				//
				if (v == 15) {
					if (levelData.getPixel(x - 1, y - 1) == 0xFFFFFF) {
						r2.x = 16 * GRID_SIZE;
						r2.y = 0;
						p.x = x * GRID_SIZE;
						p.y = y * GRID_SIZE;
						renderData.copyPixels(Game.TILES, r2, p);
					}
					if (levelData.getPixel(x + 1, y - 1) == 0xFFFFFF) {
						r2.x = 16.5 * GRID_SIZE;
						r2.y = 0;
						p.x = (x + 0.5) * GRID_SIZE;
						p.y = y * GRID_SIZE;
						renderData.copyPixels(Game.TILES, r2, p);
					}
					if (levelData.getPixel(x - 1, y + 1) == 0xFFFFFF) {
						r2.x = 16 * GRID_SIZE;
						r2.y = 0.5 * GRID_SIZE;
						p.x = x * GRID_SIZE;
						p.y = (y + 0.5) * GRID_SIZE;
						renderData.copyPixels(Game.TILES, r2, p);
					}
					if (levelData.getPixel(x + 1, y + 1) == 0xFFFFFF) {
						r2.x = 16.5 * GRID_SIZE;
						r2.y = 0.5 * GRID_SIZE;
						p.x = (x + 0.5) * GRID_SIZE;
						p.y = (y + 0.5) * GRID_SIZE;
						renderData.copyPixels(Game.TILES, r2, p);
					}
				}
			}
		}
	}
	
	function createMap () {
		map = new TreasureMap(goal, spots);
	}
	
	function getValue (x:Int, y:Int) :Int {
		var n:Int = 0;
		if (levelData.getPixel(x, y - 1) == 0x000000)	n += 1;
		if (levelData.getPixel(x + 1, y) == 0x000000)	n += 2;
		if (levelData.getPixel(x, y + 1) == 0x000000)	n += 4;
		if (levelData.getPixel(x - 1, y) == 0x000000)	n += 8;
		return n;
	}
	
	public function distanceToGoal (x:Float, y:Float, abs:Bool = true) :Point {
		var xx = Std.int(x / GRID_SIZE);
		var yy = Std.int(y / GRID_SIZE);
		var dx:Float = xx - goal.cellX;
		var dy:Float = yy - goal.cellY;
		if (abs) {
			dx = Math.abs(dx);
			dy = Math.abs(dy);
		}
		return new Point(dx, dy);
	}
	
}
