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
	public class Attacks extends Entity 
	{
		protected var initCounter:Number = 0;
		protected var timelimit:Number = 5;
		protected var sectimelimit:Number = 10;
		
		protected var initAttack:Boolean = true;
		protected var stopattack:Boolean = false;
		
		protected var prifearX:int = 2;
		protected var secfearX:int = 1;
		
		
		//sfx
		protected var sfx:Sfx = new Sfx(GA.DOOR);
		
		public function Attacks() 
		{
			trace("attack called");
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
			GV.Fear+= secfearX;
			trace("Fear " + GV.Fear);
		}
		
		protected function stopAttack():void 
		{
			if (!initAttack) {
				if (GV.Fear <= 0) {
					trace(this + " Stopped");
					stopattack = true;
					sfx.stop();
					FP.world.remove(this);
					GameManager.attackTicket++;
					FP.world.remove(this);
				}
			}
		}
		
		
	}

}