package;

import flixel.FlxG;
import flixel.math.FlxPoint;

class Level1P extends BasePlayState
{
	var map:BasePlayState.LevelMap = {
		walls: [
			[0, FlxG.height - 120, FlxG.width - 120, BasePlayState.innerWallWidth],
			[0, 120, FlxG.width - 120, BasePlayState.innerWallWidth],
			[FlxG.width - 300, 250, FlxG.width - 300, BasePlayState.innerWallWidth],
		],
		spawns: [
			{
				pos: FlxPoint.get(100, 20),
				type: BadFly,
			},
		],
		doors: [{pos: FlxPoint.get(50, FlxG.height - 50), levelName: Level2P}],
		player: FlxPoint.get(50, FlxG.height - 50),
	};

	function getMap():BasePlayState.LevelMap
	{
		return map;
	}
}
