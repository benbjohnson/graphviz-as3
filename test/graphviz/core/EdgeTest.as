package graphviz.core
{
import asunit.framework.Assert;

public class EdgeTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	private var edge:Edge;
	private var tail:Node;
	private var head:Node;
	
	[Before]
	public function setup():void
	{
		GraphElement.resetId();
		tail = new Node();
		head = new Node();
		edge = new Edge(tail, head);
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
	public function shouldSerializeUndirected():void
	{
		edge.directed = false;
		Assert.assertEquals("node1 -- node2;", edge.serialize());
	}
	
	[Test]
	public function shouldSerializeDirected():void
	{
		edge.directed = true;
		Assert.assertEquals("node1 -> node2;", edge.serialize());
	}
}
}