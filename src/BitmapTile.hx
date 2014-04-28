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
	
	public function new (type:TileType, source:BitmapData, scale:Float = 1.0) {
		super();
		this.type = type;
		var rect = switch (type) {
			case BeaconButton:		new Rectangle(128, 16, 16, 16);
			case ViewMapButton:		new Rectangle(144, 16, 16, 16);
			case DigUpButton:		new Rectangle(160, 16, 16, 16);
			case CloseMenuButton:	new Rectangle(176, 16, 16, 16);
			case ConfirmMenuButton:	new Rectangle(192, 16, 16, 16);
			//
			case MapChurch:			new Rectangle(0, 0, 141, 148);
			case MapWater:			new Rectangle(141, 0, 118, 148);
			case MapTrain:			new Rectangle(259, 0, 152, 148);
			case MapCows:			new Rectangle(411, 0, 132, 148);
			case MapFactory:		new Rectangle(543, 31, 158, 99);
			case MapGoal:			new Rectangle(700, 31, 87, 99);
			case MapYou:			new Rectangle(787, 14, 94, 115);
			//
			case IconWater:			new Rectangle(1, 17, 8, 14);
			case IconChurch:		new Rectangle(11, 17, 13, 13);
			case IconSawmill:		new Rectangle(77, 17, 14, 13);
			case IconSheep:			new Rectangle(42, 17, 13, 14);
			case IconTrain:			new Rectangle(57, 17, 18, 12);
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
	ConfirmMenuButton;
	//
	MapGoal;
	MapChurch;
	MapCows;
	MapWater;
	MapTrain;
	MapFactory;
	MapYou;
	//
	IconWater;
	IconChurch;
	IconSawmill;
	IconSheep;
	IconTrain;
}










