package;

import Level1P.Level1P;
import flixel.FlxGame;
import haxe.macro.Type.MethodKind;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(stage.stageWidth, stage.stageHeight, MenuState));
	}
}
