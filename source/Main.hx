package;

import Level1P.Level1P;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(stage.stageWidth, stage.stageHeight, Level1P));
	}
}
