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
class SoundWave extends Entity
{
	private var waveType: String;
	private var waveRange: Int;
	public var AimedWaveRange: Int;
	public var rangeMod = 10;
	private var waveFreq: Int;
	public var AimedWaveFreq: Int;
	public var freqMod = 1;
	private var waveX: Int;
	private var waveY: Int;
	private var tick: Int;
	
	
	public function new(type:String,range:Int,frequency:Int, X:Int,Y:Int) 
	{
		super();
		waveType = type;
		AimedWaveRange = waveRange = range;
		AimedWaveFreq = waveFreq = frequency;
		tick = waveFreq * 10;
		waveX = X;
		waveY = Y;
		setWave();
	}
	
	private function setWave() {
		x = waveX;
		y = waveY;
		var Gmatrix:Matrix = new Matrix();
		Gmatrix.createGradientBox(waveRange * 2, waveRange * 2, 0, -waveRange, -waveRange);
		graphics.beginGradientFill(GradientType.RADIAL,[0x0000FF,0xAAAAFF],[0,0.5],[0,255],Gmatrix);
		graphics.drawCircle(0, 0, waveRange);
		graphics.endFill;
		addEventListener(Event.ENTER_FRAME, update);
	}
	private function clearWave(){
		graphics.clear();
	}
	
	public function update(e:Event) {
		var echo1: Int;
		var echo2: Int;
		tick++;
		scaleX = scaleY = tick / (waveFreq * 10);
		if (tick >= waveFreq*10) {
			if (waveRange!=AimedWaveRange) {
				if (waveRange<AimedWaveRange) {
					waveRange += rangeMod;
					if (waveRange > AimedWaveRange) {
						waveRange = AimedWaveRange;
					}
					clearWave();
					setWave();
				}else {
					waveRange -= rangeMod;
					if (waveRange < AimedWaveRange) {
						waveRange = AimedWaveRange;
					}
				}
				clearWave();
				setWave();
			}
			if (waveFreq!=AimedWaveFreq) {
				if (waveFreq<AimedWaveFreq) {
					waveFreq += freqMod;
					if (waveFreq > AimedWaveFreq) {
						waveFreq= AimedWaveFreq;
					}
				}else {
					waveFreq -= freqMod;
					if (waveFreq < AimedWaveFreq) {
						waveFreq= AimedWaveFreq;
					}
				}
				clearWave();
				setWave();
			}
			tick = 0;
		}
	}
}