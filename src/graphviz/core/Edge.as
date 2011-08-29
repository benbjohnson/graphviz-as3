package graphviz.core
{
import flash.geom.Point;
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


	//----------------------------------
	//	Path
	//----------------------------------

	/**
	 *	A series of points to draw for the edge.
	 */
	public var path:Array = [];


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Serialization
	//----------------------------------

	/** @private */
	override public function serialize():String
	{
		var str:String = "";
		str += tail.elementName;
		str += (directed ? " -> " : " -- ");
		str += head.elementName;

		var attr:String = serializeAttributes();
		if(attr) {
			str += " [" + attr + "]";
		}
		str += ";";

		return str;
	}


	//----------------------------------
	//	Deserialization
	//----------------------------------

	/**
	 *	Deserializes the edge from an AST object.
	 */
	override public function deserialize(value:Object):void
	{
		super.deserialize(value);
		
		// Parse position
		var point:Point;
		if(value.attributes.pos != null) {
			var arr:Array = value.attributes.pos.split(" ");
			
			// If end point is specified at the beginning, move it to the end
			if(arr[0].search(/^e,/) != -1) {
				arr[0] = arr[0].replace(/^e,/, "");
				arr.push(arr.shift());
			}
			
			// Convert each item to a point
			var path:Array = arr.map(function(item:String,...args):Point{
				var xy:Array = item.split(/,/);
				return normalizeCoord(new Point(Math.round(parseFloat(xy[0])), Math.round(parseFloat(xy[1]))));
			});
			
			// Find min x,y
			var min:Point = new Point(100000, 100000);
			for each(point in path) {
				min.x = Math.min(min.x, point.x);
				min.y = Math.min(min.y, point.y);
			}
			
			// Set position relative to min point
			min = toLocal(min);
			x = min.x;
			y = min.y;
			
			// Convert path points to local
			this.path = path.map(function(item:Point,...args):Point{
				return toLocal(item);
			});
		}
	}
}
}
