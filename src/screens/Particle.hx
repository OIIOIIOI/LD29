package screens;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Particle extends Sprite
{
	private var partType: PartType;
	private var partLife: Int;
	private var partTotalLife: Int;
	private var isDead: Bool;
	
	public function new(type: PartType, life:Int) 
	{
		super();
		partType = type;
		partLife = partTotalLife = life;
		switch(partType) {
			case A:
				graphics.beginFill(0x885500, 1);
				graphics.drawRect(0, 0, 5, 5 );
				graphics.endFill();
			case B:
				
			case C:
		}
		
	}
	
	public function update() {
		life--;
		switch (partType) {
		case A:
			alpha -= partLife / partTotalLife;
		case B:
			
		case C:
			
		}
		if (life <= 0)	!isDead;
	}
	
}
enum PartType {
	A;
	B;
	C;
}