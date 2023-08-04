import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.GraphicVirtualInput;
import flixel.util.FlxColor;
import hl.Abstract;
import lime.tools.Platform;
import openfl.geom.Point;
import openfl.utils.Object;

class Door extends FlxSprite
{
	var player:Player;
	var rescale = 3;
	var destination:BasePlayState;

	public function new(x:Float, y:Float, player:Player, width:Int, height:Int, destinationLevel:BasePlayState)
	{
		super();

		loadGraphic("assets/images/exit sign.png", false, 16, 16);
		this.scale.x = this.scale.y = rescale;
		width *= rescale;
		height *= rescale;

		this.destination = destinationLevel;
		this.player = player;
		this.x = x;
		this.y = y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.overlaps(player))
		{
			FlxG.switchState(destination);
		}
	}
}
