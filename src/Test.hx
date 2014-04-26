package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import openfl.Assets;
import SoundWave;

/**
 * ...
 * @author 01101101
 */

class Test extends Sprite {
	
	public static var INST:Test;
	
	static var SCALE:Int = 3;
	
	static var OFFSET_X:Float;//Spawn offset
	static var OFFSET_Y:Float;
	
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var level:Level;
	
	var player:Entity;
	var halo:Entity;
	var radar:Radar;
	
	var mat:Matrix;
	var marks:List<Entity>;
	var markPoint:Point;
	
	public var beacons(default, null):List<Beacon>;
	
	var rot:Float;
	
	public function new () {
		super();
		
		INST = this;
		
		
		level = new Level();
		level.load("img/level_demo.png");
		
		canvasData = new BitmapData(400, 400, false, 0xFF333333);
		
		//canvas = new Bitmap(canvasData, PixelSnapping.NEVER, true);
		canvas = new Bitmap(canvasData);
		canvas.x = 0;
		canvas.y = 0;
		addChild(canvas);
		
		OFFSET_X = OFFSET_Y = -400;
		
		rot = 3 * Math.PI / 2;
		
		//
		
		marks = new List();
		beacons = new List();
		
		var m:SoundWave;
		for (i in 0...8) {
			m = new SoundWave(Wavetype.BLUE);
			m.mapPos.x = Std.random(400);
			m.mapPos.y = Std.random(400);
			addChild(m);
			marks.add(m);
		}
		
		player = new Entity(200, 200, 0xFF0000, 0.8, 10, true);
		marks.add(player);
		
		halo = new Entity(player.x, player.y, 0xFFFFFF, 0.2, 40, true);
		marks.add(halo);
		
		radar = new Radar(player.x, player.y);
		marks.add(radar);
		
		addChild(halo);
		addChild(player);
		addChild(radar);
		
		//
		
		mat = new Matrix();
		mat.scale(SCALE, SCALE);
		mat.translate(OFFSET_X, OFFSET_Y);
		markPoint = new Point();
		canvasData.draw(level.renderData, mat, null, null, canvasData.rect);
		
		new KeyboardMan();
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		// Rotate and translate world
		mat.translate(-player.x, -player.y);
		var dy:Int = 0;
		var dr:Float = 0;
		if (KeyboardMan.INST.getState(Keyboard.UP).isDown) {
			dy = 2;
		}
		if (KeyboardMan.INST.getState(Keyboard.DOWN).isDown) {
			dy = -2;
		}
		if (KeyboardMan.INST.getState(Keyboard.LEFT).isDown) {
			dr = 3;
		}
		if (KeyboardMan.INST.getState(Keyboard.RIGHT).isDown) {
			dr = -3;
		}
		// Values
		var dist = dy;
		var angle = dr * Math.PI / 180;
		
		// Position player and halo
		rot += angle;
		var tx = dist / SCALE * Math.cos(rot);
		var ty = dist / SCALE * Math.sin(rot);
		if (level.isSolid(player.mapPos.x - tx, player.mapPos.y + ty)) {
			//trace("collision " + Std.random(1000000));
		}
		player.mapPos.x = halo.mapPos.x = radar.mapPos.x = player.mapPos.x - tx;
		player.mapPos.y = halo.mapPos.y = radar.mapPos.y = player.mapPos.y + ty;
		
		// Draw world
		mat.translate(0, dist);
		mat.rotate(angle);
		mat.translate(player.x, player.y);
		canvasData.draw(level.renderData, mat, null, null, canvasData.rect);
		
		// Place beacon
		if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
			var b = new Beacon(player.mapPos.x, player.mapPos.y);
			beacons.add(b);
			addChild(b);
			addChild(player);
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
	}
	
}










