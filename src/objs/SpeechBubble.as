package objs 
{
	import flash.display.Graphics;
	import flash.events.TextEvent;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class SpeechBubble extends Entity 
	{
		protected var line:int = 0;
		protected var text:String;
		protected var _lineText:Text;
		protected var gm:GameManager = new GameManager;
		protected var _sfx:Sfx = new Sfx(GA.ACT_I_III_MUSIC);
		
		//graphics
		protected var gList:Graphiclist = new Graphiclist;
		[Embed(source = "../../assets/objs/sisterdraft.fw.png")] public static const SISTER_DRAFT:Class;
		protected var brother_draft:Image = new Image(GA.BROTHER_CONVERSATION);
		protected var sister_draft:Image = new Image(SISTER_DRAFT);
		
		public function SpeechBubble() 
		{
			trace("speechbubble created");
			this.x = 200;
			this.y = 200;
			addLines();
			graphic = gList;
			_sfx.loop();
			_sfx.volume = 0.2;
		}
		
		override public function update():void {
			super.update();
			playLine();
		}
		
		protected function addSprites():void {
			brother_draft.scale = 2.5;
			brother_draft.centerOO();
			brother_draft.x = -100;
			brother_draft.y = 250;
			gList.add(brother_draft);
			sister_draft.scale = 3;
			sister_draft.x = 480;
			sister_draft.y = -100;
			sister_draft.centerOO();
			gList.add(sister_draft);
		}
		
		//Sisters text bubble
		protected function speechBubble(_text:String, _line:int, sister:Boolean = true):void {
				if (line == _line) {
					gList.remove(_lineText);
					
				_lineText = new Text(_text, this.x, this.y, { size: 16, color: 0x000000, width: 570, height: 2, wordWrap:true, align: "center"});
					
					//TODO: sprites will be player here 
					if (sister) {
						_lineText.x = -190;
						_lineText.y = -100;
					}else {
						_lineText.x = -20;
						_lineText.y = 250;
					}
					addSprites();
					
					gList.add(_lineText);
				}
		}
		
		
		//adds lines of brother and sister, handles levels
		protected function addLines():void {
			if (GameManager.levelTicket == 1) {
				speechBubble("Good Morning Jordan, what happened to you last night?", 0);		
				speechBubble("I couldn't sleep, I was scared. I started hearing these noises like, doors slamming and footsteps.", 1, false);
				speechBubble("Well, it wasn't me. I was asleep when you came into my room.", 2);
				speechBubble("Sorry I woke you up.", 3,false);
				speechBubble("It's alright, you should probably tell mum and dad that.", 4);
				speechBubble("They keep forcing me to sleep in my own room even though they know I can't.", 5, false);
				speechBubble("Wait...How long have you been sleeping by yourself?", 6);
				speechBubble("This has been the second night. The first was the night after you left and I left my room in the middle of the night to sleep with mum as well.", 7, false);
				speechBubble("I can help you, these disturbances are not part of your imagination, they are real but not from this world, the real one, the one we live in.", 8);
				speechBubble("Are you going to give me a dream catcher or something. I keep asking mum for one but she says its just rubbish.", 9, false);
				speechBubble("Did you tell her that they make punjabi dream catchers as well?", 10);
				speechBubble("Not funny.. Im serious here.", 11, false);
				speechBubble("Okay, Okay. No its not a dream catcher, but its something similar. It will protect you.", 12);
				speechBubble("Im good with anything as long as mum and dad dont get mad at me.", 13, false);
				speechBubble("Alright, Im going to need some of your possessions. They will help with the spell.", 14);
				speechBubble("Spell? uh, okay. Like what?", 15, false);
				speechBubble("Lets start with some of your most cherished possessions, like that hotwheels car? You always used to play with that car when you were younger.", 16);
				speechBubble("The one that the both of us would role play fast and furious with?", 17, false);
				speechBubble("Yeah that one, the yellow one. Next, how about something from one of your hobbies?", 18);
				speechBubble("You want an Xbox?", 19, false);
				speechBubble("No, how about something to do with your Guitar? Like those guitar picks you used when I taught you how to play.", 20);
				speechBubble("My red ones?", 21, false);
				speechBubble("Yes, the ones that I lent you.", 22);
				speechBubble("Alright.. what else do you need?", 23, false);
				speechBubble("Okay last one, I need your baby teeth.", 24);
				speechBubble("No, this isn't funny. Can you be more mature about this?", 25, false);
				speechBubble(" I am! But you're not helping me. If you're not going to respect what I'm going to do then I'm not going to do it for you.", 26);
				speechBubble("Okay, okay. Don't get angry. I dont know where my baby teeth are, ask mum for them. Will this really protect me when I sleep alone?", 27, false);
				speechBubble(" Yes I promise, It will help you.", 28);
				speechBubble("Hey Sandra, are you doing anything after this?", 29, false);
				speechBubble(" You want to play chess with me later?", 30);
				speechBubble("Yeah, but what time are you leaving tonight?", 31, false);
				speechBubble(" Not till 9:30 and I get to come back home this week on Thursday instead. Lets play now.", 32);
				speechBubble("Awesome, I'll go get it.", 33, false);
			}
			
			if (GameManager.levelTicket == 4) {
				speechBubble("Hey jordan, how are you?", 0);
				speechBubble("Hey! Im good, you're back early.", 1, false);
				speechBubble("Yeah, I told you I was coming back early this week. So how was school?", 2);
				speechBubble("Ok, just the usual.", 3, false);
				speechBubble("Done your homework?", 4);
				speechBubble("Yeah.", 5, false);
				speechBubble("Dont lie, I know you haven't.", 6);
				speechBubble("I have. Ask mum.", 7, false);
				speechBubble("Ok, ok, I believe you. So.. have you been sleeping in your room while I was away?", 8);
				
				if (GV.FailState) {
					trace("Fail state dialogue");
					speechBubble("No I havent, the night you left I got scared while I was sleeping and went to mum's room again. She said that I can sleep with her from now on. Finally,she listened.", 9, false);
					speechBubble("Want to spend some time with me? How about we take a walk or something?", 10);
					speechBubble("Ah.. no Im busy. Im talking to my friend on skype and playing gmod.", 11, false);
					speechBubble("Ok, well dont play too long, I'll give you half an hour, then go do your homework. I told you not to play games on weekdays.", 12);
					speechBubble("Ok,ok.", 13, false);
					}else {
					trace("Success state dialogue");
					speechBubble("Yeah I have. I dont have anymore trouble sleeping alone, ever since the night you left. What'd you do?", 9, false);
					speechBubble(" It calmed you. You were worried. It doesn't really matter what I did. How about we go take a walk, catch some fresh air. Just the both of us.", 10);
					speechBubble("Ah...Alright.Yeah, ok.\n Mum! Sandra and I are gonna go for a walk.", 11, false);
					speechBubble("Just around the canal mum. Ok...We'll take the keys.", 12);
					speechBubble("Lets go.", 13, false);
				}
			}
		}
		
		protected function checkLine():void {
			gList.remove(_lineText);
		}
		
		protected function playLine():void {
			if (Input.mousePressed) {
				line++;
				checkLine();
				addLines();
				nextLevel();
			}
		}
		
		protected function nextLevel():void {
			if (GameManager.levelTicket == 1) {
				//ori 34
				if (line >= 34) {
					_sfx.stop();
					GameManager.levelTicket++;
					gm.changeLevel();
				}
			}			
			
			if (GameManager.levelTicket == 4) {
				if (line >= 14) {
					_sfx.stop();
					GameManager.levelTicket++;
					gm.changeLevel();
				}
			}
		}
		
		
	}

}