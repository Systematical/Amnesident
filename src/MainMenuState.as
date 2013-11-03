package  
{
	import org.flixel.*;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class MainMenuState extends FlxState 
	{
		[Embed(source = 'graybox.png')] public static var grayBox:Class;
		
		//Use this command to set the default cursor png...
		//[Embed(source = "cursor.png")] private var ImgCursor:Class;
		
		public var title:FlxText;
		public var level1:Level;
		
		public function MainMenuState() 
		{
			//Use FlxG.mouse.show(ImgCursor, 16, 16) to show the custom cursor image
			FlxG.mouse.show();
			
			
			level1 = new Level(new Item(grayBox, 32, 32, "What an exquisite gray box! :)"));

			title = new FlxText(300, 0, 100, "Amnesident!!");
			add(title);
		}

		override public function update():void
		{
			if (FlxG.keys.ONE) {
				FlxG.switchState(level1);
			}
		}
	}
}
