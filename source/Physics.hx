import flixel.math.FlxAngle;
import flixel.math.FlxPoint;

// this function calculates the elastic force made by a piece of elastic
// distance: to the end of the elastic
// ogLength: of the orinanal piece of elastic
// strength: strength of the piece of elastic
function elasticforce(distance:Float, ogLength:Float, strength:Float):Float
{
	if (ogLength >= distance)
	{
		return 0;
	}
	else
	{
		return (distance - ogLength) * strength;
	}
}

function velang(velocity:FlxPoint):Float
{
	var rad = Math.atan2(velocity.x, -velocity.y);
	return rad / (2 * Math.PI) * 360;
}
