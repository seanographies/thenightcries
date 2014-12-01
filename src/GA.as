package  
{
	/**
	 * ...
	 * @author sean singh
	 */
	public class GA 
	{
		//SFX
		[Embed(source = "../assets/sfx/creaking door.mp3")] public static const DOOR:Class;
		[Embed(source = "../assets/sfx/Wind.mp3")] public static const WIND:Class;
		[Embed(source = "../assets/sfx/Doorslam.mp3")] public static const SLAM:Class;
		[Embed(source = "../assets/sfx/Footsteps.mp3")]public static const STEPS:Class;
		[Embed(source = "../assets/sfx/Whispering.mp3")] public static const WHISPERING:Class;
		
		//Confessions SFX
		[Embed(source="../assets/sfx/enchanting1_01.mp3")]public static const ENCHANTING_SFX_1:Class;
		[Embed(source="../assets/sfx/enchanting2_01.mp3")]public static const ENCHANTING_SFX_2:Class;
		[Embed(source="../assets/sfx/enchanting3_01.mp3")]public static const ENCHANTING_SFX_3:Class;
		[Embed(source="../assets/sfx/enchanting 4_01.mp3")] public static const ENCHANTING_SFX_4:Class;
		
		//Cursor
		[Embed(source="../assets/objs/cursor.fw.png")] public static const CURSOR_HAND:Class;
		[Embed(source = "../assets/objs/cursorClench.fw.png")] public static const CURSOR_CLENCH:Class;
		
		//Confessions sprites
		[Embed(source = "../assets/objs/Confession.fw.png")] public static const CONFESSION:Class;
		
		//ACT I and III music
		[Embed(source = "../assets/music/conversation_music_01.mp3")] public static const ACT_I_III_MUSIC:Class;
		
		//Objects Sprites
		[Embed(source = "../assets/objs/object_sprites.fw.png")] public static const OBJECTS_SPRITES:Class;
		
		//Brother Sprites
		[Embed(source = "../assets/objs/brother_sprites.fw.png")] public static const BROTHER_SPRITES:Class;
		[Embed(source = "../assets/objs/bro.fw.png")] public static const BROTHER_CONVERSATION:Class;
		
		//Perceiver smoke sprites
		[Embed(source = "../assets/objs/perceiver_smoke.fw.png")] public static const PERCEIVER_SMOKE_SPRITES:Class;
		
		//Act II room bg
		[Embed(source = "../assets/objs/room_bg.fw.png")] public static const ROOM_BG:Class;
		
		//Confession Sprites
		[Embed(source = "../assets/objs/confessions_sprites.fw.png")] public static const CONFESSIONS_SPRITES:Class;
		
		//Urn Sprites
		[Embed(source = "../assets/objs/urn_sprites.fw.png")] public static const URN_SPRITES:Class;
		
		//Incense Sprites
		[Embed(source = "../assets/objs/incense_sprites.fw.png")] public static const INCENSE_SPRITES:Class;
		
		//Coversation(Act I & III)
		[Embed(source = "../assets/objs/Conversation_Bg.fw.png")] public static const CONVERSATION_BG:Class;
		
		//Titlescreen
		[Embed(source = "../assets/objs/titlescreen.fw.png")] public static const TITLESCREEN_BG:Class;
		
		//Credits
		[Embed(source = "../assets/objs/credits_image.fw.png")] public static const CREDITS_BG:Class;
		
		//Levels
		[Embed(source = "../levels/Titlescreen.oel", mimeType = "application/octet-stream")] public static const TITLESCREEN_LEVEL:Class;
		[Embed(source = "../levels/ActII.oel", mimeType = "application/octet-stream")] public static const ACTII_LEVEL:Class;
		[Embed(source = "../levels/ActIandIII.oel", mimeType = "application/octet-stream")] public static const ACT_I_III_Level:Class;
		
		//script
		[Embed(source="../assets/Script.xml", mimeType = "application/octet-stream")] public static const SCRIPT:Class;
	}

}