package objs.Attacks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;	
	import objs.Brother;
	import objs.Spells.Confessions;
	/**
	 * ...
	 * @author sean singh
	 */
	public class CreakingDoor extends Entity 
	{
		private var timerStart:Boolean = false;
		protected var counter:Number = 0;
		protected var timeLimit:Number = 0;
		protected var initCounter:Number = 0;
		protected var timelimit:Number = 5;
		protected var sectimelimit:Number = 13;
		
		protected var tutorial:Confessions = new Confessions(true);
		protected var tutorial_start:Boolean = true;
		
		protected var initAttack:Boolean = true;
		protected var stopattack:Boolean = false;
		
		protected var prifearX:int = 3;
		protected var secfearX:int = 1;
		
		protected var fearLimit:int = 1;
		
		//sfx
		protected var sfx:Sfx = new Sfx(GA.DOOR);
		
		protected var gm:GameManager = new GameManager;
		
		public function CreakingDoor() 
		{
			trace(this + " called");
			
			if (GV.Fear < 0) {
				GV.Fear = 0;
			}
			
		}
		
		override public function update():void {
			super.update();
			attackTimer();
			stopAttack();
			timer();
		}
		
		//creates a timer based on _timelimit from text()
		protected function timer():void {
			if(timerStart){
				counter += FP.elapsed;
				//trace(counter);
				if (counter >= timeLimit) {
					tutorial.clearText();
					FP.world.remove(tutorial);
					timerStart = false;
					counter = 0;
				}
			}
		}		
		
		//to create text for the last tutorial line
		protected function ttext(_timeLimit:Number,_Text:String):void {
				tutorial.setText(_Text);
				FP.world.add(tutorial);
				timeLimit = _timeLimit;
				timerStart = true;
		}	
		
		//timer to call attacks and the final tutorial message
		protected function attackTimer():void 
		{
			if (!stopattack) {
				initCounter += FP.elapsed;
				if (initCounter >= timelimit) {
					sfx.play();
					GV.FaceChange = true;
					if (tutorial_start) {
						ttext(4, "The perceived has been disturbed, enchant the possessions to protect the perceived.");
						tutorial_start = false;
						}
					if (initAttack) {
						attack();
						initCounter = 0;
						initAttack = false;
						timelimit = sectimelimit;
					}else {
						secAttack();
						initCounter = 0;
					}
				}
			}
		}
		
		protected function attack():void 
		{
			trace(this + " primary Attack");
			GV.Fear += prifearX;
			trace("Fear " + GV.Fear);
		}
		
		protected function secAttack():void 
		{
			trace(this + " sec Attack");
			GV.Fear += secfearX;
			trace("Fear " + GV.Fear);
		}
		
		protected function stopAttack():void 
		{
			if (!initAttack) {
				if (GV.Fear <= fearLimit) {
					trace(this + " Stopped");
					stopattack = true;
					sfx.stop();
					FP.world.remove(this);
					GameManager.attackTicket++;
					trace("Attackticket = " + GameManager.attackTicket);
					gm.changeAttack();
					FP.world.remove(this);
				}
			}
		}
		
	}

}