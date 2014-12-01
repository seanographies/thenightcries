package objs.Spells 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class TeethBox extends Entity 
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
		protected var Rangef:Number = 3;
		protected var Lowf:Number = 1;
		
		public function TeethBox(x:Number=0, y:Number=0) 
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
			spriteMap.add("ori", [39], 0, false);
			spriteMap.add("en3", [20, 21, 22, 23, 24], GV.Frame_Rate, true);
			spriteMap.add("en2", [25, 26, 27, 28, 29], GV.Frame_Rate, true);
			spriteMap.add("en1", [30, 31, 32, 33, 34], GV.Frame_Rate, true);
			spriteMap.add("enchant", [35, 36, 37, 38, 39], GV.Frame_Rate, false);
			
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
			var _originX:int = Math.floor(Math.random() * 23) + -15;
			var _originY:int = Math.floor(Math.random() * 40) + -25;
			if (GV.TutorialLevel == false && GV.Ornament == 0 || GV.Ornament == 3){
				setHitbox(8, 8, _originX, _originY);
			}
		}
		
		//handles the collision with urn, removes hitbox, adds energize, calls spell text, sets GV.ornament
		protected function Energize():void {
			if(GV.Ornament == 0 || GV.Ornament == 3){
				if (collide("urn", x, y) && GV.Fear > 0) {
						sisConfess.clearText();
						broConfess.clearText();
					if (GV.Fear > 0 && initialCollision) {
						textDrawer();
						GV.Ornament = 3;
					}else if (GV.Fear > 0 && !initialCollision) {
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
					stext(1, 7, " ''Whenever you feel alone and sad remember this when you are under the sun.The sun shines from 149 million km away, travels all the way to earth where it gives you warmth.'' ");					
					stext(2, 4, " ''Everything in this universe has a significance for something or someone else, including you.'' ");					
					stext(3, 0, "Enchanted",true);	
					break;
				case 2:
					enchantNum = 3;
					stext(1, 3, " ''You are at a stage in your lifetime where you still look up to me.'' ");					
					stext(2, 6, " ''If I don't spend more time with you by the time you grow out of it, we may lose that special bond that we have. Forever.'' ");					
					stext(3, 0, "Enchanted",true);	
					break;
				case 3:
					enchantNum = 3;
					stext(1,5, " ''I know that our relationship has been quite distant recently but, know that this is just the maturing of a relationship,'' ");					
					stext(2, 5, " ''We cannot always have what we had but we can always change it to support us in ways it already has not.'' ");					
					stext(3, 0, "Enchanted",true);	
					break;				
				case 4:
					enchantNum = 4;
					stext(1, 7, " ''When I look back on my childhood, I remember all the bullying, the taunting, the loneliness I felt because I never had anyone I could share my feelings with.'' ");					
					stext(2, 6, " ''I don't want the same to happen to you, I want you to know that I am here to help you and you can tell me anything.'' ");					
					stext(3, 2, " ''I cherish the relationship that we have.'' ");					
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
				GV.Ornament = 0;
				textDrawerNum = 0;
				energize = 0;
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