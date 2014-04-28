package ;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import haxe.Timer;
import openfl.Assets;

/**
 * ...
 * @author 01101101
 */
class SoundTest extends Sprite
{
	
	var s:Sound;
	var c:SoundChannel;
	
	var p:Point;
	var r:Int;
	
	public function new() 
	{
		super();
		s = Assets.getSound("snd/water.mp3");
		c = s.play(0, 99);
		
		p = new Point(300, 300);
		r = 200;
		
		var e = new Shape();
		e.graphics.beginFill(0xFFFFFF);
		e.graphics.drawCircle(p.x, p.y, r);
		e.graphics.endFill();
		addChild(e);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		var dx = Lib.current.stage.mouseX - p.x;
		var dy = Lib.current.stage.mouseY - p.y;
		var dist = Math.sqrt(dx * dx + dy * dy);
		var vol = 1 - Math.min(1, dist / r);
		c.soundTransform = new SoundTransform(vol);
	}
	
}














