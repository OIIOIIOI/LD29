package ;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;

/**
 * ...
 * @author ...
 */
class SoundWave extends Sprite
{
	private var waveType: String;
	private var waveRange: Int;
	private var waveFreq: Int;
	private var waveX: Int;
	private var waveY: Int;
	private var tick: Int;
	
	
	public function new(type:String,range:Int,frequency:Int, X:Int,Y:Int) 
	{
		super();
		waveType = type;
		waveRange = range;
		waveFreq = frequency;
		tick = waveFreq * 10;
		waveX = X;
		waveY = Y;
		addEventListener(Event.ENTER_FRAME, update);
		
		var Gmatrix:Matrix = new Matrix();
		Gmatrix.createGradientBox(waveRange*2,waveRange*2,0,-waveRange,-waveRange);
		
		//graphics.beginFill(0x0000FF, 0.5);
		graphics.beginGradientFill(GradientType.RADIAL,[0x0000FF,0xAAAAFF],[0,0.5],[0,255],Gmatrix);
		graphics.drawCircle(0, 0, waveRange);
		graphics.endFill;
		x = X;
		y = Y;
		
	}
	/*public function changeFreq(freqMod:Float)
	{
		waveFreq += freqMod;
		//mod de l'elt graph
	}
	public function changeRange(rangeMod:Float)
	{
		waveRange += rangeMod;
		//mod de l'elt graph
	}*/
	public function update(e:Event) {
		tick++;
		scaleX = scaleY = tick / (waveFreq * 10);
		if (tick >= waveFreq*10) {
			tick = 0;
		}
	}
	
}