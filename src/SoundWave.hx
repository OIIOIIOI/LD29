package ;

import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.geom.Matrix;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;
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
	private var Gmatrix: Matrix = new Matrix();
	private var colorsetup: Array<UInt>;
	private var newPulse: Particle;
	private var pulseLife: Int;
	private var pulseSize: Float;
	private var pulseNumber: Int;
	private var pulseInterval: Int;
	private var cycleProgress: Int;
	private var cycleDuration: Int;
	private var pulseList :List<Particle>;
	private var centerSymbol: BitmapTile;
	
	var snd:Sound;
	var sndChannel:SoundChannel;
	public var sndTransform:SoundTransform;
	public var sndRange(default, null):Int;
	
	public function new(type:SpotType){
		super();
		
		snd = switch (type) {
			case SpotType.Water:	Assets.getSound("snd/water.mp3");
			case SpotType.Train:	Assets.getSound("snd/train.mp3");
			case SpotType.Sawmill:	Assets.getSound("snd/sawmill.mp3");
			case SpotType.Sheep:	Assets.getSound("snd/cows.mp3");
			case SpotType.Church:	Assets.getSound("snd/church.mp3");
			default:				null;
		}
		sndRange = switch (type) {
			case SpotType.Water:	20;
			case SpotType.Train:	55;
			case SpotType.Sawmill:	45;
			case SpotType.Sheep:	37;
			case SpotType.Church:	140;
			default:				0;
		}
		sndTransform = new SoundTransform(0);
		
		displayed = false;
		waveType = type;
		startCycle();
	}
	
	function playSnd () {
		if (sndTransform.volume <= 0)	return;
		sndChannel = snd.play();
		sndChannel.soundTransform = sndTransform;
	}
	
	public function updateSnd (vol:Float) {
		sndTransform.volume = vol;
		if (sndChannel != null) sndChannel.soundTransform = sndTransform;
	}
	
	public function startCycle() {
		cycleProgress = -1;
		switch(waveType) {
			case SpotType.Train:
				colorsetup = [0xA99280, 0xA99280];
				pulseLife = 25;
				pulseNumber = 4;
				pulseInterval = 10;
				cycleDuration = 200;
				waveRange = 200;
				pulseSize = 0.2;
				centerSymbol = new BitmapTile(IconTrain, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Water:
				colorsetup = [0x008BFF,0x008BFF];
				pulseLife = 75;
				pulseNumber = 1;
				cycleDuration = 100;
				waveRange = 50;
				pulseSize = 0.3;
				centerSymbol = new BitmapTile(IconWater, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Church:
				colorsetup = [0xCB9A6E,0xCB9A6E];
				pulseLife = 40;
				pulseNumber = 5;
				pulseInterval = 2;
				cycleDuration = 100;
				waveRange = 450;
				pulseSize = 0.3;
				centerSymbol = new BitmapTile(IconChurch, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Sawmill:
				colorsetup = [0x767676,0x767676];
				pulseLife = 25;
				pulseNumber = 4;
				pulseInterval = 25;
				cycleDuration = 150;
				waveRange = 150;
				pulseSize = 0.5;
				centerSymbol = new BitmapTile(IconSawmill, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			case SpotType.Sheep:
				colorsetup = [0xE7E5E5,0xE7E5E5];
				pulseLife = 125;
				pulseNumber = 1;
				cycleDuration = 600;
				waveRange = 100;
				pulseSize = 0.4;
				centerSymbol = new BitmapTile(IconSheep, Game.TILES, 2);
				centerSymbol.x = -centerSymbol.width / 2;
				centerSymbol.y = -centerSymbol.height / 2;
				addChild(centerSymbol);
			default:
				throw new Error("Invalid SpotType");
		}
		pulseList = new List();
		playSnd();
		addEventListener(Event.ADDED_TO_STAGE, function(e:Event) { displayed = true;} );
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
	
	override public function update() {
		super.update();
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
