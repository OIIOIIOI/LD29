package ;

import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.geom.Matrix;
import Particle;
import Spot;

/**
 * ...
 * @author ...
 */
class SoundWave extends Entity
{
	private var waveType: SpotType;
	private var waveRange: Int;
	public var displayed: Bool;
	private var Gmatrix:Matrix = new Matrix();
	private var colorsetup: Array<UInt>;
	private var newPulse: Particle;
	private var pulseLife : Int;
	private var pulseSize :Float;
	private var pulseNumber: Int;
	private var pulseInterval: Int;
	private var cycleProgress: Int;
	private var cycleDuration: Int;
	private var pulseList :List<Particle>;
	private var centerSymbol: BitmapTile;
	
	public function new(type:SpotType){
		super();
		displayed = false;
		waveType = type;
		startCycle();
	}
	
	public function startCycle() {
		cycleProgress = -1;
		switch(waveType) {
			case SpotType.Train:
				colorsetup = [0xA99280, 0xA99280];
				pulseLife = 25;
				pulseNumber = 2;
				pulseInterval = 5;
				cycleDuration = 60;
				waveRange = 100;
				pulseSize = 0.2;
				centerSymbol = new BitmapTile(IconTrain, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Water:
				colorsetup = [0x008BFF,0x008BFF];
				pulseLife = 25;
				pulseNumber = 1;
				cycleDuration = 100;
				waveRange = 25;
				pulseSize = 0.3;
				centerSymbol = new BitmapTile(IconWater, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Church:
				colorsetup = [0xCB9A6E,0xCB9A6E];
				pulseLife = 50;
				pulseNumber = 1;
				cycleDuration = 100;
				waveRange = 50;
				pulseSize = 0.8;
				centerSymbol = new BitmapTile(IconChurch, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Factory:
				colorsetup = [0x767676,0x767676];
				pulseLife = 50;
				pulseNumber = 4;
				pulseInterval = 5;
				cycleDuration = 120;
				waveRange = 50;
				pulseSize = 0.5;
				centerSymbol = new BitmapTile(IconFactory, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Sheep:
				colorsetup = [0xE7E5E5,0xE7E5E5];
				pulseLife = 50;
				pulseNumber = 2;
				pulseInterval = 10;
				cycleDuration = 110;
				waveRange = 50;
				pulseSize = 0.4;
				centerSymbol = new BitmapTile(IconSheep, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			default:
				throw new Error("Invalid SpotType");
		}
		pulseList = new List();
		addEventListener(Event.ADDED_TO_STAGE, function(e:Event) { displayed = true;} );
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	private function drawPulse(p:Particle, range:Int, ringSize:Float) {
		if (ringSize >= 1 || ringSize <= 0) {
			ringSize = 0.99;
			trace("ringSize doit être compris entre 0 et 1 strictement");
		}
		Gmatrix.createGradientBox(range * 2, range * 2, 0, -range, -range);
		p.graphics.beginGradientFill(GradientType.RADIAL,colorsetup,[0,0.8],[Math.round(255*ringSize),255],Gmatrix);
		p.graphics.drawCircle(0, 0, range);
		p.graphics.endFill();
		p.scaleX = 0;
		p.scaleY = 0;
		/*p.scaleXMod = Math.pow(1/p.scaleX, 1/p.totalLife);
		p.scaleYMod = Math.pow(1/p.scaleX, 1/p.totalLife);*/
	}
	
	public function update(e:Event) {
		cycleProgress++;
		if (!displayed) {
			return;
		}
		if (cycleProgress > cycleDuration) {
			for (i in pulseList) {
				if (contains(i)) {
					removeChild(i);
					//trace("end: " + i.name+" removed");
				}
			}
			startCycle();
		}else {
			for (i in 0...pulseNumber) {
				if (cycleProgress == i * pulseInterval) {
					newPulse = new Particle(pulseLife);
					drawPulse(newPulse, waveRange, 1-pulseSize);
					pulseList.add(newPulse);
					addChild(newPulse);
					//trace(cycleProgress + ": " + newPulse.name +"created");
					break;
				}
			}
			for (i in pulseList) {
				i.update();
				alpha = 1 - Math.sqrt(cycleProgress / cycleDuration);
				if ( i.isDead) {
					if (contains(i)) {
						removeChild(i);
						//trace(cycleProgress + ": " + i.name +"removed");
					}
				}
			}
		}
	}
}
