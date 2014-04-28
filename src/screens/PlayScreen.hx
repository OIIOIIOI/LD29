package screens;

import BitmapTile;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.geom.Matrix;
import flash.Lib;
import flash.ui.Keyboard;
import haxe.Timer;
import Player;
import screens.Screen;

/**
 * ...
 * @author 01101101
 */

class PlayScreen extends Screen {
	
	//Spawn offset
	var OFFSET_X:Float;
	var OFFSET_Y:Float;
	// Level
	var level:Level;
	// Display
	var container:Sprite;
	var canvas:Bitmap;
	var canvasData:BitmapData;
	var squareMask:Sprite;
	var light:Light;
	// Entities
	var player:Player;
	var radar:Radar;
	var marks:List<Entity>;
	// Menu
	var menu:IGMenu;
	
	var rot:Float;
	var mat:Matrix;
	
	public function new () {
		super();
		
		Manager.INST.reset();
		
		// Load level
		level = new Level();
		level.load("img/map1.png");
		if (level.spawn == null)	throw new Error('NO SPAWN FOUND');
		OFFSET_X = -level.spawn.x * Manager.SCALE + Manager.SCREEN_SIZE / 2;
		OFFSET_Y = -level.spawn.y * Manager.SCALE + Manager.SCREEN_SIZE / 2;
		
		// Init display
		container = new Sprite();
		container.x = (Lib.current.stage.stageWidth - Manager.SCREEN_SIZE) / 2;
		container.y = (Lib.current.stage.stageHeight - Manager.SCREEN_SIZE) / 2;
		addChild(container);
		canvasData = new BitmapData(Manager.SCREEN_SIZE, Manager.SCREEN_SIZE, false, 0xFF0080FF);
		canvas = new Bitmap(canvasData);
		container.addChild(canvas);
		
		// Matrix stuff
		rot = 3 * Math.PI / 2;
		mat = new Matrix();
		mat.scale(Manager.SCALE, Manager.SCALE);
		mat.translate(OFFSET_X, OFFSET_Y);
		canvasData.draw(level.renderData, mat, null, null, canvasData.rect);
		
		// Display spots soundwaves
		marks = new List();
		for (s in level.spots) {
			if (s.entity != null) {
				container.addChild(s.entity);
				marks.add(s.entity);
			}
		}
		
		// Player
		player = new Player(level.spawn.x, level.spawn.y);
		container.addChild(player);
		marks.add(player);
		// Radar
		radar = new Radar(player.x, player.y);
		container.addChild(radar);
		marks.add(radar);
		
		squareMask = new Sprite();
		squareMask.graphics.beginFill(0x00FF00, 0.9);
		//squareMask.graphics.drawCircle(Manager.SCREEN_SIZE / 2, Manager.SCREEN_SIZE / 2, Manager.SCREEN_SIZE / 2);
		squareMask.graphics.drawRect(0, 0, Manager.SCREEN_SIZE, Manager.SCREEN_SIZE);
		squareMask.graphics.endFill();
		squareMask.x = container.x;
		squareMask.y = container.y;
		container.mask = squareMask;
		
		// Light
		light = new Light();
		light.x = container.x;
		light.y = container.y;
		addChild(light);
		
		// Menu
		menu = new IGMenu(menuHandler);
		addChild(menu);
	}
	
