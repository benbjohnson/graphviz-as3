package graphviz.utils
{
/**
 *	This class provides math helper methods.
 */
public class MathUtil
{
	//-------------------------------------------------------------------------
	//
	//  Static methods
	//
	//-------------------------------------------------------------------------

	/**
	 *	Rounds a number with a given number of decimal places.
	 */
	static public function round(value:Number, precision:int):Number
	{
		var pow:Number = Math.pow(10, precision);
		return Math.round(value * pow) / pow;
	}
}
}