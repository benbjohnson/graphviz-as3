package graphviz.core
{
import flash.events.EventDispatcher;

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
	//	Nodes
	//----------------------------------

	private var _nodes:Array = [];

	/**
	 *	A list of nodes on the graph.
	 */
	public function get nodes():Array
	{
		return _nodes.slice();
	}


	//----------------------------------
	//	Edges
	//----------------------------------

	private var _edges:Array = [];

	/**
	 *	A list of edges on the graph.
	 */
	public function get edges():Array
	{
		return _edges.slice();
	}


	//----------------------------------
	//	Subgraphs
	//----------------------------------

	private var _subgraphs:Array = [];

	/**
	 *	A list of subgraphs on the graph.
	 */
	public function get subgraphs():Array
	{
		return _subgraphs.slice();
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
	 *	Adds a node to the graph.
	 *
	 *	@param node  The node to add.
	 */
	public function addNode(node:Node):void
	{
		if(_nodes.indexOf(node) == -1) {
			node.graph = this;
			_nodes.push(node);
		}
	}

	/**
	 *	Removes a node from the graph.
	 *
	 *	@param node  The node to remove.
	 */
	public function removeNode(node:Node):void
	{
		var index:int = _nodes.indexOf(node);
		if(index != -1) {
			node.graph = null;
			_nodes.splice(index, 1);
		}
	}

	/**
	 *	Removes all nodes from the graph.
	 */
	public function removeAllNodes():void
	{
		var nodes:Array = this.nodes;
		for each(var node:Node in nodes) {
			removeNode(node);
		}
	}


	//---------------------------------
	//	Edges
	//---------------------------------

	/**
	 *	Adds an edge to the graph.
	 *
	 *	@param edge  The edge to add.
	 */
	public function addEdge(edge:Edge):void
	{
		if(_edges.indexOf(edge) == -1) {
			edge.graph = this;
			_edges.push(edge);
		}
	}

	/**
	 *	Removes a edge from the graph.
	 *
	 *	@param edge  The edge to remove.
	 */
	public function removeEdge(edge:Edge):void
	{
		var index:int = _edges.indexOf(edge);
		if(index != -1) {
			edge.graph = null;
			_edges.splice(index, 1);
		}
	}

	/**
	 *	Removes all edges from the graph.
	 */
	public function removeAllEdges():void
	{
		var edges:Array = this.edges;
		for each(var edge:Edge in edges) {
			removeEdge(edge);
		}
	}


	//---------------------------------
	//	Subgraphs
	//---------------------------------

	/**
	 *	Adds a subgraph to the graph.
	 *
	 *	@param subgraph  The subgraph to add.
	 */
	public function addSubgraph(subgraph:Subgraph):void
	{
		if(_subgraphs.indexOf(subgraph) == -1) {
			subgraph.graph = this;
			_subgraphs.push(subgraph);
		}
	}

	/**
	 *	Removes a subgraph from the graph.
	 *
	 *	@param subgraph  The subgraph to remove.
	 */
	public function removeSubgraph(subgraph:Subgraph):void
	{
		var index:int = _subgraphs.indexOf(subgraph);
		if(index != -1) {
			subgraph.graph = null;
			_subgraphs.splice(index, 1);
		}
	}

	/**
	 *	Removes all subgraphs from the graph.
	 */
	public function removeAllSubgraphs():void
	{
		var subgraphs:Array = this.subgraphs;
		for each(var subgraph:Subgraph in subgraphs) {
			removeSubgraph(subgraph);
		}
	}


	//---------------------------------
	//	Serialization
	//---------------------------------

	/** @private */
	override public function serialize():String
	{
		var arr:Array = [];

		if(this is Graph) {
			arr.push(((this as Graph).directed ? "digraph" : "graph") + " {");
		}
		else {
			arr.push("subgraph " + elementName + " {");
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
}
}
