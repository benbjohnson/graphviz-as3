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
			dpi: "72"
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
				trace("from dot complete");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		);
		dot.execute();
	}
	

	//----------------------------------
	//	Serialization
	//----------------------------------
	
	/** @private */
	override public function deserialize(value:Object):void
	{
		trace("deserialize: " + value);
	}
}
}