	override public function update () {
		// Rotate and translate world
		var dy:Int = 0;
		var dr:Float = 0;
		
		if (!menu.active && !level.map.active) {
			if (KeyboardMan.INST.getState(Keyboard.UP).isDown)		dy = 2;
			if (KeyboardMan.INST.getState(Keyboard.DOWN).isDown)	dy = -2;
			if (KeyboardMan.INST.getState(Keyboard.LEFT).isDown)	dr = 3 * Math.PI / 180;
			if (KeyboardMan.INST.getState(Keyboard.RIGHT).isDown)	dr = -3 * Math.PI / 180;
		}
		
		// If rotation or movement
		if (dr != 0 || dy != 0) {
			mat.translate(-player.x, -player.y);
		}
		// If rotation
		if (dr != 0) {
			rot += dr;
		}
		// If movement
		if (dy != 0) {
			var tx = dy / Manager.SCALE * Math.cos(rot);
			var ty = dy / Manager.SCALE * Math.sin(rot);
			// If no collision
			if (!level.isSolid(player.mapPos.x - tx, player.mapPos.y + ty)) {
				// Move player and co
				player.mapPos.x = radar.mapPos.x = player.mapPos.x - tx;
				player.mapPos.y = radar.mapPos.y = player.mapPos.y + ty;
				player.moving = true;
				// Apply translation
				mat.translate(0, dy);
				// Update sounds
				level.updateSounds(player.mapPos);
			}
			player.moving = true;
		} else {
			player.moving = false;
		}
		if (dr != 0) {
			mat.rotate(dr);
		}
		if (dr != 0 || dy != 0) {
			mat.translate(player.x, player.y);
			canvasData.draw(level.renderData, mat, null, null, canvasData.rect);
		}
		
		// Reposition entities
		for (m in marks) {
			Manager.TAP.x = m.mapPos.x;
			Manager.TAP.y = m.mapPos.y;
			Manager.TAP = mat.transformPoint(Manager.TAP);
			m.x = Manager.TAP.x;
			m.y = Manager.TAP.y;
			m.update();
		}
		for (b in Manager.INST.beacons) {
			Manager.TAP.x = b.mapPos.x;
			Manager.TAP.y = b.mapPos.y;
			Manager.TAP = mat.transformPoint(Manager.TAP);
			b.x = Manager.TAP.x;
			b.y = Manager.TAP.y;
			b.update();
		}
		
		// Place beacon
		if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			if (!menu.active && !level.map.active) {
				menu.open();
				KeyboardMan.INST.cancelJustPressed(Keyboard.SPACE);
			}
		}
		
		// Update manager
		Manager.INST.update();
		
		light.update();
		
		if (menu.active)	menu.update();
		if (level.map.active)	level.map.update();
	}
	
	function menuHandler (t:TileType) {
		switch (t) {
			case TileType.BeaconButton:
				var b:Beacon;
				// Check if beacon in the vicinity and remove it
				var removed:Bool = false;
				for (b in Manager.INST.beacons) {
					var dx = player.x - b.x;
					var dy = player.y - b.y;
					var distB = Math.sqrt(dx * dx + dy * dy);
					if (distB < 50) {
						container.removeChild(b);
						Manager.INST.beacons.remove(b);
						if (radar.contains(b.arrow))	radar.removeChild(b.arrow);
						removed = true;
						break;
					}
				}
				if (!removed) {
					// Create new one
					b = new Beacon(player.mapPos.x, player.mapPos.y);
					Manager.INST.beacons.add(b);
					container.addChild(b);
					container.addChild(player);
				}
				menu.open(false);
			case TileType.ViewMapButton:
				menu.open(false);
				viewMap();
			case TileType.DigUpButton:
				menu.setState(1);
			case TileType.ConfirmMenuButton:
				menu.open(false);
				digUp();
			case TileType.CloseMenuButton:
				menu.open(false);
			default:
		}
	}
	
	function digUp () {
		player.mapPos.x = (Std.int(player.mapPos.x / Level.GRID_SIZE) + 0.5) * Level.GRID_SIZE;
		player.mapPos.y = (Std.int(player.mapPos.y / Level.GRID_SIZE) + 0.5) * Level.GRID_SIZE;
		Manager.TAP.x = player.mapPos.x;
		Manager.TAP.y = player.mapPos.y;
		Manager.TAP = mat.transformPoint(Manager.TAP);
		player.x = Manager.TAP.x;
		player.y = Manager.TAP.y;
		//
		player.setAnim(PlayerAnim.Dig);
		Timer.delay(digUpEnded, 3000);
	}
	
	function digUpEnded () {
		var p = level.distanceToGoal(player.mapPos.x, player.mapPos.y);
		level.map.showPlayer(level.distanceToGoal(player.mapPos.x, player.mapPos.y, false));
		var anim = PlayerAnim.Lose;
		if (p.x == 0 && p.y == 0) {
			Manager.INST.win = true;
			Manager.INST.perfect = true;
			anim = PlayerAnim.Win;
		} else if (p.x <= 2 && p.y <= 2) {
			Manager.INST.win = true;
			anim = PlayerAnim.Win;
		}
		//
		player.setAnim(anim);
		Timer.delay(digReactionEnded, 2000);
	}
	
	function digReactionEnded () {
		Manager.INST.map = level.map;
		Game.INST.changeScreen(ScreenName.End);
	}
	
	function viewMap () {
		level.map.closedHandler = closeMap;
		addChild(level.map);
		level.map.active = true;
	}
	
	function closeMap () {
		removeChild(level.map);
		level.map.active = false;
	}
	
	override public function destroy () {
		super.destroy();
	}
	
}










