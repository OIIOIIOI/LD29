package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.errors.Error;
//import flash.display.BlendMode;
//import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import openfl.Assets;
import Spot;

/**
 * ...
 * @author 01101101
 */

class Test extends Sprite {
	
	public static var INST:Test;
	
	public static var SCREEN_SIZE:Int = 510;
	
	var OFFSET_X:Float;//Spawn offset
	var OFFSET_Y:Float;
	
	var container:Sprite;
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var level:Level;
	
	var player:Player;
	var radar:Radar;
	var marks:List<Entity>;
	
	var mat:Matrix;
	var markPoint:Point;
	
	var light:Sprite;
	var squareMask:Sprite;
	
	public var beacons(default, null):List<Beacon>;
	
	var rot:Float;
	
	var tick:Float;
	
	public function new () {
		super();
		
		INST = this;
		
		tick = 0;
		
		container = new Sprite();
		addChild(container);
		
		level = new Level();
		level.load("img/level_demo.png");
		
		if (level.spawn == null)	throw new Error('NO SPAWN FOUND');
		
		canvasData = new BitmapData(SCREEN_SIZE, SCREEN_SIZE, false, 0xFF333333);
		
		canvas = new Bitmap(canvasData);
		canvas.x = 0;
		canvas.y = 0;
		container.addChild(canvas);
		
		/*var b = new Bitmap(level.collData);
		b.scaleX = b.scaleY = 8;
		b.x = 400;
		addChild(b);*/
		
		OFFSET_X = -level.spawn.x * Manager.SCALE + SCREEN_SIZE / 2;
		OFFSET_Y = -level.spawn.y * Manager.SCALE + SCREEN_SIZE / 2;
		
		rot = 3 * Math.PI / 2;
		
		//
		
		marks = new List();
		beacons = new List();
		
		// Display spots soundwaves
		for (s in level.spots) {
			if (s.entity != null) {
				container.addChild(s.entity);
				marks.add(s.entity);
			}
		}
		
		// Player
		//player = new Entity(level.spawn.x, level.spawn.y, 0xFF0000, 0.8, 15, true);
		player = new Player(level.spawn.x, level.spawn.y);
		marks.add(player);
		
		radar = new Radar(player.x, player.y);
		marks.add(radar);
		
		container.addChild(player);
		container.addChild(radar);
		
		//
		
		//light = new Light();
		//light.blendMode = BlendMode.OVERLAY;
		//container.addChild(light);
		
		squareMask = new Sprite();
		squareMask.graphics.beginFill(0x00FF00, 0.9);
		squareMask.graphics.drawCircle(SCREEN_SIZE / 2, SCREEN_SIZE / 2, SCREEN_SIZE / 2);
		squareMask.graphics.endFill();
		container.mask = squareMask;
		
		mat = new Matrix();
		mat.scale(Manager.SCALE, Manager.SCALE);
		mat.translate(OFFSET_X, OFFSET_Y);
		markPoint = new Point();
		canvasData.draw(level.renderData, mat, null, null, canvasData.rect);
		
		new KeyboardMan();
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
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
			//if (!level.isSolid(player.mapPos.x - tx, player.mapPos.y + ty, 3)) {
			if (!level.isSolid(player.mapPos.x - tx, player.mapPos.y + ty)) {
				// Move player and co
				player.mapPos.x = radar.mapPos.x = player.mapPos.x - tx;
				player.mapPos.y = radar.mapPos.y = player.mapPos.y + ty;
				player.moving = true;
				// Apply translation
				mat.translate(0, dy);
			}
			/* else {
				var mod:Float = 0;
				var aa = 30 * Math.PI / 180;
				var ttx = 15 / Manager.SCALE * Math.cos(aa);
				var tty = 15 / Manager.SCALE * Math.sin(aa);
				if (!level.isSolid(player.mapPos.x + ttx, player.mapPos.y + tty)) {
					mod = -0.05;
				} else {
					aa = 150 * Math.PI / 180;
					ttx = 15 / Manager.SCALE * Math.cos(aa);
					tty = 15 / Manager.SCALE * Math.sin(aa);
					if (!level.isSolid(player.mapPos.x + ttx, player.mapPos.y + tty)) {
						mod = 0.05;
					}
				}
				rot += mod;
				dr += mod;
			}*/
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
			for (b in beacons) {
				var dx = radar.x - b.x;
				var dy = radar.y - b.y;
				var distB = Math.sqrt(dx * dx + dy * dy);
				if (distB < 50) {
					container.removeChild(b);
					beacons.remove(b);
					removed = true;
					break;
				}
			}
			if (!removed) {
				// Create new one
				b = new Beacon(player.mapPos.x, player.mapPos.y);
				beacons.add(b);
				container.addChild(b);
				container.addChild(player);
			}
		}
		
		// Radar
		radar.update();
		
		// Reposition entities
		for (m in marks) {
			markPoint.x = m.mapPos.x;
			markPoint.y = m.mapPos.y;
			markPoint = mat.transformPoint(markPoint);
			m.x = markPoint.x;
			m.y = markPoint.y;
		}
		for (m in beacons) {
			markPoint.x = m.mapPos.x;
			markPoint.y = m.mapPos.y;
			markPoint = mat.transformPoint(markPoint);
			m.x = markPoint.x;
			m.y = markPoint.y;
		}
		
		// Keyboard Manager
		KeyboardMan.INST.update();
		
		updateMask();
	}
	
	function updateMask () {
		tick += 0.01;
		var r = canvasData.width / 2 - tick;
		if (r <= 70) {
			r = 70;
			return;
		}
		squareMask.graphics.clear();
		squareMask.graphics.beginFill(0x00FF00);
		squareMask.graphics.drawCircle(SCREEN_SIZE / 2, SCREEN_SIZE / 2, SCREEN_SIZE / 2 - tick);
		squareMask.graphics.endFill();
	}
	
}










