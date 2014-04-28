package screens;

import BitmapTile;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.Lib;
import flash.ui.Keyboard;
import openfl.Assets;
import Spot;

/**
 * ...
 * @author 01101101
 */

class TreasureMap extends Sprite {
	
	public static var ITEMS:BitmapData;
	
	var goal:Spot;
	var spots:Array<Spot>;
	
	var difficulty:Int;
	
	public var active:Bool;
	
	public var closedHandler:Void->Void;
	
	public function new (goal:Spot, list:List<Spot>) {
		super();
		if (ITEMS == null)	ITEMS = Assets.getBitmapData("img/map_items.png");
		
		active = false;
		
		difficulty = 0;
		
		this.goal = goal;
		
		// Sort spots
		spots = new Array();
		for (s in list) {
			spots.push(s);
		}
		spots.sort(sortOnDistance);
		
		// Background
		addChild(new Bitmap(Assets.getBitmapData("img/map_bg.jpg")));//500 wide in the middle, free for use
		// Goal
		var container = new Sprite();
		// Spots
		var minX:Int = goal.cellX;
		var maxX:Int = goal.cellX;
		var minY:Int = goal.cellY;
		var maxY:Int = goal.cellY;
		for (i in difficulty...(difficulty + 4)) {
			// Min/max
			minX = Std.int(Math.min(minX, spots[i].cellX));
			maxX = Std.int(Math.max(maxX, spots[i].cellX));
			minY = Std.int(Math.min(minY, spots[i].cellY));
			maxY = Std.int(Math.max(maxY, spots[i].cellY));
		}
		//
		maxX -= minX;
		maxY -= minY;
		var div = Std.int(Math.max(maxX, maxY));
		div = Std.int(440 / div);
		//
		var spotItem:BitmapTile;
		for (i in difficulty...(difficulty + 4)) {
			// Display spot
			spotItem = switch (spots[i].type) {
				case SpotType.Church:	new BitmapTile(TileType.MapChurch, ITEMS);
				case SpotType.Sawmill:	new BitmapTile(TileType.MapFactory, ITEMS);
				case SpotType.Water:	new BitmapTile(TileType.MapWater, ITEMS);
				case SpotType.Sheep:	new BitmapTile(TileType.MapCows, ITEMS);
				case SpotType.Train:	new BitmapTile(TileType.MapTrain, ITEMS);
				default: 				null;
			}
			if (spotItem != null) {
				spotItem.x = (spots[i].cellX - minX) * div;
				spotItem.y = (spots[i].cellY - minY) * div;
				container.addChild(spotItem);
			}
		}
		//
		var goalItem = new BitmapTile(TileType.MapGoal, ITEMS);
		goalItem.x = (goal.cellX - minX) * div;
		goalItem.y = (goal.cellY - minY) * div;
		container.addChild(goalItem);
		//
		container.x = (Lib.current.stage.stageWidth - container.width) / 2;
		container.y = (Lib.current.stage.stageHeight - container.height) / 2;
		addChild(container);
	}
	
	function sortOnDistance (a:Spot, b:Spot) :Int {
		if (a.distToGoal == 0) {
			var dxa = goal.cellX - a.cellX;
			var dya = goal.cellY - a.cellY;
			var da = Math.sqrt(dxa * dxa + dya * dya);
			a.distToGoal = da;
		}
		if (b.distToGoal == 0) {
			var dxb = goal.cellX - b.cellX;
			var dyb = goal.cellY - b.cellY;
			var db = Math.sqrt(dxb * dxb + dyb * dyb);
			b.distToGoal = db;
		}
		if (a.distToGoal == b.distToGoal)		return 0;
		else if (a.distToGoal > b.distToGoal)	return 1;
		else									return -1;
	}
	
	public function update () {
		if (active && closedHandler != null && KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			closedHandler();
		}
	}
	
}










