package graphviz.mxml
{
import graphviz.core.Graph;

import mx.core.IMXMLObject;

[DefaultProperty("graph")]	
public class GraphDeclaration implements IMXMLObject
{
	public var graph:Graph;
	
	public function initialized(document:Object, id:String):void
	{
	}
}
}