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
	
	public function new (color:UInt, x:Int, y:Int) {
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
		if (type != null && type != SpotType.Goal) {
			entity = new SoundWave(type);
			entity.mapPos.x = x;
			entity.mapPos.y = y;
		}
		this.x = x;
		this.y = y;
		if (type == null)	throw new Error("Unknown spot type");
		trace("created spot " + type);
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
