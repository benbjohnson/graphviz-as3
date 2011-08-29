package graphviz.core
{
/**
 *	This class represents a subgraph within another graph.
 */
public class Subgraph extends GraphBase
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function Subgraph()
	{
		super();
	}


	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Element name
	//----------------------------------

	/** @private */
	override public function get elementName():String
	{
		return "cluster_subgraph" + elementId.toString();
	}


	//----------------------------------
	//	Attributes
	//----------------------------------

	/** @private */
	override public function get attributes():Object
	{
		return {
		};
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
		
		graphics.lineStyle(1, 0x000000, 0.5);
		graphics.drawRect(0, 0, width, height);
	}
}
}
