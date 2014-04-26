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
	private var waveRange: Int;
	public var AimedWaveRange: Int;
	public var rangeMod = 10;
	private var waveFreq: Int;
	public var AimedWaveFreq: Int;
	public var freqMod = 1;
	private var tick: Int;
	private var waveType:Wavetype;
	
	
	public function new(type:Wavetype) 
	{
		super();
		waveType = type;
		setWave();
	}
	
	private function setWave() {
		var Gmatrix:Matrix = new Matrix();
		var colorsetup: Array<UInt>;
		switch(waveType) {
			case Wavetype.RED:
				colorsetup = [0xFFAAAA,0xAA0000];
				waveRange = AimedWaveRange = 50;
				waveFreq = AimedWaveFreq = 12;
			case Wavetype.BLUE:
				colorsetup = [0xAAAAFF,0x0000AA];
				waveRange = AimedWaveRange = 75;
				waveFreq = AimedWaveFreq = 10;
			case Wavetype.GREEN:
				colorsetup = [0xAAFFAA,0x00AA00];
				waveRange = AimedWaveRange = 100;
				waveFreq = AimedWaveFreq = 8;
		}
		tick = waveFreq * 10;
		Gmatrix.createGradientBox(waveRange * 2, waveRange * 2, 0, -waveRange, -waveRange);
		graphics.beginGradientFill(GradientType.RADIAL,colorsetup,[0,0.5],[0,255],Gmatrix);
		graphics.drawCircle(0, 0, waveRange);
		graphics.endFill;
		addEventListener(Event.ENTER_FRAME, update);
	}
	private function clearWave(){
		graphics.clear();
	}
	
	public function update(e:Event) {
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
enum Wavetype {
	RED;
	BLUE;
	GREEN;
}