package graphviz.core
{
import flash.events.EventDispatcher;
import flash.display.DisplayObject;
import flash.geom.Point;

/**
 *	This class contains the base functionality for all graphs and subgraphs.
 */
public class GraphBase extends GraphElement
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function GraphBase()
	{
		super();
	}


	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Children
	//----------------------------------

	/**
	 *	A list of all direct graph element children in this graph.
	 */
	public function get children():Array
	{
		var children:Array = [];
		for(var i:int=0; i<numChildren; i++) {
			var child:DisplayObject = getChildAt(i);
			if(child is GraphElement) {
				children.push(getChildAt(i));
			}
		}
		return children;
	}

	/**
	 *	A list of nodes on the graph.
	 */
	public function get nodes():Array
	{
		return children.filter(
			function(item:DisplayObject,...args):Boolean{
				return item is Node;
			}
		);
	}

	/**
	 *	A list of edges on the graph.
	 */
	public function get edges():Array
	{
		return children.filter(
			function(item:DisplayObject,...args):Boolean{
				return item is Edge;
			}
		);
	}

	/**
	 *	A list of subgraphs on the graph.
	 */
	public function get subgraphs():Array
	{
		return children.filter(
			function(item:DisplayObject,...args):Boolean{
				return item is Subgraph;
			}
		);
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//---------------------------------
	//	Nodes
	//---------------------------------

	/**
	 *	Recursively searches the graph hierarchy for a node with a given name.
	 *
	 *	@param name  The element name of the node.
	 */
	public function findNode(name:String):Node
	{
		var node:Node;
		
		// Search direct children
		var nodes:Array = this.nodes;
		for each(node in nodes) {
			if(node.elementName == name) {
				return node;
			}
		}
		
		// Search nodes in subgraphs
		var subgraphs:Array = this.subgraphs;
		for each(var subgraph:Subgraph in subgraphs) {
			node = subgraph.findNode(name);
			if(node) {
				return node;
			}
		}
		
		return null;
	}


	//---------------------------------
	//	Edges
	//---------------------------------

	/**
	 *	Recursively searches the graph hierarchy for an edge.
	 *
	 *	@param tail  The element name of the tail node.
	 *	@param head  The element name of the head node.
	 */
	public function findEdge(tail:String, head:String):Edge
	{
		var edge:Edge;
		
		// Search direct children
		var edges:Array = this.edges;
		for each(edge in edges) {
			edge.tail.elementName;
			edge.head.elementName;

			if(edge.tail.elementName == tail && edge.head.elementName == head) {
				return edge;
			}
		}
		
		// Search edges in subgraphs
		var subgraphs:Array = this.subgraphs;
		for each(var subgraph:Subgraph in subgraphs) {
			edge = subgraph.findEdge(tail, head);
			if(edge) {
				return edge;
			}
		}
		
		return null;
	}


	//---------------------------------
	//	Subgraphs
	//---------------------------------

	/**
	 *	Recursively searches the graph hierarchy for a subgraph with a given name.
	 *
	 *	@param name  The element name of the subgraph.
	 */
	public function findSubgraph(name:String):Subgraph
	{
		// Search direct subgraphs
		var subgraphs:Array = this.subgraphs;
		for each(var subgraph:Subgraph in subgraphs) {
			if(subgraph.elementName == name) {
				return subgraph;
			}
			
			// Search children
			var child:Subgraph = subgraph.findSubgraph(name);
			if(child) {
				return child;
			}
		}
		
		return null;
	}


	//---------------------------------
	//	Serialization
	//---------------------------------

	/** @private */
	override public function serialize():String
	{
		var arr:Array = [];

		// Initial graph keyword
		if(this is Graph) {
			arr.push(((this as Graph).directed ? "digraph" : "graph") + " {");
		}
		else {
			arr.push("subgraph " + elementName + " {");
		}

		// Serialize attributes within graph
		var attr:String = serializeAttributes();
		if(attr) {
			arr.push(indent("graph [" + attr + "];"));
		}

		// Serialize children
		for each(var subgraph:Subgraph in subgraphs) {
			arr.push(indent(subgraph.serialize()));
		}
		for each(var node:Node in nodes) {
			arr.push(indent(node.serialize()));
		}
		for each(var edge:Edge in edges) {
			arr.push(indent(edge.serialize()));
		}

		// Closing brace
		arr.push("}");
		
		return arr.join("\n");
	}
	
	private function indent(value:String):String
	{
		return value.replace(/^/gm, "  ");
	}


	//----------------------------------
	//	Deserialization
	//----------------------------------

	/** @private */
	override public function deserialize(value:Object):void
	{
		// Set bounding box
		if(attributes.bb != null) {
			var arr:Array = attributes.bb.split(",").map(function(item:String,...args):int{return parseInt(item)});
			var point:Point = new Point(parseInt(arr[0]), parseInt(arr[3]));
			point = toLocal(point);
			x = point.x;
			y = point.y;
		}
	}
}
}
