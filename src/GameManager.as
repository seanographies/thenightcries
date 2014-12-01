package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import objs.Attacks.Attacks;
	import objs.Attacks.CreakingDoor;
	import objs.Attacks.Slam;
	import objs.Attacks.Steps;
	import objs.Attacks.Whispers;
	import objs.Attacks.Wind;
	import objs.FadeToBlack;
	import objs.Spells.Perceiver;
	/**
	 * ...
	 * @author sean singh
	 */
	public class GameManager 
	{
		private var background:Image;
		public static var levelTicket:int = 0;
		public static var attackTicket:int = 0;
		
		public function changeLevel():void {
			switch(levelTicket) {
				case 0:
					//titlescreen
					trace("titlescreen");
					FP.world = new GameWorld(GA.TITLESCREEN_LEVEL);
					break;
				case 1:
					//Act I
					trace("Act I");
					FP.world = new GameWorld(GA.ACT_I_III_Level);
					break;
				case 2:
					//Tutorial
					trace("Act II/Tutorial");
					FP.world = new GameWorld(GA.ACTII_LEVEL);
					break;				
				case 3:
					//Act II
					trace("Act II");
					changeAttack();
					break;
				case 4:
					//Act III
					trace("Act III");
					FP.world = new GameWorld(GA.ACT_I_III_Level);
					break;
				case 5:
					//credits
					trace("Credits");
					FP.world = new GameWorld(GA.TITLESCREEN_LEVEL);
					break;
				default:
					break;
			}
		}
		
		
		public function changeAttack():void {
			switch(attackTicket) {
				case 0:
					FP.world.add(new CreakingDoor);
					GV.FaceChange = true;
					break;
				case 1:
					FP.world.add(new Wind)
					GV.FaceChange = true;
					break;
				case 2:
					FP.world.add(new Slam);
					GV.FaceChange = true;
					break;
				case 3:
					FP.world.add(new Steps);
					GV.FaceChange = true;
					break;
				case 4:
					FP.world.add(new Whispers);
					GV.FaceChange = true;
					break;				
				case 5:
					levelTicket ++;
					changeLevel();
					break;
				default:break;
			}
		}
		
		
	}

}