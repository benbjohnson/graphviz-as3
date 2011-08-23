package graphviz.parsers
{
/**
 *	This class represents a parser for XDOT files.
 */
public class DotParser
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *	Constructor.
	 */
	public function DotParser()
	{
		super();
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Parse
	//----------------------------------

	/**
	 *	Parses a DOT file into an AST.
	 */
	public function parse(content:String):Object
	{
		// Initialize parsing helpers
		var root:Object;
		var stack:Array = [];
		
		// Convert DOT file to an easily parsable file.
		content = normalize(content);
		
		// Loop over lines and construct AST
		var lines:Array = content.split(/\n/);
		for each(var line:String in lines) {
			var match:Array;
			var obj:Object;

			// GRAPH
			if((match = line.match(/^(graph|digraph) *\{$/))) {
				root = {
					type:"GRAPH",
					directed:(match[1]=="digraph"),
					attributes:{},
					children:[]
				};
				stack.push(root);
			}
			// SUBGRAPH
			else if((match = line.match(/^subgraph +(\w+) *\{$/))) {
				obj = {
					type:"SUBGRAPH",
					id:match[1],
					attributes:{},
					children:[]
				};
				stack[stack.length-1].children.push(obj);
				stack.push(obj);
			}
			// GRAPH ATTRIBUTES
			else if((match = line.match(/^graph\s*\[(.+?)\];$/))) {
				obj = stack[stack.length-1];
				parseAttributes(obj, match[1]);
			}
			// NODE ATTRIBUTES
			else if((match = line.match(/^node\s*\[(.+?)\];$/))) {
				// DO NOTHING FOR NOW
			}
			// EDGE ATTRIBUTES
			else if((match = line.match(/^edge\s*\[(.+?)\];$/))) {
				// DO NOTHING FOR NOW
			}
			// NODE
			else if((match = line.match(/^(\w+)(?:\s*\[(.+?)\])?;$/))) {
				obj = {type:"NODE", id:match[1], attributes:{}};
				parseAttributes(obj, match[2]);
				stack[stack.length-1].children.push(obj);
			}
			// EDGE
			else if((match = line.match(/^(\w+)\s+(--|->)\s+(\w+)(?:\s*\[(.+?)\])?;$/))) {
				obj = {
					type:"EDGE",
					tail:match[1],
					head:match[3],
					directed:(match[2] == "->"),
					attributes:{}
				};
				parseAttributes(obj, match[4]);
				stack[stack.length-1].children.push(obj);
			}
			// CLOSING BRACE
			else if((match = line.match(/^\}$/))) {
				stack.pop();
			}
		}
		
		return root;
	}

	private function parseAttributes(obj:Object, attrString:String):void
	{
		if(!attrString) {
			return;
		}
		
		// Split out all attributes
		var regex:RegExp = /(\w+)=(?:(\w+)|"((?:\\"|[^"])+)")(?:,\s*)?/g;
		var matches:Array = attrString.match(regex);
		
		// Parse each attribute
		regex = new RegExp(regex.source);
		
		for each(var str:String in matches) {
			var match:Array = str.match(regex);
			obj.attributes[match[1]] = (match[2] ? match[2] : match[3].replace("\\\"", "\""));
		}
	}
	

	//----------------------------------
	//	Normalization
	//----------------------------------

	/**
	 *	Formats DOT file so that Window new line are changed to Unix new lines
	 *	and node and edges are condensed onto one line.
	 */
	private function normalize(data:String):String
	{
		data = data.replace(/\r\n/gsm, "\n");
		data = data.replace(/\\\n/gsm, "");
		data = data.replace(/([^;{}])\n\s*/gsm, "$1 ");
		data = data.replace(/^\s+|\s+$/gm, "");
		return data;
	}
}
}
