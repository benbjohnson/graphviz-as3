package graphviz.core
{
/**
 *	This class represents a subgraph that draws according to the element's draw
 *	commands.
 */
public class DefaultSubgraph extends Subgraph
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function DefaultSubgraph()
	{
		super();
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
