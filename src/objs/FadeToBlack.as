package objs 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class FadeToBlack extends Entity 
	{
		protected var square:BitmapData = new BitmapData(800, 600, false, 0x000000);
		protected var _image:Image;
		protected var fade_in:Boolean = new Boolean(true);
		
		public function FadeToBlack(_fade_In:Boolean = true) 
		{
			x = 0;
			y = 0;
			fade_in = _fade_In;
			
			_image = new Image(square);
			_image.alpha = 1;
			graphic = _image;
		}
		
		override public function update():void {
			super.update();
			updateFade();
		}
		
		protected function updateFade():void {
			if (fade_in) {
				for (var i:int = 0; i < 2; i++) {
					_image.alpha -= 0.003;
				}
				
				if (_image.alpha == 0) {
					FP.world.remove(this);
				}
				
			}
		}
		
	}

}