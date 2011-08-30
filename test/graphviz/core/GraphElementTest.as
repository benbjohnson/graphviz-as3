package graphviz.core
{
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.GraphicsEndFill;

import asunit.framework.Assert;

public class GraphElementTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	private var graph:Graph;
	private var element:GraphElement;
	
	[Before]
	public function setup():void
	{
		GraphElement.resetId();
		graph = new Graph();
		graph.width  = 100;
		graph.height = 100;
		element = new GraphElement();
		graph.addChild(element);
	}


	//---------------------------------------------------------------------
	//
	//  Tests
	//
	//---------------------------------------------------------------------
	
	//----------------------------------
	//	Parsing
	//----------------------------------
	
	[Test]
	public function shouldParsePolygon():void
	{
		var commands:Array = element.parseDrawCommand("P 3 0 0 100 0 50 100")
		Assert.assertEquals(1, commands.length);
		Assert.assertTrue(commands[0] is GraphicsPath);
		Assert.assertEquals(8, commands[0].data.length);
	}

	[Test]
	public function shouldParsePolyline():void
	{
		var commands:Array = element.parseDrawCommand("L 3 0 0 100 0 50 100")
		Assert.assertEquals(1, commands.length);
		Assert.assertTrue(commands[0] is GraphicsPath);
		Assert.assertEquals(6, commands[0].data.length);
	}

	[Test]
	public function shouldParseFillColor():void
	{
		var commands:Array = element.parseDrawCommand("C 9 -#ff000080")
		Assert.assertEquals(1, commands.length);
		Assert.assertTrue(commands[0] is GraphicsSolidFill);
		Assert.assertEquals(0xFF0000, commands[0].color);
		Assert.assertEquals(0.5, commands[0].alpha);
	}

	[Test]
	public function shouldParsePenColor():void
	{
		var commands:Array = element.parseDrawCommand("c 9 -#ff000080")
		Assert.assertEquals(1, commands.length);
		Assert.assertTrue(commands[0] is GraphicsStroke);
		Assert.assertEquals(0xFF0000, commands[0].fill.color);
		Assert.assertEquals(0.5, commands[0].fill.alpha);
	}
}
}