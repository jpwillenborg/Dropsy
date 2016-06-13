package {
	
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.*;
	
	
	public class Audio {
		
		[Embed(source="../assets/audio/button.mp3")]
		static const ButtonSound:Class;
		static var buttonSound:Sound;
		static var buttonChannel:SoundChannel;
		static var buttonTransform:SoundTransform;
		
		[Embed(source="../assets/audio/click.mp3")]
		static const ClickSound:Class;
		static var clickSound:Sound;
		static var clickChannel:SoundChannel;
		
		[Embed(source="../assets/audio/clear.mp3")]
		static const ClearSound:Class;
		static var clearSound:Sound;
		static var clearChannel:SoundChannel;
		static var clearTransform:SoundTransform;
		
		[Embed(source="../assets/audio/upgrade.mp3")]
		static const UpgradeSound:Class;
		static var upgradeSound:Sound;
		static var upgradeChannel:SoundChannel;
		
		[Embed(source="../assets/audio/extra.mp3")]
		static const ExtraSound:Class;
		static var extraSound:Sound;
		static var extraChannel:SoundChannel;
		
		[Embed(source="../assets/audio/out.mp3")]
		static const OutSound:Class;
		static var outSound:Sound;
		static var outChannel:SoundChannel;
		
		[Embed(source="../assets/audio/blank.mp3")]
		static const BlankSound:Class;
		static var blankSound:Sound;
		static var blankChannel:SoundChannel;
		static var blankTransform:SoundTransform;
		
		[Embed(source="../assets/audio/gameover.mp3")]
		static const GameOverSound:Class;
		static var gameOverSound:Sound;
		static var gameOverChannel:SoundChannel;
		
		static var sounds:String = Data.saveObj.sounds;
		static var upgradeIsPlaying:Boolean = false;
		static var extraIsPlaying:Boolean = false;
		static var elimCount:int;
		

		static function setup() {
			elimCount = 0;
			
			if (!buttonSound) {
				buttonSound = new ButtonSound();
				buttonChannel = new SoundChannel();
				
				clickSound = new ClickSound();
				clickChannel = new SoundChannel();
				
				clearSound = new ClearSound();
				clearChannel = new SoundChannel();
				clearTransform = new SoundTransform();				
				
				upgradeSound = new UpgradeSound();
				upgradeChannel = new SoundChannel();
				
				extraSound = new ExtraSound();
				extraChannel = new SoundChannel();
				
				outSound = new OutSound();
				outChannel = new SoundChannel();
				
				blankSound = new BlankSound();
				blankChannel = new SoundChannel();
				
				gameOverSound = new GameOverSound();
				gameOverChannel = new SoundChannel();
			}
			
			playBlank();
		}
		
		
		static function playButton() {
			if (sounds == "on") {
				buttonChannel.stop();
				clickChannel.stop();
				upgradeChannel.stop();
				extraChannel.stop();
				buttonChannel = buttonSound.play();
			}
		}
		
		
		static function playClick() {
			if (sounds == "on") {
				clickChannel = clickSound.play();
			}
		}
		
		
		static function playUpgrade() {
			if (sounds == "on") {
				if (!upgradeIsPlaying) {
					upgradeIsPlaying = true;
					
					clearChannel.stop();
					extraChannel.stop();
					upgradeChannel = upgradeSound.play();
					blankChannel = blankSound.play();
					
					Vibrate.buzz(250);
					
					blankChannel.addEventListener(Event.SOUND_COMPLETE, blankCompleteHandler);
					function blankCompleteHandler(evt:Event):void {
						blankChannel.removeEventListener(Event.SOUND_COMPLETE, blankCompleteHandler);
						upgradeIsPlaying = false;
					}
				}
			}
		}
		
		
		static function playExtra() {
			if (sounds == "on") {
				if (!upgradeIsPlaying) {
					extraIsPlaying = true;
					extraChannel = extraSound.play();
				}				
				extraChannel.addEventListener(Event.SOUND_COMPLETE, extraCompleteHandler);
				function extraCompleteHandler(evt:Event):void {
					extraChannel.removeEventListener(Event.SOUND_COMPLETE, extraCompleteHandler);
					extraIsPlaying = false;
				}
			}
		}
		
		
		static function playOut() {
			if (sounds == "on") {
				if (!upgradeIsPlaying) {
					buttonChannel.stop();
					clickChannel.stop();
					outChannel = outSound.play();
				}
			}
		}
		
		
		static function playClear() {
			if (sounds == "on") {
				if (!upgradeIsPlaying) {
					buttonChannel.stop();
					clickChannel.stop();
					clearChannel = clearSound.play();
					if (extraIsPlaying) {
						clearTransform.volume = 0.0;
						clearChannel.soundTransform = clearTransform;
					}
				}
			}
		}
		
		
		static function playPause() {
			SoundMixer.stopAll();
			upgradeIsPlaying = false;
		}
		
		
		static function playGameOver() {
			if (sounds == "on") {
				clickChannel.stop();
				upgradeChannel.stop();
				gameOverChannel = gameOverSound.play();
			}
			Vibrate.buzz(500);
		}
		
		
		static function playBlank() {
			blankChannel = blankSound.play();
		}
	}
}