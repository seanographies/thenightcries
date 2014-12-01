package objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author sean singh
	 */
	public class Cursor extends Entity 
	{		
		protected var _cursorHand:Image = new Image(GA.CURSOR_HAND);
		protected var _cursorClench:Image = new Image(GA.CURSOR_CLENCH);
		
		protected var _spritemap:Spritemap;
		
		public function Cursor() 
		{
			Mouse.hide();
			setHitbox(64, 64, 32, 32);
			type = "cursor";	
			
			super(Input.mouseX, Input.mouseY);			
		}
		
		override public function update():void {
			super.update();
			updateCursor();
		}
		
		protected function updateCursor():void {
			this.x = Input.mouseX;
			this.y = Input.mouseY;
			
			//if level is spell
			if (GameManager.levelTicket == 2 || GameManager.levelTicket == 3|| GameManager.levelTicket == 5) {
				if (collide("urn", x, y)) {
					if (Input.mouseDown) {
						_cursorClench.x = -64;
						_cursorClench.y = -195;
						_cursorClench.scale = 2;
						graphic = _cursorClench;
					}else if (Input.mouseReleased) {
						_cursorHand.centerOO();
						_cursorHand.scale = 2;
						graphic = _cursorHand;
					}
				}else {
					_cursorHand.centerOO();
					_cursorHand.scale = 2;
					graphic = _cursorHand;
				}
			}
			
			//if level !spell then no graphic
		}
		
	}

}