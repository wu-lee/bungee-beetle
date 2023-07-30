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
import openfl.text.AntiAliasType;
import openfl.ui.Keyboard;
import sys.ssl.Key;
import sys.thread.ElasticThreadPool;

using flixel.util.FlxSpriteUtil;

enum SpawnType
{
	BadFly;
	Worm;
	//	Rock;
	// spike;
}

typedef Wall = Array<Int>;

typedef Spawn =
{
	public var pos:FlxPoint;
	public var type:SpawnType;
}

typedef LevelMap =
{
	public var walls:Array<Wall>;

	public var spawns:Array<Spawn>;
	public var doors:Array<FlxPoint>;
	public var player:FlxPoint;
}

abstract class BasePlayState extends FlxState
{
	public static var outerWallwidth = 80;
	public static var innerWallWidth = 15;

	var player:Player;
	var hook:Hook;
	var line:FlxSprite;
	var grpWalls:FlxTypedGroup<FlxSprite> = null;
	var enemys:Array<FlxSprite> = [];
	var doors:Array<Door> = [];

	abstract function getMap():LevelMap;

	function makewall(x, y, width:Int, height:Int, color:FlxColor)
	{
		var wall = new FlxSprite(x, y);
		wall.makeGraphic(width, height, color);
		wall.immovable = true;
		grpWalls.add(wall);
	}

	function makeLevel(level:LevelMap)
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

		for (spawn in level.spawns)
		{
			var enemy = Enemy.makeEnemy(spawn.type, spawn.pos.x, spawn.pos.y, player);

			enemys.push(enemy);
			add(enemy);
		}

		for (i in level.doors)
		{
			var door = new Door(i.x, i.y, player, Math.floor(player.width), Math.floor(player.height));
			doors.push(door);
			add(door);
		}
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

		makeLevel(getMap());

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
