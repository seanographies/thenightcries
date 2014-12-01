package objs.Spells 
{
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
	public class GuitarPick extends Entity 
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
		protected var Rangef:Number = 2;
		protected var Lowf:Number = 2;
		
		public function GuitarPick(x:Number=0, y:Number=0) 
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
			spriteMap.add("ori", [19], 0, false);
			spriteMap.add("en1", [0, 1, 2, 3, 4], GV.Frame_Rate, true);
			spriteMap.add("en2", [5, 6, 7, 8, 9], GV.Frame_Rate, true);
			spriteMap.add("en3", [10, 11, 12, 13, 14], GV.Frame_Rate, true);
			spriteMap.add("enchant", [15, 16, 17, 18, 19], GV.Frame_Rate, false);
			
			spriteMap.centerOO();
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
			var _originX:int = Math.floor(Math.random() * 20) + -13;
			var _originY:int = Math.floor(Math.random() * 20) + -13;
			if (GV.TutorialLevel == false &&GV.Ornament == 0 || GV.Ornament == 2){
				setHitbox(8, 8, -13, 13);
			}
		}
		
		//handles the collision with urn, removes hitbox, adds energize, calls spell text, sets GV.ornament
		protected function Energize():void {
			if(GV.Ornament == 0 || GV.Ornament == 2){
				if (collide("urn", x, y) && GV.Fear > 0) {
						sisConfess.clearText();
						broConfess.clearText();
					if (GV.Fear >0 && initialCollision) {
						textDrawer();
						GV.Ornament = 2;
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
					btext(1, 3, " ''I am shy about my weight, that's why I dont really like going out to the mall with Mum anymore.'' ");					
					stext(2, 5, " ''Be comfortable with your body. Do not be ashamed of it, instead have the willpower to be confident and be able to make change.'' ");					
					stext(3, 0, "Enchanted",true);	
					break;
				case 2:
					enchantNum = 3;
					btext(1, 2, " ''I dont have anything in common with the kids at my school.'' ");					
					stext(2, 6, " ''I used to feel exactly the same way and so do others, the boy who plays ball by himself or the girl who sits on the swing alone. You must find and help each other.'' ");					
					stext(3, 0, "Enchanted",true);
					break;
				case 3:
					enchantNum = 3;
					btext(1, 6, " ''I want to be like you when Im older. You are so smart, so calm and independent, you carry this warmth with you that makes me feel comfortable in your presence.'' ");					
					stext(2, 4, " ''Jordan, I adore you. You are such a kind and wonderful brother. You're my best friend.'' ");					
					stext(3, 0, "Enchanted",true);
					break;				
				case 4:
					enchantNum = 5;
					btext(1, 6, " ''There is nothing that I am any good at, I feel like theres at least one thing everybody excels at, but I don't seem to have anything'' ");					
					stext(2, 5, " ''Sometimes when we judge ourselves, we tend to overlook the things we are capable of because it seems intuitive to us.'' ");					
					stext(3, 3, " ''But, to me, You too are better in things that others are not.'' ");					
					stext(4, 9, " ''Never compare yourself to anyone, you are unique, nobody has the exact same circumstances you have encountered in your life. Just live your life the way you want to, not for the approval or judgment of others.'' ");					
					stext(5, 0, "Enchanted",true);
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