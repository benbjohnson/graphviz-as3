package graphviz.core
{
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.GraphicsEndFill;
import flash.display.IGraphicsData;

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
		var commands:Vector.<IGraphicsData> = element.parseDrawCommand("P 3 0 0 100 0 50 100")
		var command:GraphicsPath = commands[0] as GraphicsPath;
		Assert.assertEquals(1, commands.length);
		Assert.assertEquals(8, command.data.length);
	}

	[Test]
	public function shouldParsePolyline():void
	{
		var commands:Vector.<IGraphicsData> = element.parseDrawCommand("L 3 0 0 100 0 50 100")
		var command:GraphicsPath = commands[0] as GraphicsPath;
		Assert.assertEquals(1, commands.length);
		Assert.assertEquals(6, command.data.length);
	}

	[Test]
	public function shouldParseFillColor():void
	{
		var commands:Vector.<IGraphicsData> = element.parseDrawCommand("C 9 -#ff000080")
		var command:GraphicsSolidFill = commands[0] as GraphicsSolidFill;
		Assert.assertEquals(2, commands.length);
		Assert.assertEquals(0xFF0000, command.color);
		Assert.assertEquals(0.5, command.alpha);
	}

	[Test]
	public function shouldParsePenColor():void
	{
		var commands:Vector.<IGraphicsData> = element.parseDrawCommand("c 9 -#ff000080")
		var command:GraphicsStroke = commands[0] as GraphicsStroke;
		Assert.assertEquals(1, commands.length);
		Assert.assertTrue(command is GraphicsStroke);
		Assert.assertEquals(0xFF0000, (command.fill as GraphicsSolidFill).color);
		Assert.assertEquals(0.5, (command.fill as GraphicsSolidFill).alpha);
	}
}
}