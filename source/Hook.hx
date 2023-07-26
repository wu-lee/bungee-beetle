import Player.PlayerState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import openfl.geom.Point;
import openfl.utils.Object;

class Hook extends FlxSprite
{
	var walls:Object;
	var player:Player;
	var boolcollided = false;

	public function new(walls)
	{
		super();
		this.walls = walls;
		var size = 12;
		var gfxsize = 4;
		var hitboxsize = 2;
		var scalefactor = size / gfxsize;
		loadGraphic("assets/images/hook.png", false, gfxsize, gfxsize);
		scale.x = scale.y = scalefactor;
		width = hitboxsize * scalefactor;
		height = hitboxsize * scalefactor;

		// offset.x = size / 2;
		// offset.y = size / 2;
	}

	public function init(pos:FlxPoint, vel:FlxPoint, player:Player, angvel:Int)
	{
		reset(pos.x, pos.y);
		velocity = vel;
		angularVelocity = angvel;
		this.player = player;
	}

	function hascollided(hook, walls)
	{
		velocity = new FlxPoint(0, 0);
		angularVelocity = 0;
		boolcollided = true;
		player.onhooked();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(this, walls, hascollided);
		if (isOnScreen() == false)
		{
			player.state = Nothing;
		}
		var vdrag = 0.9;
		velocity *= Math.pow(vdrag, elapsed);
		if (boolcollided = false)
		{
			acceleration.y = 100;
		}
	}
}
