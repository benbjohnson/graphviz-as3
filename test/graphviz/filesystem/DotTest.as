package graphviz.filesystem
{
import graphviz.core.Graph;
import graphviz.core.GraphElement;

import asunit.framework.Assert;
import asunit.framework.IAsync;

import flash.events.Event;

public class DotTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------
	
	[Inject]
	public var async:IAsync;
	
	private var graph:Graph;
	private var dot:Dot;
	
	[Before]
	public function setup():void
	{
		GraphElement.resetId();
		graph = new Graph();
		dot   = new Dot(graph);
	}


	//---------------------------------------------------------------------
	//
	//  Tests
	//
	//---------------------------------------------------------------------
	
	[Test]
	public function shouldExecute():void
	{
		async.proceedOnEvent(dot, Event.COMPLETE, 2000);
		dot.execute();
	}
}
}