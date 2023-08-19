import flixel.math.FlxPoint;

class CircularBuffer<Item>
{
	public var pointer = 0;

	var arr:Array<Item>;

	public function new(size:Int, item:Item)
	{
		pointer = 0;
		arr = [for (i in 0...size) item];
	}

	public function getItem():Item
	{
		if (pointer < arr.length - 1)
		{
			return arr[pointer + 1];
		}
		else
		{
			return arr[0];
		}
	}

	public function push(item:Item)
	{
		pointer += 1;
		if (pointer > arr.length - 1)
		{
			pointer = 0;
		}
		arr[pointer] = item;
	}
}
