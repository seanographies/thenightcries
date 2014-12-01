package objs.Spells 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import objs.Brother;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Perceiver extends Entity 
	{
		protected var counter:Number = 0;
		protected var timeLimit:Number = 0;
		protected var timerStart:Boolean = false;
		protected var initialCollision:Boolean = true;
		protected var finalCollision:Boolean = false;
		protected var gm:GameManager = new GameManager;
		
		protected var enchant:Boolean = false;
		protected  var energize:int = 0;
		protected var enchantNum:Number = 4;
		
		protected var spriteMap:Spritemap = new Spritemap(GA.OBJECTS_SPRITES, 64, 64);
		protected var curAnimation:String = new String("ori");
		protected var gList:Graphiclist = new Graphiclist;
		protected var tutorial:Confessions = new Confessions(true);
		protected var timerOver:Boolean = false;
		
		//tint, makes room look darker
		protected var tint:Image = new Image(new BitmapData(800, 600, false, 0x000000));
		
		public function Perceiver(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			
			spellText();
			addSprites();
			
			graphic = gList;
			
			setHitbox(0, 0, 10000, 10000);
			type = "object";
			layer = GC.OBJECTS_LAYER;
		}
		
		override public function update():void {
			super.update();
			Energize();
			timer();
		}
		
		protected function Hitbox():void {
			var _originX:int = Math.floor(Math.random() * 40) + -20;
			var _originY:int = Math.floor(Math.random() * 40) + -20;
			if (GV.TutorialLevel) {
				setHitbox(8, 8, _originX, _originY);
			}
		}
		
		//adds sprites and tint
		protected function addSprites():void {
			spriteMap.add("ori", [65], 0, false);
			spriteMap.add("en1", [60,61,62,63,64], GV.Frame_Rate, true);
			spriteMap.scale = 2;
			spriteMap.centerOO();
			spriteMap.play(curAnimation);
			gList.add(spriteMap);
			
			tint.x = -800;
			tint.y = -800;
			tint.scale = 50;
			tint.alpha = 0.4;
			gList.add(tint);
		}
		
		protected function updateSprites():void {
			if (energize < 4) {
				curAnimation = "en1";
				spriteMap.play(curAnimation);
			}else {
				curAnimation = "ori";
				spriteMap.play(curAnimation);
			}
		}
		
		protected function Energize():void {
			if (GV.TutorialLevel) {
				if (collide("urn", x, y)) {	
					setHitbox(0, 0, 10000, 10000);
					energize++;
					tutorial.clearText();
					spellText();
					updateSprites();
					enchanted();					
				}
			}
		}
		
		//creates a timer based on _timelimit from text()
		protected function timer():void {
			if (timerStart) {
				counter += FP.elapsed;
				if (counter >= timeLimit) {
					tutorial.dying(true);
					timerStart = false;
					counter = 0;
					Hitbox();	
				}
			}
		}		
		
		protected function ttext(_timeLimit:Number, _Text:String):void {
				tutorial.setText(_Text);
				FP.world.add(tutorial);
				timeLimit = _timeLimit;
				timerStart = true;
		}		
		
		protected function spellText():void {
			switch(energize) {
				case 0:
					ttext(7, "Pick up the urn\nSlowly but steadily encircle it on the perceiver to begin the energizing cycle.");
					break;
				case 1:
					ttext(7, "The perceiver is the link between this world and the one with the curtains drawn. Continue to encircle around the perceiver until it is enchanted.");
					break;
				case 2:
					ttext(9, "When the smoke arises, you can only energize that particular object. You may only energize other objects when the current one has been enchanted.");
					break;
				case 3:
					ttext(7, "Once the smoke has reached its climax, the object is energized and is ready to be enchanted.");
					break;
				case 4:
					ttext(4, "The perceiver has been enchanted. \nThe perceiver can no longer be energized.");
					GV.TutorialLevel = false;
					Hitbox();
					break;
				default:
					break;
			}
		}
		
		protected function enchanted():void {
			if (energize == enchantNum) {
				GameManager.levelTicket++;
				gm.changeLevel();
				FP.world.add(new Brother);
			}
		}
		
		
		
	}

}