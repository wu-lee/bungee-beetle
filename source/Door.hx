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
	var enemy:Enemy;

	public function new(x:Float, y:Float, enemy, width:Int, height:Int)
	{
		super();
		makeGraphic(width + 3, height + 3, FlxColor.BLACK);

		this.x = x;
		this.y = y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
