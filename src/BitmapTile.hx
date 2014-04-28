package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

class BitmapTile extends Bitmap {
	
	public var type(default, null):TileType;
	
	public function new (type:TileType, source:BitmapData, scale:Int = 1) {
		super();
		this.type = type;
		var rect = switch (type) {
			case BeaconButton:		new Rectangle(128, 16, 16, 16);
			case ViewMapButton:		new Rectangle(144, 16, 16, 16);
			case DigUpButton:		new Rectangle(160, 16, 16, 16);
			case CloseMenuButton:	new Rectangle(176, 16, 16, 16);
			//
			case MapGoal:			new Rectangle(0, 0, 97, 50);
			case MapChurch:			new Rectangle(97, 0, 25, 50);
			case MapCows:			new Rectangle(122, 0, 21, 50);
			case MapWater:			new Rectangle(143, 0, 20, 50);
			case MapTrain:			new Rectangle(163, 0, 21, 50);
			case MapFactory:		new Rectangle(184, 0, 23, 50);
		}
		bitmapData = new BitmapData(Std.int(rect.width), Std.int(rect.height), true, 0x00FF00FF);
		Manager.TAP.setTo(0, 0);
		bitmapData.copyPixels(source, rect, Manager.TAP);
		scaleX = scaleY = scale;
	}
	
}

enum TileType {
	BeaconButton;
	ViewMapButton;
	DigUpButton;
	CloseMenuButton;
	//
	MapGoal;
	MapChurch;
	MapCows;
	MapWater;
	MapTrain;
	MapFactory;
}










