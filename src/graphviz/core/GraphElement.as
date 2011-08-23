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
	static private var currentId:uint = 0;

	/** @private */
	static public function resetId():void
	{
		currentId = 0;
	}
	
	
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
	 *	Serializes all properties in the attributes object into a string of
	 *	comma-separated, double-quote qualified key value pairs.
	 */
	protected function serializeAttributes(attributes:Object):String
	{
		var arr:Array = [];
		for(var key:String in attributes) {
			arr.push(key + "=\"" + attributes[key].replace("\"", "\\\"") + "\"");
		}
		return (arr.length ? arr.join(", ") : null);
	}

	/**
	 *	Deserializes the node from an AST object.
	 */
	public function deserialize(value:Object):void
	{
	}
}
}
