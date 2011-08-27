package graphviz.core
{
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


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------
	
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
}
}
