import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import lime.tools.Platform;
import openfl.geom.Point;

class Enemy extends FlxSprite
{
	var rescale = 3;
	var speed = 10;
	var target:Player;
	var vdrag = 0.1;

	public function new(x:Float, y:Float, target:Player)
	{
		super();
		makeGraphic(5, 5, FlxColor.RED);
		loadGraphic("assets/images/badfly.png", true, 8, 8);

		animation.add("fly", [0, 1, 2], 12);
		animation.play("fly");
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;
		this.target = target;

		this.x = x;
		this.y = y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var ePos = getPosition();
		var pPos:FlxPoint = target.getPosition(); // player pos
		var ep:FlxPoint = pPos - ePos;
		var eplen = ep;
		var unit = ep.normalize();
		var step = unit * speed;

		velocity += step;
		// update velocity with friction
		velocity *= Math.pow(vdrag, elapsed);

		// restes level when you touch enemy
		if (this.overlaps(target))
		{
			FlxG.resetState();
			// target.hurt(1);
		}
	}
}
