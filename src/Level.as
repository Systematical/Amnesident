package
{
	import flash.display.Sprite;
    import org.flixel.*;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
	import org.flixel.system.FlxList;
	
    public class Level extends FlxState
    {
		
		public var title:FlxText;
		public var originalItemsList:Array;
		public var items:Array;
		public var story:Story;
		public var itemText:FlxText;

		public var itemBox:FlxSprite;
		public var itemBox2:FlxSprite;
		public var itemBox3:FlxSprite;
		public var itemBox4:FlxSprite;
		public var itemBoxes:Array;
		public var numBoxes:int;

		[Embed(source = "/assets/art/textboxLevel.png")] public var textboxLevel:Class;

		public function Level(itemlist:Array)
		{
			
			originalItemsList = itemlist;
			
			items = chooseRandomItems(itemlist);
			
			if (items[0] != null) {
				items[0].x = 0;
				items[0].y = 480 - items[0].height;
				add(items[0]);
			}

			if (items[1] != null) {
				items[1].x = Amnesident.slotSize;
				items[1].y = 480 - items[1].height;
				add(items[1]);
			}

			if (items[2] != null) {
				items[2].x = Amnesident.slotSize * 2;
				items[2].y = 480 - items[2].height;
				add(items[2]);
			}

			if (items[3] != null) {
				items[3].x = Amnesident.slotSize * 3;
				items[3].y = 480 - items[3].height;
				add(items[3]);
			}

			title = new FlxText(300, 0, 100, "Level");
			title.size = 20;
			itemText = new FlxText(300, 30, 500, "Try clicking on an item!");
			
			itemBox = new FlxSprite(295, 25);	
			itemBox2 = new FlxSprite(295, 47);			
			itemBox3 = new FlxSprite(295, 69);	
			itemBox4 = new FlxSprite(295, 81);
			
			itemBoxes = [itemBox, itemBox2, itemBox3, itemBox4];
			for each (var itembox:FlxSprite in itemBoxes) {
				itembox.loadGraphic(textboxLevel, true, true, 300, 22);
				itembox.addAnimation("idle", [0]);
			}
			add(itemBox);
			add(title);
			add(itemText);
			
			var debugText:FlxText = new FlxText(300, 100, 500, "Press g to return to the hallway!");
			add(debugText);
		}
		
		public function chooseRandomItems(itemlist:Array):Array
		{
			//minimum number of items is 1
			var numItems:int = Math.floor(Math.random() * 4) + 1;
			
			var resultingItems:Array = new Array(null, null, null, null);
			var randomIndexes:Array = new Array();
			var space:Array = new Array(1, 1, 1, 1);

			var maxTries:int = 100;
			var numTries:int = 0;
			var i:int = 0;
			while (i < numItems && numTries < maxTries) {
				numTries++;

				var idx:int = Math.floor(Math.random() * itemlist.length);
				var itm:Item = itemlist[idx];
				var gap:int = 0;
				var fittable:Boolean = false;

				for (var j:int = 0; j < space.length; j++) {
					if (space[j]) {
						gap++;
						if (gap >= itm.slots) {
							fittable = true;
						}
					} else {
						gap = 0;
					}
				}

				if (!fittable) {
					continue;
				}

				var fit:int = 0;
				var tarSlot:int;

				while (!fit) {
					tarSlot = Math.floor(Math.random() * 4)

					fit = 1;
					for (var idx:int = tarSlot;
						idx < tarSlot + itm.slots;
						idx++) {

						fit &= space[idx];
					}
				}

				for (var idx:int = tarSlot;
					idx < tarSlot + itm.slots;
					idx++) {

					space[idx] = 0;
				}

				i++;
				resultingItems[tarSlot] = itm;
			}

			return resultingItems;
		}
		
		override public function update():void
		{
			if (FlxG.keys.G) {
				var hospitalHallway:Hallway = new Hallway(Amnesident.doorPic, 5, 0);
				FlxG.switchState(hospitalHallway);
			}
			
			//onClick() is called on each item that is clicked.
			for each (var item:Item in items) {
				if(item != null){
					if (item.justClicked()) {
						remove(itemText);
						for each (var sp:FlxSprite in itemBoxes) {
							remove(sp);
						}			
						//item.onClick() will return a string and you can manage that string in the level state
						itemText = new FlxText(300, 30, 300, item.onClick());
						itemText.setFormat(null, 13, 0x0000000, "left");				
						var textheight:int = itemText.height;
						numBoxes = (int) ((textheight / 22) + 1);
					}
				}
			}
			var num:int = 0;
			for each (var s:FlxSprite in itemBoxes) {
				if (num < numBoxes) { add(s);}
				num++;
			}
			
			add(itemText);
			// switch to End Screen when press ESCAPE 
			if (FlxG.keys.ESCAPE) {
				var end:EndGame = new EndGame();
				end.addSummary("It has been ", "2 years");
				end.addSummary("The world", "has been destroyed");
				FlxG.switchState(end);
			}
		}
		
		public function insertTextBox(text:FlxText):Array {
			// textboxLevel is 300x22
			var textheight:int = text.height;
			var numBoxes:int = 3; // (int) (textheight / 22);
			trace("Number of boxes used: " + numBoxes.toString());
			var sprites:Array = new Array();;
			var i:int;
			
			for (i = 0; i++; i < numBoxes + 3) {
				var sprite:FlxSprite = new FlxSprite(300, 22 * i);
				sprite.loadGraphic(textboxLevel, true, true, 300, 22);
				sprite.addAnimation("idle", [0]);				
				sprites.push(sprite);
			}
			
			trace("Size of sprites" + sprites.length.toString());
			return sprites;
		}
    }
}
