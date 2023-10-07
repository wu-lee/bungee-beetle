import BasePlayState.Spawn;
import BasePlayState.SpawnType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.display.Display.Package;
import haxe.macro.Expr.Case;
import lime.tools.Platform;
import openfl.errors.Error;
import openfl.geom.Point;

abstract class Enemy extends FlxSprite
{
	var speed:Int;
	var target:Player;
	var vdrag = 0.1;

	// Children is used if an enemy uses more than 1 sprite. Like the worm has the segments as it children.
	// these are simply sprites that are added the the play state when the map is made with makeLevel.
	public var children:Array<FlxSprite> = [];

	public static function makeEnemy(type:SpawnType, x:Float, y:Float, player:Player, difficulty:Difficulty):Enemy
	{
		var speed:Int;
		switch (difficulty)
		{
			case Easy:
				speed = 2;
			case Normal:
				speed = 4;
			case Hard:
				speed = 6;
			default:
				throw new Error("unknown difficulty");
		}

		return switch (type)
		{
			case Worm(length):
				new Worm(x, y, player, length, speed);
			case BadFly:
				new BadFly(x, y, player, speed);
			case Rock:
				new Rock(x, y, player, speed);
			default:
				throw new Error("unknown spawn type '$type'");
		}
	}

	public function new(x:Float, y:Float, target:Player, speed:Int)
	{
		super();
		this.target = target;
		this.speed = speed;
		this.x = x;
		this.y = y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// restes level when you touch enemy
		if (this.overlaps(target))
		{
			FlxG.resetState();
		}
	}
}
