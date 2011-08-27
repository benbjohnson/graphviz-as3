package graphviz.core
{
import flash.display.Sprite;
import flash.geom.Point;

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


	//----------------------------------
	//	Attributes
	//----------------------------------

	/**
	 *	A hash of key/value pairs representing attributes on this element.
	 */
	public function get attributes():Object
	{
		return {};
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Dimensions
	//----------------------------------

	/**
	 *	Converts a local point to the absolute position within the graph.
	 *
	 *	@param point  The local point on this element.
	 *
	 *	@return       The absolute position for a point within the whole graph.
	 */
	public function toGlobal(point:Point):Point
	{
		var ret:Point = new Point(point.x, point.y);
		var element:GraphElement = this;
		while(element.graph) {
			ret.x += element.x;
			ret.y += element.y;
			element = element.graph;
		}
		return ret;
	}
	
	/**
	 *	Converts a global point within the graph to a local point on this element.
	 *
	 *	@param point  The global point on the graph.
	 *
	 *	@return       The local position for a point within this element.
	 */
	public function toLocal(point:Point):Point
	{
		var ret:Point = new Point(point.x, point.y);
		var element:GraphElement = this;
		while(element.graph) {
			ret.x -= element.x;
			ret.y -= element.y;
			element = element.graph;
		}
		return ret;
	}
	


	//----------------------------------
	//	Serialization
	//----------------------------------

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
	protected function serializeAttributes():String
	{
		var arr:Array = [];
		var attributes:Object = this.attributes;
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
