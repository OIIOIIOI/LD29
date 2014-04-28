package ;
import flash.errors.Error;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;

/**
 * ...
 * @author 01101101
 */

class SoundMan {
	
	static var snd:Sound;
	static var sndChannel:SoundChannel;
	static var sndTransform:SoundTransform;
	static var tracks:Map<Track, Sound>;
	
	public static function play (t:Track, loop:Bool = true) {
		stopAll();
		//
		if (tracks == null)	tracks = new Map<Track, Sound>();
		if (sndTransform == null)	sndTransform = new SoundTransform(0.4);
		//
		if (!tracks.exists(t)) {
			var path:String = switch (t) {
				case StartTrack:		"snd/t_start.mp3";
				case IntroTrack:		"snd/t_intro.mp3";
				case GameTrack:			"snd/t_game.mp3";
				case WinTrack:			"snd/t_win.mp3";
				case LoseTrack:			"snd/t_lose.mp3";
			}
			tracks.set(t, Assets.getSound(path));
		}
		var l = (loop) ? 999 : 0;
		sndChannel = tracks.get(t).play(0, l);
		sndChannel.soundTransform = sndTransform;
	}
	
	public static function muffle (v:Bool = true) {
		if (sndTransform == null)	return;
		sndTransform.volume = v ? 0.3 : 0.5;
		if (sndChannel != null)	sndChannel.soundTransform = sndTransform;
	}
	
	public static function fatMuffle (v:Bool = true) {
		if (sndTransform == null)	return;
		sndTransform.volume = v ? 0.2 : 0.5;
		if (sndChannel != null)	sndChannel.soundTransform = sndTransform;
	}
	
	public static function stopAll () {
		SoundMan.muffle(false);
		SoundMan.fatMuffle(false);
		if (sndChannel != null) {
			sndChannel.stop();
			sndChannel = null;
		}
	}
	
}

enum Track {
	StartTrack;
	IntroTrack;
	GameTrack;
	WinTrack;
	LoseTrack;
}











