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
			"  graph [dpi=\"72\", pad=\"0\", splines=\"polyline\"];\n" +
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
			"  graph [dpi=\"72\", pad=\"0\", splines=\"polyline\"];\n" +
			"}",
			graph.serialize()
		);
	}
	
	[Test]
	public function shouldSerializeWithChildren():void
	{
		graph.directed = true;
		
		var subgraph:Subgraph = new Subgraph();
		subgraph.addChild(new Node());
		subgraph.addChild(new Node());
		subgraph.addChild(new Node());
		subgraph.addChild(new Edge(subgraph.nodes[0], subgraph.nodes[1], true));
		subgraph.addChild(new Edge(subgraph.nodes[0], subgraph.nodes[2], false));
		graph.addChild(subgraph);
		
		graph.addChild(new Node());
		graph.addChild(new Node());
		graph.addChild(new Edge(graph.nodes[0], graph.nodes[1]));

		Assert.assertEquals(
			"digraph {\n" +
			"  graph [dpi=\"72\", pad=\"0\", splines=\"polyline\"];\n" +
			"  subgraph cluster_subgraph2 {\n" +
			"    node3 [height=\"0\", label=\"\", shape=\"box\", width=\"0\"];\n" +
			"    node4 [height=\"0\", label=\"\", shape=\"box\", width=\"0\"];\n" +
			"    node5 [height=\"0\", label=\"\", shape=\"box\", width=\"0\"];\n" +
			"    node3 -> node4;\n" +
			"    node3 -- node5;\n" +
			"  }\n" +
			"  node8 [height=\"0\", label=\"\", shape=\"box\", width=\"0\"];\n" +
			"  node9 [height=\"0\", label=\"\", shape=\"box\", width=\"0\"];\n" +
			"  node8 -- node9;\n" +
			"}",
			graph.serialize()
		);
	}
}
}