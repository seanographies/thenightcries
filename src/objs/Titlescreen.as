package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Titlescreen extends Entity 
	{
		protected var titlescreen_image:Image = new Image(GA.TITLESCREEN_BG);
		protected var creditsscreen_image:Image = new Image(GA.CREDITS_BG);
		protected var gList:Graphiclist = new Graphiclist;
		protected var gm:GameManager = new GameManager;
		
		public function Titlescreen() 
		{
			this.x = 0;
			this.y = 0;
			if (GameManager.levelTicket == 0) {
				gList.add(titlescreen_image);
			}
			
			if (GameManager.levelTicket == 5) {
				gList.add(creditsscreen_image);
			}
			instructions();
			graphic = gList;
			
		}
		
		override public function update():void {
			super.update();
			controls();
		}
		
		private function controls():void 
		{
			if (GameManager.levelTicket == 0) {
				if (Input.mousePressed) {
					GameManager.levelTicket++;
					gm.changeLevel();
				}
			}
			
			if (GameManager.levelTicket == 5) {
				if (Input.mousePressed) {
					GameManager.levelTicket = 0;
				if (GameManager.levelTicket == 0) {
					gList.add(titlescreen_image);
				}					
				gm.changeLevel();
				}
			}
		}
		
		protected function instructions():void {
			var t:Text = new Text("Click to start", 315, 420);
			t.color = 0x000000;
			t.size = 22;
			//gList.add(t);
		}
		
	}

}