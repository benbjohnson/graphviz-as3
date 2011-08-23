package graphviz.core
{
import flash.errors.IllegalOperationError;

/**
 *	This class represents an edge in a graph.
 */
public class Edge extends GraphElement
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function Edge(tail:Node=null, head:Node=null, directed:Boolean=false)
	{
		super();
		this.tail = tail;
		this.head = head;
		this.directed = directed;
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
	//	Nodes
	//----------------------------------

	/**
	 *	The node positioned at the tail of the edge.
	 */
	public var tail:Node;

	/**
	 *	The node positioned at the head of the edge.
	 */
	public var head:Node;


	//----------------------------------
	//	Directed
	//----------------------------------

	/**
	 *	A flag stating if the edge is directed (has an arrowhead) from the tail
	 *	node to the head node.
	 */
	public var directed:Boolean;
}
}
