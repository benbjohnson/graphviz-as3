package graphviz.core
{
import asunit.framework.Assert;

public class GraphTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	private var graph:Graph;
	
	[Before]
	public function setup():void
	{
		GraphElement.resetId();
		graph = new Graph();
	}


	//---------------------------------------------------------------------
	//
	//  Tests
	//
	//---------------------------------------------------------------------
	
	//----------------------------------
	//	Serialization
	//----------------------------------
	
	[Test]
	public function shouldSerializeUndirectedGraphOnly():void
	{
		graph.directed = false;
		Assert.assertEquals(
			"graph {\n" +
			"}",
			graph.serialize()
		);
	}
	
	[Test]
	public function shouldSerializeDirectedGraphOnly():void
	{
		graph.directed = true;
		Assert.assertEquals(
			"digraph {\n" +
			"}",
			graph.serialize()
		);
	}
	
	[Test]
	public function shouldSerializeWithChildren():void
	{
		graph.directed = true;
		
		var subgraph:Subgraph = new Subgraph();
		subgraph.addNode(new Node());
		subgraph.addNode(new Node());
		subgraph.addNode(new Node());
		subgraph.addEdge(new Edge(subgraph.nodes[0], subgraph.nodes[1], true));
		subgraph.addEdge(new Edge(subgraph.nodes[0], subgraph.nodes[2], false));
		graph.addSubgraph(subgraph);
		
		graph.addNode(new Node());
		graph.addNode(new Node());
		graph.addEdge(new Edge(graph.nodes[0], graph.nodes[1]));

		Assert.assertEquals(
			"digraph {\n" +
			"  subgraph subgraph1 {\n" +
			"    node2;\n" +
			"    node3;\n" +
			"    node4;\n" +
			"    node2 -> node3;\n" +
			"    node2 -- node4;\n" +
			"  }\n" +
			"  node5;\n" +
			"  node6;\n" +
			"  node5 -- node6;\n" +
			"}",
			graph.serialize()
		);
	}
}
}