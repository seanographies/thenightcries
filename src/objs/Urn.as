package objs 
{
	import flash.display.Bitmap;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	import net.flashpunk.graphics.Emitter;
	import flash.display.BitmapData;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Urn extends Entity 
	{
		protected var counter:Number = 0;
		protected var timeLimit:Number = 1;
		
		protected var gList:Graphiclist = new Graphiclist;
		
		protected var _spritemap:Spritemap = new Spritemap(GA.URN_SPRITES, 64, 64);
		protected var _spriteFrames:Number = 2;
		protected var curAnimation:String = "down";
		
		protected var _emitter:Emitter = new Emitter(new BitmapData(3, 3, false, 0X3D5043), 3, 3);
		protected var _emitterX:Number;
		
		public function Urn(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			addSprites();
			type = "urn";
			addParticles();
			
			super(x, y, gList);
			layer = GC.URN_HAND_LAYER;
		}
		
		override public function update():void {
			super.update();
			controls();
			timer();
			updateSprites();
		}
		
		
		//particles
		protected function addParticles():void {			
			_emitter.newType("smoke", [0]);
			_emitter.setMotion("smoke", 90, 35, 1, 10, 10, 4);
			_emitter.setAlpha("smoke", 1, 0.4);
			gList.add(_emitter);
		}
		
		//timer to call emitter
		protected function timer():void {
			counter += FP.elapsed;
			if (counter >= timeLimit) {
				randEmitter();
				_emitter.emit("smoke", _emitterX, -5);
				counter = 0;
			}
		}
		
		//creates a random number for emitter X value
		protected function randEmitter():void {
			_emitterX= Math.floor(Math.random() * 15) + -4;
		}
		
		//adds sprites
		protected function addSprites():void {
			_spritemap.add("down", [0, 1, 2, 3, 4], _spriteFrames, true);
			_spritemap.add("up", [5, 6, 7, 8, 9], _spriteFrames, true);
			
			_spritemap.centerOO();
			_spritemap.scale = 3.5;
			_spritemap.play(curAnimation);
			gList.add(_spritemap);
		}
		
		//changes sprites upon collision
		protected function updateSprites():void {
			//change to up or down
			if (collide("cursor",x,y)) {
				if (Input.mouseDown) {
					curAnimation = "up";
				}else {
					curAnimation = "down";
				}
			}else {
				curAnimation = "down";
			}
			_spritemap.play(curAnimation);
		}
		
		//mouse controls for urn, sets hitbox everytime on mouse down
		protected function controls():void {
			if (collide("cursor", x, y)) {
				Input.mouseCursor = MouseCursor.HAND;
				if (Input.mouseDown) {
					setHitbox(8, 8, 4, 4);
					this.x = Input.mouseX;
					this.y = Input.mouseY;
				}
			}else {
				Input.mouseCursor = MouseCursor.ARROW;
				setHitbox(0, 0, 1, 1);
			}
			//controls position
			if (y <=220) y = 300;
			if (y >= 600)y = 500;
			if (x >= 800) x = 254;
			if (x  <= 0) x = 254;
		}
		
		
	}

}