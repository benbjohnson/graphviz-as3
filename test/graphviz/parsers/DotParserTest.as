package graphviz.parsers
{
import asunit.framework.Assert;

public class DotParserTest
{
	//---------------------------------------------------------------------
	//
	//  Static Constants
	//
	//---------------------------------------------------------------------
	
	[Embed("/assets/dot/graph.gv", mimeType="application/octet-stream")]
	static private const GRAPH_DOT:Class;

	[Embed("/assets/dot/subgraph.gv", mimeType="application/octet-stream")]
	static private const SUBGRAPH_DOT:Class;

	[Embed("/assets/dot/node.gv", mimeType="application/octet-stream")]
	static private const NODE_DOT:Class;

	[Embed("/assets/dot/edge.gv", mimeType="application/octet-stream")]
	static private const EDGE_DOT:Class;

	
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------

	private var parser:DotParser;
	
	[Before]
	public function setup():void
	{
		parser = new DotParser();
	}


	//---------------------------------------------------------------------
	//
	//  Tests
	//
	//---------------------------------------------------------------------
	
	//---------------------------------
	//	Parse
	//---------------------------------

	[Test]
	public function shouldParseGraph():void
	{
		var data:Object = parser.parse((new GRAPH_DOT()).toString());
		Assert.assertEquals("GRAPH", data.type);
		Assert.assertEquals(false, data.directed);
		Assert.assertEquals("72", data.attributes.dpi);
		Assert.assertEquals("0,0,216,401", data.attributes.bb);
		Assert.assertEquals("c 9 -#ffffffff C 9 -#ffffffff P 4 0 -1 0 401 217 401 217 -1 ", data.attributes._draw_);
		Assert.assertEquals("1.2", data.attributes.xdotversion);
	}

	[Test]
	public function shouldParseSubgraph():void
	{
		var data:Object = parser.parse((new SUBGRAPH_DOT()).toString());
		Assert.assertEquals(1, data.children.length);
		Assert.assertEquals("SUBGRAPH", data.children[0].type);
		Assert.assertEquals("72", data.children[0].attributes.dpi);
	}

	[Test]
	public function shouldParseNodes():void
	{
		var data:Object = parser.parse((new NODE_DOT()).toString());
		Assert.assertEquals(2, data.children.length);

		Assert.assertEquals("NODE", data.children[0].type);
		Assert.assertEquals("foo", data.children[0].id);
		Assert.assertEquals("63,308", data.children[0].attributes.pos);

		Assert.assertEquals("NODE", data.children[1].type);
		Assert.assertEquals("bar", data.children[1].id);
		Assert.assertEquals("baz", data.children[1].attributes.label);
	}

	[Test]
	public function shouldParseEdges():void
	{
		var data:Object = parser.parse((new EDGE_DOT()).toString());
		Assert.assertEquals(5, data.children.length);

		Assert.assertEquals("EDGE", data.children[3].type);
		Assert.assertEquals("foo", data.children[3].tail);
		Assert.assertEquals("bar", data.children[3].head);
		Assert.assertEquals(true, data.children[3].directed);
		Assert.assertEquals("2,34", data.children[3].attributes.pos);

		Assert.assertEquals("EDGE", data.children[4].type);
		Assert.assertEquals("bar", data.children[4].tail);
		Assert.assertEquals("baz", data.children[4].head);
		Assert.assertEquals(false, data.children[4].directed);
		Assert.assertEquals("100,200", data.children[4].attributes.pos);
	}
}
}