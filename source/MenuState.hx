package;

// Update imports
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var _btnPlay:FlxButton;
	var _btnNormalMode:FlxButton;
	var _btnHardmode:FlxButton;

	override public function create():Void
	{
		// Initilize new button
		var title = new flixel.text.FlxText(10, 0, 0, "Bungee Beetle Escape", 40);
		var instructions1 = new flixel.text.FlxText(10, 60, 0,
			"Escape the under ground tunnels by grappling your way to the exit.\n"
			+ "HOW TO GRAPPLE:\n"
			+ "First point your cursor where you want your grapple to go, then click the left mouse button\n"
			+ "and hold to fire your hook and grapple on to a wall.\n"
			+ "Release the left mouse button to release grappling.",
			11);

		add(instructions1);

		add(title);

		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter(); // Align at the center
		add(_btnPlay);
		super.create();
	}

	// Play button is clicked
	function clickPlay():Void
	{
		// Switched state from current to PlayState
		FlxG.switchState(new Level1P());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
