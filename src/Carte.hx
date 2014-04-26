package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.Lib;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Carte extends Sprite
{
	var mapData :BitmapData;
	var mapBitmap: Bitmap;
	
	public function new(filePath:String) 
	{
		super();
		mapData = Assets.getBitmapData(filePath);
		mapBitmap = new Bitmap(mapData);
		graphics.beginFill(0x888888, 0.7);
		graphics.drawRect(0, 0, Lib.current.stage.width, Lib.current.stage.height);
		graphics.endFill;
		addChild(mapBitmap);
		mapBitmap.x = 20;
		mapBitmap.y = 20;
	}
	
}