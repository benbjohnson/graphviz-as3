package graphviz.core
{
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.errors.IllegalOperationError;

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
		_elementId = ++GraphElement.currentId;
	}


	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Width
	//----------------------------------

	private var _width:Number = 0;

	/** @private */
	override public function get width():Number
	{
		return _width;
	}

	override public function set width(value:Number):void
	{
		_width = value;
	}


	//----------------------------------
	//	Height
	//----------------------------------

	private var _height:Number = 0;

	/** @private */
	override public function get height():Number
	{
		return _height;
	}

	override public function set height(value:Number):void
	{
		_height = value;
	}


	//----------------------------------
	//	Graph
	//----------------------------------

	/**
	 *	The top level graph this element belongs to.
	 */
	public function get graph():Graph
	{
		var parent:DisplayObjectContainer = this;
		while(parent) {
			if(parent is Graph) {
				return parent as Graph;
			}
			parent = parent.parent;
		}
		return null;
	}


	//----------------------------------
	//	Element identifier
	//----------------------------------
	
	private var _elementId:uint = 0;
	
	/**
	 *	The unique identifier assigned to this element.
	 */
	public function get elementId():uint
	{
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
	//	Drawing
	//----------------------------------

	/**
	 *	Invalidates the element so that it can be redrawn on the next frame.
	 */
	public function invalidate():void
	{
		addEventListener(Event.ENTER_FRAME, onInvalidate);
	}
	
	/**
	 *	Draws the element to the screen. This method is overridden by the
	 *	subclass. This method should not be called directly. Calling invalidate()
	 *	will manage the drawing of elements.
	 */
	public function draw():void
	{
		graphics.clear();
	}


	//----------------------------------
	//	Position
	//----------------------------------

	/**
	 *	Converts a DOT coordinate (lower-left) to a Flash
	 *	coordinate (upper-left). The element must be attached to a graph when
	 *	this method is called.
	 *
	 *	@param point  The DOT formatted coordinate.
	 *
	 *	@return       The Flash formatted coordinate.
	 */
	public function normalizeCoord(point:Point):Point
	{
		var graph:Graph = this.graph;
		if(graph) {
			return new Point(point.x, graph.height-point.y);
		}
		return null;
	}

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
		while(element.parent is GraphElement) {
			ret.x += element.x;
			ret.y += element.y;
			element = element.parent as GraphElement;
			
			// Only return global point if this element is attached to a graph.
			if(element is Graph) {
				return ret;
			}
		}
		
		throw new IllegalOperationError("Element is not attached to a graph");
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
		while(element.parent is GraphElement) {
			ret.x -= element.x;
			ret.y -= element.y;
			element = element.parent as GraphElement;

			// Only return local point if this element is attached to a graph.
			if(element is Graph) {
				return ret;
			}
		}
		
		throw new IllegalOperationError("Element is not attached to a graph");
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

		var key:String;
		var keys:Array = [];
		for(key in attributes) {
			keys.push(key);
		}
		
		keys.sort();
		for each(key in keys) {
			arr.push(key + "=\"" + attributes[key].toString().replace("\"", "\\\"") + "\"");
		}

		return (arr.length ? arr.join(", ") : null);
	}


	//----------------------------------
	//	Deserialization
	//----------------------------------

	/**
	 *	Deserializes the node from an AST object.
	 */
	public function deserialize(value:Object):void
	{
	}


	//--------------------------------------------------------------------------
	//
	//	Events
	//
	//--------------------------------------------------------------------------

	private function onInvalidate(event:Event):void
	{
		removeEventListener(Event.ENTER_FRAME, onInvalidate);
		draw();
	}
}
}
