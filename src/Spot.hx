package ;
import flash.errors.Error;

/**
 * ...
 * @author 01101101
 */
class Spot {
	
	public var type(default, null):SpotType;
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var entity(default, null):Entity;
	
	public var cellX(default, null):Int;
	public var cellY(default, null):Int;
	
	public var distToGoal:Float;
	
	public function new (color:UInt, x:Int, y:Int) {
		distToGoal = 0;
		cellX = x;
		cellY = y;
		type = switch (color) {
			case 0xCCCCFF:
				SpotType.Water;
			case 0x9999FF:
				SpotType.Church;
			case 0x6666FF:
				SpotType.Factory;
			case 0x3333FF:
				SpotType.Train;
			case 0x0000FF:
				SpotType.Sheep;
			case 0xFF0000:
				SpotType.Goal;
			default:
				null;
		}
		this.x = Std.int((x + 0.5) * Level.GRID_SIZE);
		this.y = Std.int((y + 0.5) * Level.GRID_SIZE);
		if (type != null && type != SpotType.Goal) {
			entity = new SoundWave(type);
			entity.mapPos.x = this.x;
			entity.mapPos.y = this.y;
		}
		if (type == null)	throw new Error("Unknown spot type");
	}
	
	public function toString () {
		return "Spot {distToGoal:" + distToGoal + "}";
	}
	
}

enum SpotType {
	Water;
	Church;
	Factory;
	Train;
	Sheep;
	Goal;
}
