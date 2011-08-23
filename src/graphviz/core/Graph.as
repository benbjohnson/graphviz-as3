package graphviz.core
{
import flash.errors.IllegalOperationError;

/**
 *	This class represents a graph containing nodes, edges and subgraphs.
 */
public class Graph extends GraphBase
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function Graph()
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
		throw new IllegalOperationError();
	}


	//----------------------------------
	//	Directed
	//----------------------------------

	/**
	 *	A flag stating if the graph is a directed graph.
	 */
	public var directed:Boolean;


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------
	
	/** @private */
	override public function deserialize(value:Object):void
	{
	}
}
}
