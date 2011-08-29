package graphviz.core
{
import flash.geom.Point;

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
	//	Positioning
	//----------------------------------
	
	[Test]
	public function shouldConvertLocalToGlobalPoint():void
	{
		var point:Point = new Point(10, 20);
		var graph:Graph = new Graph();
		var subgraph:Subgraph = new Subgraph();
		graph.addChild(subgraph);
		subgraph.addChild(node);
		
		graph.x = 30;
		graph.y = 40;
		subgraph.x = 50;
		subgraph.y = 60;
		node.x = 70;
		node.y = 80;

		point = node.toGlobal(point);
		Assert.assertEquals(130, point.x);
		Assert.assertEquals(160, point.y);
	}

	[Test]
	public function shouldConvertGlobalToLocalPoint():void
	{
		var point:Point = new Point(130, 160);
		var graph:Graph = new Graph();
		var subgraph:Subgraph = new Subgraph();
		graph.addChild(subgraph);
		subgraph.addChild(node);
		
		graph.x = 30;
		graph.y = 40;
		subgraph.x = 50;
		subgraph.y = 60;
		node.x = 70;
		node.y = 80;

		point = node.toLocal(point);
		Assert.assertEquals(10, point.x);
		Assert.assertEquals(20, point.y);
	}


	//----------------------------------
	//	Serialization
	//----------------------------------
	
	[Test]
	public function shouldSerialize():void
	{
		node.width = 54;
		node.height = 23;
		Assert.assertEquals("node1 [height=\"0.319\", width=\"0.75\"];", node.serialize());
	}


	//----------------------------------
	//	Deserialization
	//----------------------------------
	
	[Test]
	public function shouldDeserializePosition():void
	{
		var graph:Graph = new Graph();
		var subgraph:Subgraph = new Subgraph();
		var node:Node = new Node();
		node.width = 4;
		node.height = 6;
		graph.addChild(subgraph);
		subgraph.addChild(node);
		
		graph.deserialize({
			type:'GRAPH',
			attributes:{bb:"0,0,100,100"},
			children:[
				{
					type:'SUBGRAPH',
					id:subgraph.elementName,
					attributes:{bb:"10,20,80,60"},
					children:[
						{
							type:'NODE',
							id:node.elementName,
							attributes:{pos:"20,30"}
						}
					]
				}
			]
		});

		Assert.assertEquals(8, node.x);
		Assert.assertEquals(27, node.y);
	}
}
}