package ;
import flash.display.Sprite;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Particle extends Sprite
{
	public var isDead: Bool;
	public var scaleYMod: Float;
	public var scaleXMod: Float;
	public var ySpeed: Int;
	public var xSpeed: Int;
	public var alphaMod: Float;
	public var totalLife: Int;
	private var currentlife: Int;
	public var lifeState: Float;
	
	public function new(life:Int) 
	{
		super();
		totalLife = currentlife = life;
		xSpeed = ySpeed = 0;
		scaleXMod = scaleYMod = 1;
		alphaMod = 0;
	}
	
	public function update() {
		currentlife--;
		x += xSpeed;
		y += ySpeed;
		scaleX *= scaleXMod;
		scaleY *= scaleYMod;
		alpha += alphaMod;
		lifeState = currentlife / totalLife;
		if (currentlife <= 0) {
			isDead = true;
		}
		return lifeState;
	}
	
}