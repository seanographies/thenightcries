package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
		}
		
		override public function init():void {
			super.init();
			FP.screen.color = 0xffffff;
			FP.world = new GameWorld(GA.TITLESCREEN_LEVEL);
			FP.console.enable();
		}
		
	}
	
}