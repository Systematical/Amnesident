package 
{
	import org.flixel.*;	
	public class Door extends FlxSprite {
		public function Door(X:Number, Y:Number, image:Class, room:Number) {
			super(X, Y, image);
			solid = false;
		}
		
		//Returns true if the item was just clicked.
		public function justClicked():Boolean
		{
			if (FlxG.mouse.justReleased()) {
				var mousePoint:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				if (this.overlapsPoint(mousePoint)) {
					trace("poop");
					return true;
				}
			}
			return false;
		}
	}
}