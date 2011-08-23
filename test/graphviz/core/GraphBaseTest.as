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
}
}