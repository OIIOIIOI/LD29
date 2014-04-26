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
	
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var mapData:BitmapData;
	
	var player:Sprite;
	var mark:Sprite;
	
	var mat:Matrix;
	
	public function new () {
		super();
		
		mapData = Assets.getBitmapData("img/map.png");
		
		canvasData = new BitmapData(400, 400, false, 0xFF333333);
		
		canvas = new Bitmap(canvasData);
		canvas.x = 0;
		canvas.y = 0;
		addChild(canvas);
		
		player = new Sprite();
		player.graphics.beginFill(0xFF0000, 0.2);
		player.graphics.drawCircle(0, 0, 10);
		player.graphics.endFill();
		player.x = 200;
		player.y = 200;
		addChild(player);
		
		mark = new Sprite();
		mark.graphics.beginFill(0x00FF00, 0.8);
		mark.graphics.drawCircle(0, 0, 20);
		mark.graphics.endFill();
		mark.x = 0;
		mark.y = 0;
		addChild(mark);
		
		mat = new Matrix();
		canvasData.draw(mapData, mat, null, null, new Rectangle(0, 0, 400, 400));
		
		new KeyboardMan();
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		// Rotate and translate world
		mat.translate( -200, -200);
		var dy:Int = 0;
		var dr:Int = 0;
		if (KeyboardMan.INST.isDown(Keyboard.UP)) {
			dy = 1;
		}
		if (KeyboardMan.INST.isDown(Keyboard.DOWN)) {
			dy = -1;
		}
		if (KeyboardMan.INST.isDown(Keyboard.LEFT)) {
			dr = 1;
		}
		if (KeyboardMan.INST.isDown(Keyboard.RIGHT)) {
			dr = -1;
		}
		mat.translate(0, dy * 3);
		mat.rotate(dr * Math.PI / 180);
		mat.translate(200, 200);
		// Draw world
		canvasData.draw(mapData, mat, null, null, new Rectangle(0, 0, 400, 400));
		// Reposition entities
		
	}
	
}










