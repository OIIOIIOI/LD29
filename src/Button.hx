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
	
	public function new (action:Void->Void, ?color:UInt) {
		super();
		
		if (action != null) {
			this.action = action;
			buttonMode = true;
		}
		
		if (color != null) {
			graphics.beginFill(color, 1);
			graphics.drawRect(0, 0, 50, 50);
			graphics.endFill;
		}
		
		addEventListener(MouseEvent.CLICK, clickHandler);
	}
	
	function clickHandler (e:MouseEvent) {
		action();
	}
	
}