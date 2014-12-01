package objs 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Brother extends Entity 
	{
		private var timerStart:Boolean = false;
		private var counter:Number = 0;
		private var timeLimit:Number = 3;
		private var _spritestring:String;
		
		private var gm:GameManager = new GameManager;
		
		
		protected var _spriteMap:Spritemap =  new Spritemap(GA.BROTHER_SPRITES, 128, 128);
		protected var Smoke_spriteMap:Spritemap = new Spritemap(GA.PERCEIVER_SMOKE_SPRITES, 128);
		protected var gList:Graphiclist = new Graphiclist();
		protected var _framerate:Number = 7;
		protected var curAnimation:String = "Sleeping";
		
		public function Brother()
		{
			x = 400;
			y = 200;
			addSprites();
			graphic = gList;
		}
		
		override public function update():void {
			super.update();
			if (GV.FaceChange) {
				updateFacex();
			}
			timer();
		}
		
		//adds brothers and sparks sprites
		protected function addSprites():void {
			//sparks sprites
			Smoke_spriteMap.add("default", [0, 1, 2, 3, 4], _framerate, true)
			Smoke_spriteMap.scale = 3;
			Smoke_spriteMap.centerOO();
			Smoke_spriteMap.y = -12;
			Smoke_spriteMap.play("default");
			gList.add(Smoke_spriteMap);
			
			//brothers sprites
			_spriteMap.add("Sleeping", [1], 0, false);
			_spriteMap.add("Halfasleep", [2], 0, false);
			_spriteMap.add("Awoke", [ 3, 4, 5], 5, false);
			_spriteMap.add("Awokeblink", [5, 21,5], 1, true);
			_spriteMap.add("Listening", [6, 7,6], 3, false);
			_spriteMap.add("Listeningblink", [7,22], 1, true);
			_spriteMap.add("Sloweye", [8, 9,10,22], 2, true);
			_spriteMap.add("Fasteye", [11, 12,13,14,15,23], 3, true);
			_spriteMap.add("Startcry", [16], 0, false);
			_spriteMap.add("Startcryblink", [16,24,16,16], 1, true);
			_spriteMap.add("Crying", [17,18,19, 20], 2, true);
			
			_spriteMap.centerOO();
			_spriteMap.scale =  1.5;
			_spriteMap.play(curAnimation);
			gList.add(_spriteMap);
			
			
		}
		
		//creates a timer
		protected function timer():void {
			if(timerStart){
				counter += FP.elapsed;
				//trace(counter);
				if (counter >= timeLimit) {
					curAnimation = _spritestring;
					_spriteMap.play(curAnimation);
					timerStart = false;
					counter = 0;
				}
			}
		}
		
		protected function updateBlinking(_sprite:String):void {
			_spritestring = _sprite;
			timerStart = true;
		}
		
		//updates the brothers facial expressions depending on the fear value
		protected function updateFacex():void {
			trace("Facex called");
			switch (GV.Fear) {
				case 0:
					trace(this + "'s Facex is Sleeping");
					curAnimation = "Sleeping";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;
				case 1:
					trace(this + "'s Facex is Sleeping");
					curAnimation = "Sleeping";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;
				case 2:
					trace(this + "'s Facex is Half Sleep");
					curAnimation = "Halfasleep";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;			
				case 3:
					trace(this + "'s Facex is Half asleep");
					curAnimation = "Halfasleep";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;				
				case 4:
					trace(this + "'s Facex is Awoken");
					curAnimation = "Awoke";
					_spriteMap.play(curAnimation);
					updateBlinking("Awokeblink");
					GV.FaceChange = false;
					break;				
				case 5:
					trace(this + "'s Facex is Listening");
					curAnimation = "Listening";
					_spriteMap.play(curAnimation);
					updateBlinking("Listeningblink");
					GV.FaceChange = false;
					break;				
				case 6:
					trace(this + "'s Facex is Sloweye");
					curAnimation = "Sloweye";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;				
				case 7:
					trace(this + "'s Facex is Fasteye");
					curAnimation = "Fasteye";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;				
				case 8:
					trace(this + "'s Facex is Startcry");
					curAnimation = "Startcry";
					_spriteMap.play(curAnimation);
					updateBlinking("Startcryblink");
					GV.FaceChange = false;
					break;
				case 9:
					trace(this + "'s Facex is Crying");
					curAnimation = "Crying";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					break;				
					case 10:
					trace(this + "'s Facex is Crying and game is set to fail state");
					curAnimation = "Crying";
					_spriteMap.play(curAnimation);
					GV.FaceChange = false;
					GV.FailState = true;
					FP.world.add(new FadeToBlack(false));
					GameManager.levelTicket++;
					gm.changeLevel();
					break;
				default:
					GV.FaceChange = false;
					break;
			}
		}
		
	}

}