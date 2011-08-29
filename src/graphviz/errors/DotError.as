package graphviz.errors
{
/**
 *	This class represents an error thrown by DOT.
 */
public class DotError extends Error
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function DotError(message:String="", id:int=0)
	{
		super(message, id);
	}
}
}
