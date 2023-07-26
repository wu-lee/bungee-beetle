package;

import Player.PlayerState;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.graphics.frames.FlxFilterFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalMouseWheel;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSplash;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import haxe.io.Output;
import haxe.macro.Compiler.IncludePosition;
import lime.math.ColorMatrix;
import lime.utils.PackedAssetLibrary;
import openfl.errors.Error;
import openfl.ui.Keyboard;
import sys.ssl.Key;
import sys.thread.ElasticThreadPool;

using flixel.util.FlxSpriteUtil;

typedef Wall = Array<Int>;

typedef Level =
{
	public var walls:Array<Wall>;
	public var spawns:Array<FlxPoint>;
	public var doors:Array<FlxPoint>;
	public var player:FlxPoint;
}

class PlayState extends FlxState
{
	static var outerWallwidth = 80;
	static var innerWallWidth = 15;

	var player:Player;
	var hook:Hook;
	var line:FlxSprite;
	var grpWalls:FlxTypedGroup<FlxSprite> = null;
	var enemy:Enemy;
	var door:Door;
	var map:FlxOgmo3Loader;
	var tiles:FlxTilemap;
	var level1:Level = {
		walls: [
			[0, FlxG.height - 120, FlxG.width - 120, innerWallWidth],
			[0, 120, FlxG.width - 120, innerWallWidth],
			[FlxG.width - 300, 250, FlxG.width - 300, innerWallWidth],
		],
		spawns: [FlxPoint.get(50, FlxG.height - 50)],
		doors: [FlxPoint.get(50, 50)],
		player: FlxPoint.get(50, FlxG.height - 50),
	};

	function makewall(x, y, width:Int, height:Int, color:FlxColor)
	{
		var wall = new FlxSprite(x, y);
		wall.makeGraphic(width, height, color);
		wall.immovable = true;
		grpWalls.add(wall);
	}

	function makeLevel(level:Level)
	{
		if (level.walls == null)
		{
			throw new Error("walls can't be null");
		}

		makewall(0, -outerWallwidth + innerWallWidth, FlxG.width, outerWallwidth, FlxColor.GREEN); // top

		makewall(0, FlxG.height - innerWallWidth, FlxG.width, outerWallwidth, FlxColor.GREEN); // bottom

		makewall(-outerWallwidth + innerWallWidth, 0, outerWallwidth, FlxG.height, FlxColor.GREEN); // left

		makewall(FlxG.width - innerWallWidth, 0, outerWallwidth, FlxG.height, FlxColor.GREEN); // right
		for (i in level.walls)
		{
			makewall(i[0], i[1], i[2], i[3], FlxColor.GREEN);
		}

		player = new Player(hook, grpWalls, level.player.x, level.player.y);
		add(player);
		enemy = new Enemy(player);
		add(enemy);
		for (i in level.doors)
		{
			door = new Door(i.x, i.y, enemy, Math.floor(player.width), Math.floor(player.height));
		}
		add(door);
	}

	override public function create()
	{
		super.create();

		grpWalls = new FlxTypedGroup<FlxSprite>();
		FlxG.mouse.useSystemCursor = true;
		hook = new Hook(grpWalls);

		hook.kill();
		line = new FlxSprite();

		bgColor = FlxColor.BROWN;

		makeLevel(level1);

		line.makeGraphic(FlxG.width, FlxG.height, 0, true);
		add(line);
		add(hook);
		add(grpWalls);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		player.update(elapsed);

		FlxSpriteUtil.fill(line, 0);

		if (player.state == Hooked)
		{
			FlxSpriteUtil.drawLine(line, player.x + player.width / 2, player.y + player.height / 2, hook.x, hook.y);
		}
	}
}
