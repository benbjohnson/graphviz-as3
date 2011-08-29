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


	//----------------------------------
	//	Deserialization
	//----------------------------------
	
	[Test]
	public function shouldDeserializePoints():void
	{
		var graph:Graph = new Graph();
		var subgraph:Subgraph = new Subgraph();
		graph.addChild(subgraph);

		var node1:Node = new Node();
		node1.width = 4;
		node1.height = 6;
		subgraph.addChild(node1);
		
		var node2:Node = new Node();
		node2.width = 4;
		node2.height = 6;
		subgraph.addChild(node2);
		
		var edge:Edge = new Edge(node1, node2, true);
		subgraph.addChild(edge);
		
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
							id:node1.elementName,
							attributes:{pos:"20,30"}
						},
						{
							type:'NODE',
							id:node2.elementName,
							attributes:{pos:"40,60"}
						},
						{
							type:'EDGE',
							tail:node1.elementName,
							head:node2.elementName,
							attributes:{pos:"e,38,57 22,33 38,33"}
						}
					]
				}
			]
		});

		Assert.assertEquals(12, edge.x);
		Assert.assertEquals(3, edge.y);
	}
}
}