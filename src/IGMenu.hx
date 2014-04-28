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
	
	var space:Int;
	
	public var active(default, null):Bool;
	
	public function new (h:TileType->Void) {
		super();
		
		handler = h;
		
		container = new Sprite();
		container.graphics.beginFill(0x000000, 0.2);
		container.graphics.drawRect(-Lib.current.stage.stageWidth / 2, -Lib.current.stage.stageHeight / 2, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		container.graphics.endFill();
		
		container.x = Lib.current.stage.stageWidth / 2;
		container.y = Lib.current.stage.stageHeight / 2;
		
		space = 36;
		
		active = false;
	}
	
	public function open (v:Bool = true) {
		if (v) {
			setState(0);
			addChild(container);
		}
		else {
			removeChild(container);
			KeyboardMan.INST.resetState();
		}
		active = v;
	}
	
	public function setState (s:Int = 0) {
		// Clear
		if (leftButton != null && container.contains(leftButton))	container.removeChild(leftButton);
		if (upButton != null && container.contains(upButton))		container.removeChild(upButton);
		if (rightButton != null && container.contains(rightButton))	container.removeChild(rightButton);
		if (downButton != null && container.contains(downButton))	container.removeChild(downButton);
		// Setup
		if (s == 0) {
			leftButton = new BitmapTile(TileType.BeaconButton, Game.TILES, 3);
			leftButton.x = -leftButton.width - space;
			leftButton.y = -leftButton.height / 2;
			container.addChild(leftButton);
			
			upButton = new BitmapTile(TileType.DigUpButton, Game.TILES, 3);
			upButton.x = -upButton.width / 2;
			upButton.y = -upButton.height - space;
			container.addChild(upButton);
			
			rightButton = new BitmapTile(TileType.ViewMapButton, Game.TILES, 3);
			rightButton.x = space;
			rightButton.y = -rightButton.height / 2;
			container.addChild(rightButton);
			
			downButton = new BitmapTile(TileType.CloseMenuButton, Game.TILES, 3);
			downButton.x = -downButton.width / 2;
			downButton.y = space;
			container.addChild(downButton);
		}
		else if (s == 1) {
			leftButton = new BitmapTile(TileType.ConfirmMenuButton, Game.TILES, 3);
			leftButton.x = -leftButton.width - space;
			leftButton.y = -leftButton.height / 2;
			container.addChild(leftButton);
			
			rightButton = new BitmapTile(TileType.CloseMenuButton, Game.TILES, 3);
			rightButton.x = space;
			rightButton.y = -rightButton.height / 2;
			container.addChild(rightButton);
		}
	}
	
	public function update () {
		if (active) {
			if (KeyboardMan.INST.getState(Keyboard.SPACE).justPressed) {
				open(false);
			}
			else if (KeyboardMan.INST.getState(Keyboard.DOWN).justPressed && container.contains(downButton)) {
				handler(downButton.type);
			}
			else if (KeyboardMan.INST.getState(Keyboard.LEFT).justPressed && container.contains(leftButton)) {
				handler(leftButton.type);
			}
			else if (KeyboardMan.INST.getState(Keyboard.UP).justPressed && container.contains(upButton)) {
				handler(upButton.type);
			}
			else if (KeyboardMan.INST.getState(Keyboard.RIGHT).justPressed && container.contains(rightButton)) {
				handler(rightButton.type);
			}
		}
	}
	
}










