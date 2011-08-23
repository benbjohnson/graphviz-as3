package graphviz.core
{
import asunit.framework.Assert;

public class GraphBaseTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	private var graph:GraphBase;
	
	[Before]
	public function setup():void
	{
		GraphElement.resetId();
		graph = new GraphBase();
	}


	//---------------------------------------------------------------------
	//
	//  Tests
	//
	//---------------------------------------------------------------------
	
	//---------------------------------
	//	Nodes
	//---------------------------------

	[Test]
	public function shouldAddNode():void
	{
		var node:Node = new Node();
		graph.addNode(node);
		Assert.assertEquals(node, graph.nodes[0]);
		Assert.assertEquals(graph, node.graph);
	}
	
	[Test]
	public function shouldRemoveNode():void
	{
		var node:Node = new Node();
		graph.addNode(node);
		graph.removeNode(node);
		Assert.assertEquals(0, graph.nodes.length);
		Assert.assertEquals(null, node.graph);
	}
	
	[Test]
	public function shouldRemoveAllNodes():void
	{
		graph.addNode(new Node());
		graph.addNode(new Node());
		graph.removeAllNodes();
		Assert.assertEquals(0, graph.nodes.length);
	}
	
	[Test]
	public function shouldFindDirectNode():void
	{
		graph.addNode(new Node());
		graph.addNode(new Node());
		Assert.assertEquals(graph.nodes[1], graph.findNode("node2"));
	}

	[Test]
	public function shouldFindIndirectNode():void
	{
		graph.addNode(new Node());
		graph.addSubgraph(new Subgraph());
		graph.subgraphs[0].addNode(new Node());
		Assert.assertEquals(graph.subgraphs[0].nodes[0], graph.findNode("node2"));
	}


	//---------------------------------
	//	Edges
	//---------------------------------

	[Test]
	public function shouldAddEdge():void
	{
		var a:Node = new Node();
		var b:Node = new Node();
		var edge:Edge = new Edge(a, b)
		graph.addNode(a);
		graph.addNode(b);
		graph.addEdge(edge);
		Assert.assertEquals(edge, graph.edges[0]);
		Assert.assertEquals(graph, edge.graph);
	}
	
	[Test]
	public function shouldRemoveEdge():void
	{
		var edge:Edge = new Edge(new Node(), new Node())
		graph.addEdge(edge);
		graph.removeEdge(edge);
		Assert.assertEquals(0, graph.edges.length);
		Assert.assertEquals(null, edge.graph);
	}
	
	[Test]
	public function shouldRemoveAllEdges():void
	{
		graph.addEdge(new Edge(new Node(), new Node()));
		graph.addEdge(new Edge(new Node(), new Node()));
		graph.removeAllEdges();
		Assert.assertEquals(0, graph.edges.length);
	}
	
	[Test]
	public function shouldFindDirectEdge():void
	{
		graph.addEdge(new Edge(new Node(), new Node()));
		graph.addEdge(new Edge(new Node(), new Node()));
		Assert.assertEquals(graph.edges[1], graph.findEdge("node3", "node4"));
	}

	[Test]
	public function shouldFindIndirectEdge():void
	{
		graph.addEdge(new Edge(new Node(), new Node()));
		graph.addSubgraph(new Subgraph());
		graph.subgraphs[0].addEdge(new Edge(new Node(), new Node()));
		Assert.assertEquals(graph.subgraphs[0].edges[0], graph.findEdge("node3", "node4"));
	}


	//---------------------------------
	//	Subgraphs
	//---------------------------------

	[Test]
	public function shouldAddSubgraph():void
	{
		var subgraph:Subgraph = new Subgraph();
		graph.addSubgraph(subgraph);
		Assert.assertEquals(subgraph, graph.subgraphs[0]);
		Assert.assertEquals(graph, subgraph.graph);
	}
	
	[Test]
	public function shouldRemoveSubgraph():void
	{
		var subgraph:Subgraph = new Subgraph();
		graph.addSubgraph(subgraph);
		graph.removeSubgraph(subgraph);
		Assert.assertEquals(0, graph.subgraphs.length);
		Assert.assertEquals(null, subgraph.graph);
	}
	
	[Test]
	public function shouldRemoveAllSubgraphs():void
	{
		graph.addSubgraph(new Subgraph());
		graph.addSubgraph(new Subgraph());
		graph.removeAllSubgraphs();
		Assert.assertEquals(0, graph.subgraphs.length);
	}

	[Test]
	public function shouldFindDirectSubgraph():void
	{
		graph.addSubgraph(new Subgraph());
		graph.addSubgraph(new Subgraph());
		Assert.assertEquals(graph.subgraphs[1], graph.findSubgraph("subgraph2"));
	}

	[Test]
	public function shouldFindIndirectSubgraph():void
	{
		graph.addSubgraph(new Subgraph());
		graph.subgraphs[0].addSubgraph(new Subgraph());
		Assert.assertEquals(graph.subgraphs[0].subgraphs[0], graph.findSubgraph("subgraph2"));
	}
}
}