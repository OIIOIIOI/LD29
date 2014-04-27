package ;

import BitmapTile;
import flash.display.Sprite;
import flash.Lib;
import flash.ui.Keyboard;

/**
 * ...
 * @author 01101101
 */

class IGMenu extends Sprite {
	
	var handler:TileType-> Void;
	
	var container:Sprite;
	var leftButton:BitmapTile;
	var upButton:BitmapTile;
	var rightButton:BitmapTile;
	var downButton:BitmapTile;
	
	public var active(default, null):Bool;
	
	public function new (h:TileType->Void) {
		super();
		
		handler = h;
		
		container = new Sprite();
		container.graphics.beginFill(0x000000, 0.4);
		container.graphics.drawRect(-Lib.current.stage.stageWidth / 2, -Lib.current.stage.stageHeight / 2, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		container.graphics.endFill();
		
		container.x = Lib.current.stage.stageWidth / 2;
		container.y = Lib.current.stage.stageHeight / 2;
		
		var space = 36;
		
		leftButton = new BitmapTile(TileType.PlaceBeaconButton);
		leftButton.x = -leftButton.width - space;
		leftButton.y = -leftButton.height / 2;
		container.addChild(leftButton);
		
		upButton = new BitmapTile(TileType.DigUpButton);
		upButton.x = -upButton.width / 2;
		upButton.y = -upButton.height - space;
		container.addChild(upButton);
		
		rightButton = new BitmapTile(TileType.ViewMapButton);
		rightButton.x = space;
		rightButton.y = -rightButton.height / 2;
		container.addChild(rightButton);
		
		downButton = new BitmapTile(TileType.CloseMenuButton);
		downButton.x = -downButton.width / 2;
		downButton.y = space;
		container.addChild(downButton);
		
		active = false;
	}
	
	public function open (v:Bool = true) {
		if (v)	addChild(container);
		else {
			removeChild(container);
			KeyboardMan.INST.resetState();
		}
		active = v;
	}
	
	public function update () {
		if (active) {
			if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed ||
				KeyboardMan.INST.getState(Keyboard.DOWN).justPressed) {
				open(false);
			}
			else if (KeyboardMan.INST.getState(Keyboard.LEFT).justPressed) {
				trace("beacon");
				handler(leftButton.type);
				open(false);
			}
			else if (KeyboardMan.INST.getState(Keyboard.UP).justPressed) {
				trace("dig up");
				handler(upButton.type);
				open(false);
			}
			else if (KeyboardMan.INST.getState(Keyboard.RIGHT).justPressed) {
				trace("map");
				handler(rightButton.type);
				open(false);
			}
		}
	}
	
}










