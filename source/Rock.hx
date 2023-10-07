import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import openfl.display.SpreadMethod;

class Rock extends Enemy
{
	var rescale = 3;

	public function new(x:Float, y:Float, player:Player, speed:Int)
	{
		super(x, y, player, speed);
		loadGraphic("assets/images/rock.png", true, 8, 8);

		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;
	}

	public override function update(elapsed:Float)
	{
		velocity.y += speed * 2;
		angle += 1;

		if (y > FlxG.height)
		{
			y = 0 - height;
			x = target.x + target.velocity.x + speed;
			if (x > FlxG.width - 8)
			{
				x = target.x;
			};
			else if (x < 8)
			{
				x = target.x;
			};
			else {};
		}

		// update velocity with friction
		velocity *= Math.pow(vdrag, elapsed);

		super.update(elapsed);
	}
}
