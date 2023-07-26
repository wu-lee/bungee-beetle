import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.actions.FlxAction;
import flixel.input.mouse.FlxMouse;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxDirectionFlags;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import haxe.macro.Expr.Position;
import openfl.Vector;
import openfl.events.TouchEvent;

using flixel.util.FlxSpriteUtil;

enum PlayerState
{
	Hooked;
	Nothing;
	FiringHook;
}

class Player extends FlxSprite
{
	var power:Float = 100;
	var gravity = 40;
	var elasticLength:Float = 20;
	var elasticStrength:Float = 1;

	public var state = PlayerState.Nothing;

	var canShoot = true;
	var hook:Hook;
	var hspeed = 750;
	var walls:FlxTypedGroup<FlxSprite>;

	public function new(hook:Hook, walls:FlxTypedGroup<FlxSprite>, x:Float, y:Float)
	{
		super();
		var size = 24;
		// loadGraphic(AssetPaths.rocketFlame__png, true, 8, 8);
		loadGraphic("assets/images/bug.png", false, 8, 8);
		this.hook = hook;
		this.walls = walls;

		scale.x = scale.y = size / 8;
		width = size;
		height = size;
		offset.x = -size / 3;
		offset.y = -size / 3;

		moves = true;
		elasticity = 0.4;
		mass = 10;
		// maxVelocity = (200, 200);
		allowCollisions = FlxDirectionFlags.ANY;
		solid = true;
		// makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

		// var lineStyle:LineStyle = {color: FlxColor.RED, thickness: 1};
		// var drawStyle:DrawStyle = {smoothing: true};

		// var color = FlxColor.RED;
		// var lineStyle = this.drawCircle(x + radius, y + radius, radius, color, lineStyle, drawStyle);

		setPosition(x, y);
	}

	function updatedrag(elapsed)
	{
		var vdrag = .9;
		velocity *= Math.pow(vdrag, elapsed);
	}

	function elasticforce(distance:Float, lengthElastic:Float, springStrength:Float):Float
	{
		if (lengthElastic >= distance)
		{
			return 0;
		}
		else
		{
			return (distance - lengthElastic) * springStrength;
		}
	}

	public function onhooked()
	{
		state = Hooked;
	}

	function updateHooked(elapsed)
	{
		var hookPos = new FlxPoint(hook.x, hook.y);
		var radians = Math.atan2(hookPos.x - x, y - hookPos.y);
		var degryes = radians / Math.PI * 180;
		angle = degryes;
		var myPos = getPosition();
		var directionv = FlxPoint.get(hookPos.x - x, hookPos.y - y);
		var metohook = hookPos - myPos;

		if (FlxG.mouse.justPressed)
		{
			elasticLength = metohook.length;
		}

		var unit = metohook.normalize();

		velocity += elasticforce(myPos.distanceTo(hookPos), elasticLength, elasticStrength) * unit * elapsed;
		trace(velocity);

		updatedrag(elapsed);
		if (FlxG.keys.pressed.Q)
		{
			elasticLength -= 1;
		}
		if (FlxG.keys.pressed.E)
		{
			elasticLength += 1;
		}
		if (FlxG.mouse.released)
		{
			state = Nothing;
		}
	}

	function updateNothing(elapsed)
	{
		updatedrag(elapsed);
		var mousePos = FlxG.mouse.getPosition();

		var radians = Math.atan2(mousePos.x - x, y - mousePos.y);

		var degryes = radians / Math.PI * 180;
		angle = degryes;

		if (FlxG.mouse.pressed)
		{
			var a = new FlxPoint(mousePos.x - x, mousePos.y - y);
			var vel = a.normalize() * hspeed + velocity;

			hook.init(getPosition(), vel, this, 90000);
			state = FiringHook;
		}
	}

	function updateFiringHook(elapsed)
	{
		updatedrag(elapsed);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		// setPosition(x, y);
		FlxG.collide(this, walls);
		switch (state)
		{
			case Hooked:
				updateHooked(elapsed);
			case Nothing:
				updateNothing(elapsed);
			case FiringHook:
				updateFiringHook(elapsed);
		}

		acceleration.x = 0;

		if (FlxG.keys.pressed.A)
		{
			acceleration.x -= power;
		}
		if (FlxG.keys.pressed.D)
		{
			acceleration.x += power;
		}

		acceleration.y = gravity;

		if (FlxG.keys.pressed.W)
		{
			acceleration.y -= power;
		}
		if (FlxG.keys.pressed.S)
		{
			acceleration.y += power;
		}
	}
}
