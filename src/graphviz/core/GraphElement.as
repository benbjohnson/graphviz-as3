package graphviz.core
{
import flash.display.Sprite;

/**
 *	This class represents the base class for all elements on a graph.
 */
public class GraphElement extends Sprite
{
	//--------------------------------------------------------------------------
	//
	//	Static Variables
	//
	//--------------------------------------------------------------------------
	
	/** @private */
	static public var currentId:uint = 0;
	
	
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function GraphElement()
	{
		super();
	}


	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Graph
	//----------------------------------
	
	/**
	 *	The graph this element belongs to.
	 */
	public var graph:GraphBase;


	//----------------------------------
	//	Element identifier
	//----------------------------------
	
	private var _elementId:uint = 0;
	
	/**
	 *	The unique identifier assigned to this element.
	 */
	public function get elementId():uint
	{
		if(_elementId == 0) {
			_elementId = ++GraphElement.currentId;
		}
		return _elementId;
	}
	
	
	//----------------------------------
	//	Element name
	//----------------------------------

	/**
	 *	The unique name of this element in the exported DOT file.
	 */
	public function get elementName():String
	{
		return null;
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *	Serializes the element into a DOT string format.
	 */
	public function serialize():String
	{
		return "";
	}
	
	/**
	 *	Deserializes the node from a DOT formatted string.
	 */
	public function deserialize(value:String):void
	{
	}
}
}
