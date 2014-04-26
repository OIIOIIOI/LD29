package ;
import flash.display.Sprite;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author ...
 */
class TestBtn extends Sprite
{

	public function new(color:UInt, X:Int , Y:Int, action:MouseEvent->Void)
	{
		super();
		graphics.beginFill(color, 1);
		graphics.drawRect(X, Y, 20, 20);
		graphics.endFill;
		addEventListener(MouseEvent.CLICK, action);
	}
	
}