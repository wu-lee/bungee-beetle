package;

// Update imports
import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;

class EndState extends BasePlayState
{
	var _btnPlay:FlxButton;

	var map:BasePlayState.LevelMap = {
		walls: [],
		spawns: [],
		doors: [],
		player: FlxPoint.get(50, FlxG.height - 50),
	};

	function getMap():BasePlayState.LevelMap
	{
		return map;
	}

	override public function create():Void
	{
		// Initilize new button
		var title = new flixel.text.FlxText(10, 0, 0, "you escaped!!!", 40);

		add(title);

		_btnPlay = new FlxButton(0, 0, "restart", clickPlay);
		_btnPlay.screenCenter(); // Align at the center
		add(_btnPlay);
		super.create();
	}

	// Play button is clicked
	function clickPlay():Void
	{
		// Switched state from current to PlayState
		FlxG.switchState(new MenuState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
