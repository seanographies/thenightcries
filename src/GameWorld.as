package  
{
	import flash.display.BitmapData;
	import mx.core.ButtonAsset;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import objs.Attacks.Attacks;
	import objs.Brother;
	import objs.Cursor;
	import objs.FadeToBlack;
	import objs.SpeechBubble;
	import objs.Spells.Confessions;
	import objs.Spells.GuitarPick;
	import objs.Spells.Incense;
	import objs.Spells.Perceiver;
	import objs.Spells.TeethBox;
	import objs.Spells.ToyCar;
	import objs.Titlescreen;
	import objs.Urn;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import net.flashpunk.Entity
	import net.flashpunk.masks.Grid;
	import net.flashpunk.graphics.Text;
	import objs.Button;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class GameWorld extends World 
	{
		protected var teethBox:TeethBox = new TeethBox;
		protected var gm:GameManager = new GameManager;
		
		//Map grid
		protected var map:Entity;
		public var _mapGrid:Grid;
		public var _mapImage:Image;
		protected var _mapData:Class;
		
		protected var background:Image;
		
		//text
		[Embed(source="../assets/superhelio/SUPERHETHL.TTF", fontName = "Apple", mimeType = "application/x-font-truetype",fontWeight="normal", fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")] private static const FONT:Class;
		public function GameWorld(mapData:Class) 
		{
			_mapData = mapData;
			super(); 
			loadMap(_mapData);
			
			//map
			_mapImage = new Image(_mapGrid.data);
			_mapImage.color = 0x000000;
			_mapImage.scale = 4;
           map = new Entity (_mapGrid.x ,_mapGrid.y, _mapImage, _mapGrid);
		   map.setHitbox(_mapGrid.width,_mapGrid.height);
		   map.type = "level";			
		   map.layer = 11;
		   Text.font = "Apple";
		}
		
		override public function begin():void {
			super.begin();
			add(new Cursor());
			changeBackground();
		}
		
		protected function loadMap(mapData:Class):void {
			var mapXML:XML = FP.getXML(mapData);
			var node:XML;
			
			//map grid
            _mapGrid = new Grid(uint(mapXML.@width), (uint(mapXML.@height)), 4,4,0,0);
            _mapGrid.loadFromString(String(mapXML.Grid4), "", "\n");
			
			//Spells
			for each (node in mapXML.Entities.Toycar) {
				add(new ToyCar(Number(node.@x), Number(node.@y)));
			}
			for each (node in mapXML.Entities.Guitarpick) {
				add(new GuitarPick(Number(node.@x), Number(node.@y)));
			}
			for each (node in mapXML.Entities.Teethbox) {
				add(new TeethBox(Number(node.@x), Number(node.@y)));
			}			
			
			for each (node in mapXML.Entities.Incense) {
				add(new Incense(Number(node.@x), Number(node.@y)));
			}
			
			//Urn
			for each (node in mapXML.Entities.Urn) {
				add(new Urn(Number(node.@x), Number(node.@y)));
			}
			
			//Brother
			for each(node in mapXML.Entities.Brother) {
				add(new Brother);
			}
			
			//perceiver
			for each (node in mapXML.Entities.perceiver) {
				//add(new Perceiver(Number(node.@x), Number(node.@y)));
			}
			
			//Conversation
			for each(node in mapXML.Entities.conversation) {
				add(new SpeechBubble);
			}
			
			for each(node in mapXML.Entities.titlescreen) {
				add(new Titlescreen);
			}
			
		}
		
		protected function changeBackground():void {
			trace("called");
			if (GameManager.levelTicket == 1) {
				add(new FadeToBlack);
				background = new Image(GA.CONVERSATION_BG);
			}			
			if (GameManager.levelTicket == 2) {
				add(new FadeToBlack);
				add(new Perceiver(384, 352));
				background = new Image(GA.ROOM_BG);
			}			
			if (GameManager.levelTicket == 4) {
				add(new FadeToBlack);
				background = new Image(GA.CONVERSATION_BG);
			}			
			if (GameManager.levelTicket == 4) {
				add(new FadeToBlack);
				background = new Image(GA.CONVERSATION_BG);
			}		
			if (GameManager.levelTicket == 5) {
				add(new Button(32, 544,"Seanographies","http://www.seanographies.tumblr.com",26));
				add(new Button(325, 456, "Resources", "http://seanographies.tumblr.com/thenightcries", 32));
				}
			var e:Entity = new Entity;
			e.graphic = background;
			e.layer = GC.BG_LAYER;
			add(e);
		}
	}

}