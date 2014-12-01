package objs.Spells 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Spell extends Entity 
	{
		protected var counter:Number = 0;
		protected var timeLimit:Number = 0;
		protected var timerStart:Boolean = false;
		protected var initialCollision:Boolean = true;
		protected var finalCollision:Boolean = false;
		
		protected var enchant:Boolean = false;
		protected  var energize:int = 0;
		protected var enchantNum:Number;
		
		protected var gList:Graphiclist = new Graphiclist;
		protected var lineText:Text;
		protected var timerOver:Boolean = false;
		
		protected var textDrawerNum:Number;
		protected var Range:Number = 3;
		protected var Low:Number = 1;
		
		protected var randomFear:Number;
		protected var Rangef:Number = 2;
		protected var Lowf:Number = 1;
		
		protected var teethBox:TeethBox = new TeethBox;
		
		
		public function Spell(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			Hitbox();
			
			graphic = gList;
			spellText();
		}
		
		override public function update():void {
			super.update();
			Energize();
			timer();
		}
		
		//sets hitbox based on GV.Ornament value
		protected function Hitbox():void {
			if (GV.Ornament == 0 || GV.Ornament == 1){
				setHitbox(32, 32, 16, 16);
			}
		}
		
		//handles the collision with urn, removes hitbox, adds energize, calls spell text, sets GV.ornament
		protected function Energize():void {
			if(GV.Ornament == 0 || GV.Ornament == 1){
				if (collide("urn", x, y)) {		
					
					if (GV.Fear >= 0 && initialCollision) {
						textDrawer();
						GV.Ornament = 3;
					}else if (GV.Fear >= 0 && !initialCollision) {
						setHitbox(0, 0, 10000, 10000);
						energize++;
						trace("energized: " + energize);
						enchanted();
						spellText();
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
					gList.remove(lineText);
					//trace("exceeded");
					Hitbox();
					timerStart = false;
					counter = 0;
				}
			}
		}
		
		//creates brother text when energizing
		protected function btext(_energize:int, _timeLimit:Number,_text:String):void {
			if (_energize == energize) {
				lineText = new Text(_text, 200,-100);
				lineText.color = 0x000000;
				gList.add(lineText);
				timeLimit = _timeLimit;
				timerStart = true;
			}
		}		
		
		//creates sister text when energizing
		protected function stext(_energize:int, _timeLimit:Number,_text:String):void {
			if (_energize == energize) {
				lineText = new Text(_text, 200,300);
				lineText.color = 0x000000;
				gList.add(lineText);
				timeLimit = _timeLimit;
				timerStart = true;
			}
		}
		
		//collates all text and is called in energize()
		protected function spellText():void {
			switch(textDrawerNum) {
				case 1:
					enchantNum = 2;
					stext(1, 3, "This is Case 1");
					break;
				case 2:
					enchantNum = 3;
					stext(1, 3, "This is Case 2");
					btext(2, 3, "This is Case 2, Text 2");
					break;
				case 3:
					enchantNum = 4;
					stext(1, 3, "This is Case 3");
					btext(2, 3, "This is Case 3, Text 2");
					stext(3, 3, "This is Case 3, Text 3");
					break;
				default:break;
			}
			
		}
		
		protected function enchanted():void {
			if (energize == enchantNum) {
				trace("ENCHANTED");
				randomizeFear();
				GV.Fear -= randomFear;
				trace("Fear " + GV.Fear);
				textDrawerNum = 0;
				energize = 0;
				GV.Ornament = 0;
				enchantNum = 50;
				initialCollision = true;
				finalCollision = true;
			}
		}
		
		protected function randomizeFear():void {
			randomFear = Math.floor(Math.random() * Rangef) + Lowf;
			trace("randomFear is " + randomFear);
		}
		
	}

}