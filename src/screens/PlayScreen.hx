package screens;

/**
 * ...
 * @author 01101101
 */

class PlayScreen extends Screen {
	
	public static var SCREEN_SIZE:Int = 510;
	//Spawn offset
	var OFFSET_X:Float;
	var OFFSET_Y:Float;
	// Level
	var level:Level;
	// Entities
	var player:Player;
	var radar:Radar;
	var marks:List<Entity>;
	
	
	public function new () {
		super();
		
		Manager.init();
	}
	
	override public function destroy () {
		super.destroy();
		Manager.destroy();
	}
	
}
