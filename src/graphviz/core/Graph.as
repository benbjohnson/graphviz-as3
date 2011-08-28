package graphviz.core
{
import graphviz.filesystem.Dot;

import flash.errors.IllegalOperationError;
import flash.events.Event;

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
	 *	The DPI used for all graphs.
	 */
	static public const DPI:Number = 72.0;
	
	
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


	//----------------------------------
	//	Attributes
	//----------------------------------

	/** @private */
	override public function get attributes():Object
	{
		return {
			dpi: DPI
		};
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//	Layout
	//----------------------------------

	/**
	 *	Lays out the graph and its children.
	 */
	public function layout():void
	{
		var dot:Dot = new Dot(this);
		dot.addEventListener(Event.COMPLETE,
			function(event:Event):void{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		);
		dot.execute();
	}
}
}
