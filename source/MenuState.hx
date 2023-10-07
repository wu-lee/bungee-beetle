package;

// Update imports
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var _btnEasyMode:FlxButton;
	var _btnNormalMode:FlxButton;
	var _btnHardMode:FlxButton;

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

		_btnEasyMode = new FlxButton(FlxG.width / 2 + 100, FlxG.height / 2 - 50, "Easy Mode", easyMode);
		_btnNormalMode = new FlxButton(FlxG.width / 2 + 100, FlxG.height / 2, "Normal Mode", normalMode);
		_btnHardMode = new FlxButton(FlxG.width / 2 + 100, FlxG.height / 2 + 50, "Hard Mode", hardMode);
		add(_btnEasyMode);
		add(_btnNormalMode);
		add(_btnHardMode);

		super.create();
	}

	function easyMode():Void
	{
		BasePlayState.difficulty = Easy;
		// Switched state from current to PlayState
		FlxG.switchState(new Level1P());
	}

	function normalMode():Void
	{
		BasePlayState.difficulty = Normal;
		// Switched state from current to PlayState
		FlxG.switchState(new Level3P());
	}

	function hardMode():Void
	{
		BasePlayState.difficulty = Hard;
		// Switched state from current to PlayState
		FlxG.switchState(new Level1P());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
