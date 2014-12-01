package objs.Attacks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author sean singh
	 */
	public class Whispers extends Entity
	{
		protected var initCounter:Number = 0;
		protected var timelimit:Number = 10;
		protected var sectimelimit:Number = 22;
		
		protected var initAttack:Boolean = true;
		protected var stopattack:Boolean = false;
		
		protected var prifearX:int = 6;
		protected var secfearX:int = 1;
		
		protected var fearLimit:int = 3;
		
		//sfx
		protected var sfx:Sfx = new Sfx(GA.WHISPERING);
		
		protected var gm:GameManager = new GameManager;
		
		public function Whispers() 
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
		}
		
		protected function attackTimer():void 
		{
			if (!stopattack) {
				initCounter += FP.elapsed;
				if (initCounter >= timelimit) {
					sfx.play();
					GV.FaceChange = true;
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