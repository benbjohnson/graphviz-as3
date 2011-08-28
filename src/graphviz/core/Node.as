package graphviz.core
{
import graphviz.utils.MathUtil;

import flash.geom.Point;

/**
 *	This class represents a node in a graph.
 */
public class Node extends GraphElement
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function Node()
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
		return "node" + elementId.toString();
	}


	//----------------------------------
	//	Attributes
	//----------------------------------

	/** @private */
	override public function get attributes():Object
	{
		return {
			width:  MathUtil.round(this.width/Graph.DPI, 3),
			height: MathUtil.round(this.height/Graph.DPI, 3)
		};
	}


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
		var str:String = elementName;
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
	 *	Deserializes the node from an AST object.
	 */
	override public function deserialize(value:Object):void
	{
		super.deserialize(value);
		
		// Set position
		if(value.attributes.pos != null) {
			var arr:Array = value.attributes.pos.split(",");
			var point:Point = new Point(parseInt(arr[0]), parseInt(arr[1]));
			point = toLocal(normalizeCoord(point));
			
			// "pos" is specified as the center point. Convert to upper left.
			x = point.x - (width/2);
			y = point.y - (height/2);
		}
	}
}
}
