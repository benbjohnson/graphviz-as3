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
		graph.addChild(node);
		Assert.assertEquals(node, graph.nodes[0]);
		Assert.assertEquals(graph, node.parent);
	}
	
	[Test]
	public function shouldRemoveNode():void
	{
		var node:Node = new Node();
		graph.addChild(node);
		graph.removeChild(node);
		Assert.assertEquals(0, graph.nodes.length);
		Assert.assertEquals(null, node.parent);
	}
	
	[Test]
	public function shouldFindDirectNode():void
	{
		graph.addChild(new Node());
		graph.addChild(new Node());
		Assert.assertEquals(graph.nodes[1], graph.findNode("node2"));
	}

	[Test]
	public function shouldFindIndirectNode():void
	{
		graph.addChild(new Node());
		graph.addChild(new Subgraph());
		graph.subgraphs[0].addChild(new Node());
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
		graph.addChild(a);
		graph.addChild(b);
		graph.addChild(edge);
		Assert.assertEquals(edge, graph.edges[0]);
		Assert.assertEquals(graph, edge.parent);
	}
	
	[Test]
	public function shouldRemoveEdge():void
	{
		var edge:Edge = new Edge(new Node(), new Node())
		graph.addChild(edge);
		graph.removeChild(edge);
		Assert.assertEquals(0, graph.edges.length);
		Assert.assertEquals(null, edge.parent);
	}
	
	[Test]
	public function shouldFindDirectEdge():void
	{
		graph.addChild(new Edge(new Node(), new Node()));
		graph.addChild(new Edge(new Node(), new Node()));
		Assert.assertEquals(graph.edges[1], graph.findEdge("node3", "node4"));
	}

	[Test]
	public function shouldFindIndirectEdge():void
	{
		graph.addChild(new Edge(new Node(), new Node()));
		graph.addChild(new Subgraph());
		graph.subgraphs[0].addChild(new Edge(new Node(), new Node()));
		Assert.assertEquals(graph.subgraphs[0].edges[0], graph.findEdge("node3", "node4"));
	}


	//---------------------------------
	//	Subgraphs
	//---------------------------------

	[Test]
	public function shouldAddSubgraph():void
	{
		var subgraph:Subgraph = new Subgraph();
		graph.addChild(subgraph);
		Assert.assertEquals(subgraph, graph.subgraphs[0]);
		Assert.assertEquals(graph, subgraph.parent);
	}
	
	[Test]
	public function shouldRemoveSubgraph():void
	{
		var subgraph:Subgraph = new Subgraph();
		graph.addChild(subgraph);
		graph.removeChild(subgraph);
		Assert.assertEquals(0, graph.subgraphs.length);
		Assert.assertEquals(null, subgraph.parent);
	}
	
	[Test]
	public function shouldFindDirectSubgraph():void
	{
		graph.addChild(new Subgraph());
		graph.addChild(new Subgraph());
		Assert.assertEquals(graph.subgraphs[1], graph.findSubgraph("subgraph2"));
	}

	[Test]
	public function shouldFindIndirectSubgraph():void
	{
		graph.addChild(new Subgraph());
		graph.subgraphs[0].addChild(new Subgraph());
		Assert.assertEquals(graph.subgraphs[0].subgraphs[0], graph.findSubgraph("subgraph2"));
	}
}
}