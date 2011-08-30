package graphviz.core
{
/**
 *	This class represents a node that draws according to the element's draw
 *	commands.
 */
public class DefaultNode extends Node
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function DefaultNode(width:Number=0, height:Number=0)
	{
		super(width, height);
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Drawing
	//----------------------------------

	/** @private */
	override public function draw():void
	{
		super.draw();
		executeDrawCommands(drawCommands);
	}
}
}
