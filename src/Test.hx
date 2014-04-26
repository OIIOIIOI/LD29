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
	
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var mapData:BitmapData;
	
	var player:Sprite;
	
	var mat:Matrix;
	var markMat:Matrix;
	var marks:List<Sprite>;
	var markPoint:Point;
	
	public function new () {
		super();
		
		mapData = Assets.getBitmapData("img/map2.png");
		
		canvasData = new BitmapData(400, 400, false, 0xFF333333);
		
		canvas = new Bitmap(canvasData);
		canvas.x = 0;
		canvas.y = 0;
		//canvas.scaleX = canvas.scaleY = 6;
		addChild(canvas);
		
		player = new Sprite();
		player.graphics.beginFill(0xFF0000, 0.8);
		player.graphics.drawCircle(0, 0, 10);
		player.graphics.endFill();
		player.x = 200;
		player.y = 200;
		addChild(player);
		
		marks = new List();
		
		var m:Sprite;
		for (i in 0...8) {
			m = new Sprite();
			m.graphics.beginFill(0x00FF00, 0.8);
			m.graphics.drawCircle(0, 0, 20);
			m.graphics.endFill();
			m.x = Std.random(800) + 400;
			m.y = Std.random(800) + 400;
			addChild(m);
			marks.push(m);
		}
		
		mat = new Matrix();
		mat.scale(SCALE, SCALE);
		markMat = new Matrix();
		markMat.scale(SCALE, SCALE);
		markPoint = new Point();
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
			dr = 2;
		}
		if (KeyboardMan.INST.isDown(Keyboard.RIGHT)) {
			dr = -2;
		}
		mat.translate(0, dy * 3);
		mat.rotate(dr * Math.PI / 180);
		mat.translate(200, 200);
		// Draw world
		canvasData.draw(mapData, mat, null, null, new Rectangle(0, 0, 400, 400));
		// Reposition entities
		for (m in marks) {
			markPoint.x = m.x;
			markPoint.y = m.y;
			markMat.identity();
			markMat.translate( -200, -200);
			markMat.translate(0, dy * 3);
			markMat.rotate(dr * Math.PI / 180);
			markMat.translate(200, 200);
			markPoint = markMat.transformPoint(markPoint);
			m.x = markPoint.x;
			m.y = markPoint.y;
		}
	}
	
}










