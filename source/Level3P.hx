package;

import BasePlayState.LevelMap;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.debug.Window;

class Level3P extends BasePlayState
{
	var map:BasePlayState.LevelMap = {
		walls: [
			[0, (FlxG.height - 160), FlxG.width - 300, BasePlayState.innerWallWidth],
			[
				FlxG.width - 200,
				(FlxG.height - 124),
				FlxG.width - 300,
				BasePlayState.innerWallWidth
			],
			[120, (FlxG.height - 80), FlxG.width - 120, BasePlayState.innerWallWidth],
			[120, 120, FlxG.width - 280, BasePlayState.innerWallWidth],
			// [340, 220, BasePlayState.innerWallWidth, FlxG.height - 340],
			[440, 120, BasePlayState.innerWallWidth, FlxG.height - 240],
			[325, 190, BasePlayState.innerWallWidth, (FlxG.height - 335)],
			[120, 175, BasePlayState.innerWallWidth, (FlxG.height - 320)],
			[325, 0, BasePlayState.innerWallWidth, (85)],
			[120, 0, BasePlayState.innerWallWidth, (85)],
		],
		spawns: [
			{
				pos: FlxPoint.get(0, FlxG.height),
				type: Rock,
			},
		],
		doors: [{pos: FlxPoint.get(FlxG.width - 50, 300), levelName: EndState}],
		player: FlxPoint.get(FlxG.width - 50, FlxG.height - 50),
	};

	function getMap():BasePlayState.LevelMap
	{
		return map;
	}
}
