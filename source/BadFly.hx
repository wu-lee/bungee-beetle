import flixel.math.FlxPoint;
import openfl.display.SpreadMethod;

class BadFly extends Enemy
{
	var rescale = 3;

	public function new(x:Float, y:Float, player:Player, speed:Int)
	{
		super(x, y, player, speed);
		loadGraphic("assets/images/badfly.png", true, 8, 8);

		animation.add("fly", [0, 1, 2], 12);
		animation.play("fly");
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;
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
		// update velocity with friction
		velocity *= Math.pow(vdrag, elapsed);

		super.update(elapsed);
	}
}
