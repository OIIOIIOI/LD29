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
	
	public function new (type:TileType) {
		super();
		this.type = type;
		var rect = switch (type) {
			case BeaconButton:		new Rectangle(128, 16, 16, 16);
			case ViewMapButton:		new Rectangle(144, 16, 16, 16);
			case DigUpButton:		new Rectangle(160, 16, 16, 16);
			case CloseMenuButton:	new Rectangle(176, 16, 16, 16);
		}
		bitmapData = new BitmapData(Std.int(rect.width), Std.int(rect.height), true, 0x00FF00FF);
		Manager.TAP.setTo(0, 0);
		bitmapData.copyPixels(Game.TILES, rect, Manager.TAP);
		scaleX = scaleY = 3;
	}
	
	/*public function switchType (type:TileType) {
		this.type = type;
		var rect = switch (type) {
			case BeaconButton:		new Rectangle(128, 16, 16, 16);
			case ViewMapButton:		new Rectangle(144, 16, 16, 16);
			case DigUpButton:		new Rectangle(160, 16, 16, 16);
			case CloseMenuButton:	new Rectangle(176, 16, 16, 16);
		}
		bitmapData.fillRect(bitmapData.rect, 0x00FF00FF);
		Manager.TAP.setTo(0, 0);
		bitmapData.copyPixels(Game.TILES, rect, Manager.TAP);
	}*/
	
}

enum TileType {
	BeaconButton;
	ViewMapButton;
	DigUpButton;
	CloseMenuButton;
}