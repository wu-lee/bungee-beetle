import Physics.velang;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.misc.AngleTween;

class Worm extends Enemy
{
	var rescale = 3;
	var posarr:CircularBuffer<FlxPoint>;
	var length:Int;

	// public var poslist = [];

	public function new(x, y, player, length:Int)
	{
		super(x, y, player);
		loadGraphic("assets/images/wrom.png", true, 8, 8);
		this.length = length;

		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;

		vdrag = 0.2;

		posarr = new CircularBuffer<FlxPoint>(8, getPosition());

		var prev:CircularBuffer<FlxPoint> = posarr;
		for (count in 0...length)
		{
			var wormBody = new WormBody(prev, player);
			children.push(wormBody);
			prev = wormBody.posarr;
		}
	}

	public override function update(elapsed:Float)
	{
		var ePos = getPosition();

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

		posarr.push(getPosition());
	}
}
