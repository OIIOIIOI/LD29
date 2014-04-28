package ;

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
	var container:Sprite;
	
	var goalItem:BitmapTile;
	
	var difficulty:Int;
	var minX:Int;
	var maxX:Int;
	var minY:Int;
	var maxY:Int;
	var space:Int;
	
	var scale:Float;
	
	public var active:Bool;
	
	public var closedHandler:Void->Void;
	
	public function new (goal:Spot, list:List<Spot>) {
		super();
		if (ITEMS == null)	ITEMS = Assets.getBitmapData("img/map_items.png");
		
		active = false;
		
		difficulty = 0;
		scale = 0.5;
		
		this.goal = goal;
		
		// Sort spots
		spots = new Array();
		for (s in list) {
			spots.push(s);
		}
		spots.sort(sortOnDistance);
		
		// Background
		addChild(new Bitmap(Assets.getBitmapData("img/map_bg.jpg")));//500 wide in the middle, free for use
		
		// Spots
		container = new Sprite();
		minX = goal.cellX;
		maxX = goal.cellX;
		minY = goal.cellY;
		maxY = goal.cellY;
		//for (i in difficulty...(difficulty + 4)) {
		for (i in 0...spots.length) {
			// Min/max
			minX = Std.int(Math.min(minX, spots[i].cellX));
			maxX = Std.int(Math.max(maxX, spots[i].cellX));
			minY = Std.int(Math.min(minY, spots[i].cellY));
			maxY = Std.int(Math.max(maxY, spots[i].cellY));
		}
		//
		maxX -= minX;
		maxY -= minY;
		space = Std.int(Math.max(maxX, maxY));
		space = Std.int(400 / space);
		// TODO: should be possible to detect if exit is off the map by reverting maxX, maxY and checking against them
		//
		var spotItem:BitmapTile;
		//for (i in difficulty...(difficulty + 4)) {
		for (i in 0...spots.length) {
			// Display spot
			spotItem = switch (spots[i].type) {
				case SpotType.Church:	new BitmapTile(TileType.MapChurch, ITEMS, scale);
				case SpotType.Sawmill:	new BitmapTile(TileType.MapFactory, ITEMS, scale);
				case SpotType.Water:	new BitmapTile(TileType.MapWater, ITEMS, scale);
				case SpotType.Sheep:	new BitmapTile(TileType.MapCows, ITEMS, scale);
				case SpotType.Train:	new BitmapTile(TileType.MapTrain, ITEMS, scale);
				default: 				null;
			}
			if (spotItem != null) {
				spotItem.x = (spots[i].cellX - minX) * space - spotItem.width / 2;
				spotItem.y = (spots[i].cellY - minY) * space - spotItem.height / 2;
				container.addChild(spotItem);
			}
		}
		//
		goalItem = new BitmapTile(TileType.MapGoal, ITEMS, scale);
		goalItem.x = (goal.cellX - minX) * space - goalItem.width / 2;
		goalItem.y = (goal.cellY - minY) * space - goalItem.height / 2;
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
	
	public function showPlayer (p:Point) {
		var item = new BitmapTile(TileType.MapYou, ITEMS, scale);
		item.x = (goal.cellX + p.x - minX) * space - item.width / 2;
		item.y = (goal.cellY + p.y - minY) * space - item.height / 2;
		container.addChild(item);
		goalItem.alpha = 0.5;
	}
	
	public function destroy () {
		// TODO
	}
	
}










