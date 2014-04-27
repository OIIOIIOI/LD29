package ;

import flash.display.Sprite;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author ...
 */

class Button extends Sprite {
	
	public var action:Void->Void;
	
	public function new (action:Void->Void, ?color:UInt, alpha:Float = 1, w:Int = 50, h:Int = 50) {
		super();
		
		if (action != null) {
			this.action = action;
			buttonMode = true;
		}
		
		if (color != null) {
			graphics.beginFill(color, alpha);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill;
		}
		
		addEventListener(MouseEvent.CLICK, clickHandler);
	}
	
	function clickHandler (e:MouseEvent) {
		action();
	}
	
	public function destroy () {
		removeEventListener(MouseEvent.CLICK, clickHandler);
		action = null;
	}
	
}