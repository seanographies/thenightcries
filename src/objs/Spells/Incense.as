package objs.Spells 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Incense extends Entity 
	{
		protected var _spritemap:Spritemap = new Spritemap(GA.INCENSE_SPRITES, 64, 64);
		protected  var curanimation:String;
		protected var _framerate:Number = 5;
		protected var spriteNumber:Number;
		protected var Range:Number = 4;
		protected var Low:Number = 1;
		
		public function Incense(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
			addSprites();
			graphic = _spritemap;
			layer = GC.OBJECTS_LAYER;
		}
		
		override public function update():void {
			super.update();
		}
		
		protected function addSprites():void {
			_spritemap.add("1", [0, 1, 2, 3, 4], _framerate, true);
			_spritemap.add("2", [5, 6, 7, 8, 9], _framerate, true);
			_spritemap.add("3", [10, 11, 12, 13, 14], _framerate, true);
			_spritemap.add("4", [15, 16, 17, 18, 19], _framerate, true);
			
			spriteNumber = Math.floor(Math.random() * Range) + Low;
			//trace("incense sprite number is " + spriteNumber);
			switch(spriteNumber) {
				case 1:
					curanimation = "1";
					break;				
				case 2:
					curanimation = "2";
					break;				
				case 3:
					curanimation = "3";
					break;				
				case 4:
					curanimation = "4";
					break;
			}
			
			_spritemap.play(curanimation);
			_spritemap.scale = 1.5;
		}
		
	}

}