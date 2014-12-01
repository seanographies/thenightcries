package objs.Spells 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class ToyCar extends Entity 
	{
		protected var counter:Number = 0;
		protected var timeLimit:Number = 0;
		protected var timerStart:Boolean = false;
		protected var initialCollision:Boolean = true;
		protected var finalCollision:Boolean = false;
		
		protected var enchant:Boolean = false;
		protected  var energize:int = 0;
		protected var enchantNum:Number;
		
		protected var spriteMap:Spritemap = new Spritemap(GA.OBJECTS_SPRITES, 64, 64);
		protected var curAnimation:String = new String("ori");
		protected var gList:Graphiclist = new Graphiclist;
		protected var sisConfess:Confessions = new Confessions(true);
		protected var broConfess:Confessions = new Confessions(false);
		protected var timerOver:Boolean = false;
		
		protected var textDrawerNum:Number;
		protected var Range:Number = 4;
		protected var Low:Number = 1;
		
		protected var randomFear:Number;
		protected var Rangef:Number = 4;
		protected var Lowf:Number = 1;
		
		public function ToyCar(x:Number = 0, y:Number = 0) 
		{
			this.x = x;
			this.y = y;
			Hitbox();
			
			addSprites();
			graphic = gList;
			spellText();
			type = "object";
			layer = GC.OBJECTS_LAYER;
		}
		
		override public function update():void {
			super.update();
			Energize();
			timer();
		}
		
		//creates sprites
		protected function addSprites():void {
			spriteMap.add("ori", [59], 0, false);
			spriteMap.add("en3", [40, 41, 42, 43, 44], GV.Frame_Rate, true);
			spriteMap.add("en2", [45, 46, 47, 48, 49], GV.Frame_Rate, true);
			spriteMap.add("en1", [50, 51, 52, 53, 54], GV.Frame_Rate, true);
			spriteMap.add("enchant", [55, 56, 57, 58, 59], GV.Frame_Rate, false);
			
			spriteMap.centerOO();
			spriteMap.scale = 2;
			spriteMap.play(curAnimation);
			gList.add(spriteMap);
		}
		
		//changes the sprites based on the energize levels
		protected function updateSprites():void {
			switch(energize) {
				case 1:
					curAnimation = "en1";
					spriteMap.play(curAnimation)
					break;
				case 2:
					curAnimation = "en2";
					spriteMap.play(curAnimation);
					break;
				case 3:
					curAnimation = "en3";
					spriteMap.play(curAnimation);
					break;
				default:
					break;
				
			}
		}
		
		//sets hitbox based on GV.Ornament value
		protected function Hitbox():void {
			var _originX:int = Math.floor(Math.random() * 50) + -30;
			var _originY:int = Math.floor(Math.random() * 20) + -18;
			if (GV.TutorialLevel == false && GV.Ornament == 0 || GV.Ornament == 1){
				setHitbox(8, 8, _originX, _originY);
			}
		}
		
		//handles the collision with urn, removes hitbox, adds energize, calls spell text, sets GV.ornament
		protected function Energize():void {
			if(GV.Ornament == 0 || GV.Ornament == 1){
				if (collide("urn", x, y) && GV.Fear > 0) {
						sisConfess.clearText();
						broConfess.clearText();
					if (GV.Fear > 0 && initialCollision) {
						textDrawer();
						GV.Ornament = 1;
					}else if (GV.Fear >0 && !initialCollision) {
						setHitbox(0, 0, 10000, 10000);
						energize++;
						updateSprites();
						trace("energized: " + energize);
						spellText();
						enchanted();
						trace("Ornament " + GV.Ornament);
					}
					
					if (finalCollision) {
						trace("FINAL COLLISION");
						setHitbox(0, 0, 10000, 10000);
						timeLimit = 2;
						timerStart = true;
						timer();
						GV.Ornament = 0;
						finalCollision = false;
					}
				}
			}
		}
		
		protected function textDrawer():void {
			textDrawerNum = Math.floor(Math.random() * Range) + Low;
			initialCollision = false;
			trace("Text Drawer Number is " + textDrawerNum);
		}
		
		//creates a timer based on _timelimit from text()
		protected function timer():void {
			if(timerStart){
				counter += FP.elapsed;
				//trace(counter);
				if (counter >= timeLimit) {
					sisConfess.dying(true);
					broConfess.dying(true);
					Hitbox();
					timerStart = false;
					counter = 0;
				}
			}
		}
		
		//creates brother text when energizing
		protected function btext(_energize:int, _timeLimit:Number,_Text:String):void {
			if (_energize == energize) {
				broConfess.setText(_Text);
				FP.world.add(broConfess);
				timeLimit = _timeLimit;
				timerStart = true;
			}
		}		
		
		//creates sister text when energizing
		protected function stext(_energize:int, _timeLimit:Number,_Sext:String,_enchanted:Boolean = false):void {
			if (_energize == energize) {
				if (_enchanted) {
					sisConfess.setText(_Sext, true);
				}else{
				sisConfess.setText(_Sext);
				}
				FP.world.add(sisConfess);
				timeLimit = _timeLimit;
				timerStart = true;
			}
		}
		
		//collates all text and is called in energize()
		protected function spellText():void {
			switch(textDrawerNum) {
				case 1:
					enchantNum = 3;
					btext(1, 3, " ''I feel like you are the only one who understands me.'' ");					
					btext(2, 4, " ''There are things that I want to tell you, that I know Mum & Dad, or my friends won't understand.'' ");					
					stext(3, 0, "Enchanted",true);					
					break;
				case 2:
					enchantNum = 4;
					btext(1, 4, " ''I wish you could make things easier for me, we could spend more time together.'' ");					
					btext(2, 3, " ''You're my best friend and there are things I want to share with you.'' ");					
					stext(3, 4, " ''I know, I need to. But other aspects of my life are getting the better of me right now.'' ");					
					stext(4, 0, "Enchanted",true);					
					break;
				case 3:
					enchantNum = 3;
					btext(1, 3, " ''There were times when I felt that I could tell you anything.'' ");					
					btext(2, 3, " ''I could whisper something to you and you would receive with clarity.'' ");	
					stext(3, 0, "Enchanted",true);					
					break;				
				case 4:
					enchantNum = 4;
					btext(1, 3, " ''Things aren't the way they used to be, now that you are living far away.'' ");					
					stext(2, 3, " ''I know, its hard to be the only child left at home. But always remember, wherever you are...'' ");	
					stext(3, 3, " '' I can't always be watching over you, but know that I am always thinking of you.'' ");	
					stext(4, 0, "Enchanted",true);					
					break;
				default:break;
			}
			
		}
		
		protected function enchanted():void {
			if (energize == enchantNum) {
				trace("ENCHANTED");
				randomizeFear();
				GV.Fear -= randomFear;
				GV.FaceChange = true;
				trace("Fear " + GV.Fear);
				textDrawerNum = 0;
				energize = 0;
				GV.Ornament = 0;
				enchantNum = 50;
				initialCollision = true;
				finalCollision = true;
				curAnimation = "enchant";
				spriteMap.play(curAnimation);
			}
		}
		
		protected function randomizeFear():void {
			randomFear = Math.floor(Math.random() * Rangef) + Lowf;
			trace("randomFear is " + randomFear);
		}
		
	}

}
