package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import openfl.Assets;

/**
 * ...
 * @author 01101101
 */

class Test extends Sprite {
	
	static var SCALE:Int = 3;
	
	static var OFFSET_X:Float;//Spawn offset
	static var OFFSET_Y:Float;
	
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var mapData:BitmapData;
	
	var player:Entity;
	var halo:Entity;
	
	var mat:Matrix;
	var marks:List<Entity>;
	var markPoint:Point;
	
	var rot:Float;
	
	public function new () {
		super();
		
		mapData = Assets.getBitmapData("img/map2.png");
		
		canvasData = new BitmapData(400, 400, false, 0xFF333333);
		
		canvas = new Bitmap(canvasData);
		canvas.x = 0;
		canvas.y = 0;
		addChild(canvas);
		
		OFFSET_X = OFFSET_Y = -400;
		
		rot = 3 * Math.PI / 2;//Useful?
		
		//
		
		marks = new List();
		
		var m:SoundWave;
		for (i in 0...8) {
			m = new SoundWave("ok", 50, 10, 0, 0);
			m.mapPos.x = Std.random(400);
			m.mapPos.y = Std.random(400);
			addChild(m);
			marks.push(m);
		}
		
		player = new Entity(200, 200, 0xFF0000, 0.8, 10, true);
		marks.push(player);
		
		halo = new Entity(player.x, player.y, 0xFFFFFF, 0.2, 40, true);
		marks.push(halo);
		
		addChild(halo);
		addChild(player);
		
		//
		
		mat = new Matrix();
		mat.scale(SCALE, SCALE);
		mat.translate(OFFSET_X, OFFSET_Y);
		markPoint = new Point();
		canvasData.draw(mapData, mat, null, null, canvasData.rect);
		
		new KeyboardMan();
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		
		var startP = mat.transformPoint(new Point());
		
		// Rotate and translate world
		mat.translate(-player.x, -player.y);
		var dy:Int = 0;
		var dr:Float = 0;
		if (KeyboardMan.INST.isDown(Keyboard.UP)) {
			dy = 1;
		}
		if (KeyboardMan.INST.isDown(Keyboard.DOWN)) {
			dy = -1;
		}
		if (KeyboardMan.INST.isDown(Keyboard.LEFT)) {
			dr = 1.5;
		}
		if (KeyboardMan.INST.isDown(Keyboard.RIGHT)) {
			dr = -1.5;
		}
		var dist = dy * 3;
		var angle = dr * Math.PI / 180;
		
		mat.translate(0, dist);
		mat.rotate(angle);
		mat.translate(player.x, player.y);
		
		// Position player and halo
		rot += angle;
		
		var tx = dist / SCALE * Math.cos(rot);
		var ty = dist / SCALE * Math.sin(rot);
		player.mapPos.x = halo.mapPos.x = player.mapPos.x - tx;
		player.mapPos.y = halo.mapPos.y = player.mapPos.y + ty;
		
		//mapData.setPixel(Std.int(player.mapPos.x), Std.int(player.mapPos.y), 0xFFFFFF);
		
		// Draw world
		canvasData.draw(mapData, mat, null, null, canvasData.rect);
		
		// Reposition entities
		for (m in marks) {
			markPoint.x = m.mapPos.x;
			markPoint.y = m.mapPos.y;
			markPoint = mat.transformPoint(markPoint);
			m.x = markPoint.x;
			m.y = markPoint.y;
		}
	}
	
}










