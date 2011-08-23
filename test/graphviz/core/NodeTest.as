package graphviz.core
{
import asunit.framework.Assert;

public class NodeTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	private var node:Node;
	
	[Before]
	public function setup():void
	{
		node = new Node();
		GraphElement.resetId();
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
	public function shouldSerialize():void
	{
		Assert.assertEquals("node1;", node.serialize());
	}
}
}