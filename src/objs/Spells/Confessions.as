package objs.Spells 
{
	import flash.sampler.NewObjectSample;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Confessions extends Entity 
	{
		protected var _image:Image = new Image(GA.CONFESSION);
		protected var gList:Graphiclist = new Graphiclist;
		protected var _spritemap:Spritemap = new Spritemap(GA.CONFESSIONS_SPRITES, 128, 128);
		protected var _curanimation:String = new String("smokey");
		
		protected var text:Text;
		protected var textX:Number = 0;
		protected var textY:Number = 0;
		
		protected var startDying:Boolean = false;
		protected var fadeIn:Boolean = false;
		
		protected var _sfx:Sfx;
		protected var _sfx_number:Number;
		protected var Range:Number = 4;
		protected var Low:Number = 1;
		protected var sound:Class;
		
		public function Confessions(_sister:Boolean = true) 
		{
			if (_sister) {
				this.x = 400;
				this.y = 450;
			}else {
				this.x = 400;
				this.y = 100;
			}
			
			addSprites();
		}
		
		override public function update():void {
			super.update();
			updateFade();
			//trace(_spritemap.alpha);
			//trace("Out = " + startDying);
			//trace("In = " + fadeIn);
		}
		
		//adds a sfx for when confessions appear from randomized drawer
		protected function addSFX():void {
			_sfx_number = Math.floor(Math.random() * Range) + Low;
			//trace("_sfx number is " + _sfx_number);
			switch(_sfx_number) {
				case 1:
					sound = GA.ENCHANTING_SFX_1;
					break;				
				case 2:
					sound = GA.ENCHANTING_SFX_2;
					break;				
				case 3:
					sound = GA.ENCHANTING_SFX_3;
					break;				
				case 4:
					sound = GA.ENCHANTING_SFX_4;
					break;
			}
			
			_sfx = new Sfx(sound);
			_sfx.play();
			_sfx.volume = 0.3;
		}
		
		//handles the fading of the images
		public function updateFade():void {			
			if (startDying) {
				fadeIn = false;
				for (var i:int = 0; i < 2; i++) 
				{
					if(_spritemap.alpha > 0){
						_spritemap.alpha -= 0.02;
						text.alpha -= 0.009;
					}
					//trace("FADE OUT");
					//trace(_spritemap.alpha);w
				}
				
				if (_spritemap.alpha == 0) {
					//trace("KILL");
					clearText();
					_spritemap.alpha = 0;
					text.alpha = 0;
					startDying = false;
					fadeIn = true;
					//trace("FADE OUT STOP");
					FP.world.remove(this)
				}
			}
			
			if (fadeIn) {
				for (var x:int = 0; x < 2; x++) 
				{
					if (_spritemap.alpha < 1) {
						_spritemap.alpha += 0.007;
					}
					
					if (text.alpha < 0.3) {
						text.alpha += 0.007
					}
					
					//trace("FADE IN");
					//trace(_spritemap.alpha);
				}
				
				if (_spritemap.alpha == 1) {
					fadeIn = false;
					_spritemap.alpha = 1;
					text.alpha = 0.3;
					//trace("FADE IN STOP");
				}
			}
			
		}
		
		protected function addSprites():void {
			_spritemap.add("smokey", [0, 1, 2, 3, 4, 5], 8, true);
			_spritemap.add("dying", [6, 7, 8, 9, 10, 11], 8, true);
			_spritemap.centerOO();
			_spritemap.scale = 3.6;
			_spritemap.alpha = 0;
			_curanimation = "smokey";
			_spritemap.play(_curanimation);
			gList.add(_spritemap);
		}
		
		public function setText(_text:String,_enchanted:Boolean = false):void {
			text = new Text(_text, -12,-8,{size: 16, width: 400, height: 2, wordWrap: true, align: "center", alpha: 0.3 });
			text.color = 0x000000
			text.centerOO();
			if (_enchanted) {
				text.size = 22;
			}
			gList.add(text);
			startDying = false;
			fadeIn = true;
			graphic = gList;
			addSFX();
		}
		
		public function dying(_start:Boolean = false):void {
			if(_spritemap.alpha == 1){
				startDying = _start;
			}
		}
		
		
		public function clearText():void {
			gList.remove(text);
		}
		
		
	}

}