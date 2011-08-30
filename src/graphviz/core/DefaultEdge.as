package graphviz.core
{
import flash.display.LineScaleMode;
import flash.display.CapsStyle;

/**
 *	This class represents an edge that draws according to the element's draw
 *	commands.
 */
public class DefaultEdge extends Edge
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function DefaultEdge(tail:Node=null, head:Node=null,
								directed:Boolean=false)
	{
		super(tail, head, directed);
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Drawing
	//----------------------------------

	/** @private */
	override public function draw():void
	{
		super.draw();
		graphics.lineStyle(1, 0x000000, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE);
		drawPath();
		executeDrawCommands(tailDrawCommands);
		executeDrawCommands(headDrawCommands);
	}
}
}
