package;

import BasePlayState.LevelMap;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.debug.Window;

class Level2P extends BasePlayState
{
	var map:BasePlayState.LevelMap = {
		walls: [
			[120, 220, BasePlayState.innerWallWidth, FlxG.height - (340)],
			[120, 0, BasePlayState.innerWallWidth, 120],
			[120, 120, 220, BasePlayState.innerWallWidth],
			[120, 220, 220, BasePlayState.innerWallWidth],
			[120, (FlxG.height - 340) + 220, FlxG.width - 120, BasePlayState.innerWallWidth],
			[340, 220, BasePlayState.innerWallWidth, FlxG.height - 340],
			[340, 0, BasePlayState.innerWallWidth, 120 + BasePlayState.innerWallWidth],
			[440, 0, BasePlayState.innerWallWidth, 300],
		],
		spawns: [
			{
				pos: FlxPoint.get(0, 0),
				type: Worm(35),
			},
		],
		doors: [{pos: FlxPoint.get(FlxG.width - 50, 50), levelName: Level1P}],
		player: FlxPoint.get(FlxG.width - 100, FlxG.height - 50),
	};

	function getMap():BasePlayState.LevelMap
	{
		return map;
	}
}
