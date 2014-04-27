package screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.geom.Matrix;
import flash.ui.Keyboard;

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
	var lightMask:Sprite;
	var light:Light;
	// Entities
	var player:Player;
	var radar:Radar;
	var marks:List<Entity>;
	
	var rot:Float;
	var mat:Matrix;
	
	public function new () {
		super();
		
		// Init gloal manager
		Manager.init();
		// Init keyboard manager
		KeyboardMan.init();
		
		// Load level
		level = new Level();
		level.load("img/level_demo.png");
		if (level.spawn == null)	throw new Error('NO SPAWN FOUND');
		OFFSET_X = -level.spawn.x * Manager.SCALE + Manager.SCREEN_SIZE / 2;
		OFFSET_Y = -level.spawn.y * Manager.SCALE + Manager.SCREEN_SIZE / 2;
		
		// Init display
		container = new Sprite();
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
		
		lightMask = new Sprite();
		lightMask.graphics.beginFill(0x00FF00, 0.9);
		//lightMask.graphics.drawCircle(Manager.SCREEN_SIZE / 2, Manager.SCREEN_SIZE / 2, Manager.SCREEN_SIZE / 2);
		lightMask.graphics.drawRect(0, 0, Manager.SCREEN_SIZE, Manager.SCREEN_SIZE);
		lightMask.graphics.endFill();
		container.mask = lightMask;
		
		light = new Light();
		light.x = container.x;
		light.y = container.y;
		addChild(light);
	}
	
	override public function update () {
		// Rotate and translate world
		var dy:Int = 0;
		var dr:Float = 0;
		if (KeyboardMan.INST.getState(Keyboard.UP).isDown)		dy = 2;
		if (KeyboardMan.INST.getState(Keyboard.DOWN).isDown)	dy = -2;
		if (KeyboardMan.INST.getState(Keyboard.LEFT).isDown)	dr = 3 * Math.PI / 180;
		if (KeyboardMan.INST.getState(Keyboard.RIGHT).isDown)	dr = -3 * Math.PI / 180;
		
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
		
		// Animated entities
		player.update();
		
		// Place beacon
		if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			var b:Beacon;
			// Check if beacon in the vicinity and remove it
			var removed:Bool = false;
			for (b in Manager.INST.beacons) {
				var dx = radar.x - b.x;
				var dy = radar.y - b.y;
				var distB = Math.sqrt(dx * dx + dy * dy);
				if (distB < 50) {
					container.removeChild(b);
					Manager.INST.beacons.remove(b);
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
		}
		
		// Reposition entities
		for (m in marks) {
			Manager.TAP.x = m.mapPos.x;
			Manager.TAP.y = m.mapPos.y;
			Manager.TAP = mat.transformPoint(Manager.TAP);
			m.x = Manager.TAP.x;
			m.y = Manager.TAP.y;
		}
		for (b in Manager.INST.beacons) {
			Manager.TAP.x = b.mapPos.x;
			Manager.TAP.y = b.mapPos.y;
			Manager.TAP = mat.transformPoint(Manager.TAP);
			b.x = Manager.TAP.x;
			b.y = Manager.TAP.y;
			b.update();
		}
		
		// Radar
		radar.update();
		
		// Update managers
		Manager.INST.update();
		KeyboardMan.INST.update();
	}
	
	override public function destroy () {
		super.destroy();
		Manager.INST.destroy();
	}
	
}
