import Physics.velang;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.misc.AngleTween;

class Worm extends Enemy
{
	var rescale = 3;

	// public var poslist = [];

	public function new(x, y, player)
	{
		super(x, y, player);
		loadGraphic("assets/images/wrom.png", true, 8, 8);
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;

		var prev:FlxSprite = this;
		for (count in 0...3)
		{
			var wormBody = new WormBody(prev);
			children.push(wormBody);
			prev = wormBody;
		}
	}

	public override function update(elapsed:Float)
	{
		var ePos = getPosition();
		// poslist.push();
		var pPos:FlxPoint = target.getPosition(); // player pos
		var ep:FlxPoint = pPos - ePos;
		var eplen = ep;
		var unit = ep.normalize();
		var step = unit * speed;
		velocity += step;

		angle = velang(velocity);
		// update velocity with friction
		velocity *= Math.pow(vdrag, elapsed);
		super.update(elapsed);
	}
}
