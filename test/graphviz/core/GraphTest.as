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
			"  subgraph subgraph1 {\n" +
			"    node2 [height=\"0\", width=\"0\"];\n" +
			"    node3 [height=\"0\", width=\"0\"];\n" +
			"    node4 [height=\"0\", width=\"0\"];\n" +
			"    node2 -> node3;\n" +
			"    node2 -- node4;\n" +
			"  }\n" +
			"  node5 [height=\"0\", width=\"0\"];\n" +
			"  node6 [height=\"0\", width=\"0\"];\n" +
			"  node5 -- node6;\n" +
			"}",
			graph.serialize()
		);
	}
}
}