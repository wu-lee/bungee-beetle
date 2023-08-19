import Physics.velang;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxParticle;
import flixel.math.FlxPoint;
import lime.graphics.Image;

class WormBody extends FlxSprite
{
	var target:CircularBuffer<FlxPoint>;
	var elasticLength = 1;
	var elasticStrength = 120;
	var rescale = 3;
	var mypos = FlxPoint.get(0, 0);
	var player:FlxSprite;

	public var posarr:CircularBuffer<FlxPoint>;

	public function new(target:CircularBuffer<FlxPoint>, player:FlxSprite)
	{
		super();
		this.target = target;
		this.player = player;
		posarr = new CircularBuffer<FlxPoint>(7, getPosition());
		immovable = true;

		loadGraphic("assets/images/wrom.png", true, 8, 8);
		animation.add("body", [1], 1, false);
		animation.play("body");
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;
		var tpos = target.getItem();
		x = tpos.x;
		y = tpos.y;
	}

	public override function update(elapsed)
	{
		super.update(elapsed);
		var mypos = getPosition();
		posarr.push(mypos);
		FlxG.collide(this, player);

		var tpos = target.getItem();
		var tang = tpos - mypos;
		setPosition(tpos.x, tpos.y);

		// var pPos:FlxPoint = target.getPosition(); // player pos

		angle = velang(tang);

		velocity *= Math.pow(0.4, elapsed);
	}
}
