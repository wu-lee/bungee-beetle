import Physics.velang;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class WormBody extends FlxSprite
{
	var target:FlxSprite;
	var elasticLength = 1;
	var elasticStrength = 120;
	var rescale = 3;

	public function new(target:FlxSprite)
	{
		super();
		this.target = target;

		loadGraphic("assets/images/wrom.png", true, 8, 8);
		animation.add("body", [1], 1, false);
		animation.play("body");
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;
		x = target.x;
		y = target.y;
	}

	public override function update(elapsed)
	{
		super.update(elapsed);

		var ePos = getPosition();

		var pPos:FlxPoint = target.getPosition(); // player pos

		var ep:FlxPoint = pPos - ePos;
		var eplen = ep;
		var unit = ep.normalize();
		var step = unit * 10;
		velocity += step;

		angle = velang(velocity);
		// update velocity with friction

		velocity *= Math.pow(0.4, elapsed);
	}
}
