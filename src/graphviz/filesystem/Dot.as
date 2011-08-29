package graphviz.filesystem
{
import graphviz.core.Graph;
import graphviz.errors.DotError;
import graphviz.parsers.DotParser;
import graphviz.utils.FileUtil;

import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.NativeProcessExitEvent;
import flash.events.ProgressEvent;
import flash.filesystem.File;

/**
 *	This class represents a bridge between the Adobe AIR VM and the DOT program
 *	stored on the user's hard drive.
 */
public class Dot extends EventDispatcher
{
	//--------------------------------------------------------------------------
	//
	//	Static Constants
	//
	//--------------------------------------------------------------------------

	/**
	 *	A list of default locations to search for DOT in.
	 */
	static public const PATHS:Array = [
		"/usr/local/bin/dot",
		"/opt/local/bin/dot"
	];
	

	//--------------------------------------------------------------------------
	//
	//	Static Properties
	//
	//--------------------------------------------------------------------------

	/**
	 *	A flag stating if the DOT program is available on this computer.
	 */
	static public function get available():Boolean
	{
		return (executable != null);
	}

	/**
	 *	Retrieves the DOT program file reference.
	 */
	static public function get executable():File
	{
		for each(var path:String in PATHS) {
			var file:File = new File(path);
			if(file.exists) {
				return file;
			}
		}
		
		return null;
	}


	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 *	Constructor.
	 */
	public function Dot(graph:Graph=null)
	{
		super();
		this.graph = graph;
	}


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *	The graph that is being processed by this instance of execution.
	 */
	public var graph:Graph;
	
	
	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//	Layout
	//----------------------------------

	/**
	 *	Lays out a graph and its children using the DOT program. Returns the
	 *	layout data back into the objects using the <code>deserialize()</code>
	 *	method. An <code>Event.COMPLETE</code> event will fire when it's done.
	 *
	 *	@param graph  The graph to layout.
	 */
	public function execute():void
	{
		if(!executable) {
			return;
		}
		
		// Serialize graph data into DOT format in temp file
		var input:String = graph.serialize();
		var file:File = File.createTempFile();
		FileUtil.write(file, input);
		
		trace("input: " + file.nativePath);
		
		// Run DOT process
		var errored:Boolean = false;
		var process:NativeProcess = new NativeProcess();
		var output:Array = [];
		process.addEventListener("standardOutputData",
			function(event:ProgressEvent):void{
				output.push(process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable));
			}
		);
		process.addEventListener("standardErrorData",
			function(event:ProgressEvent):void{
				var message:String = process.standardError.readUTFBytes(process.standardError.bytesAvailable);
				errored = true;
				throw new DotError(message);
			}
		);
		process.addEventListener(NativeProcessExitEvent.EXIT,
			function(event:NativeProcessExitEvent):void{
				trace(output.join(""));
				// Parse xdot into AST and deserialize back into original graph
				var parser:DotParser = new DotParser();
				var data:Object = parser.parse(output.join(""));
				graph.deserialize(data);
			
				// Remove temp file if no error occurred
				if(!errored) {
					//FileUtil.deleteFile(file);
				}
			
				// Notify that layout is complete
				dispatchEvent(new Event(Event.COMPLETE));
			}
		);
		process.start(getStartupInfo(file));
	}


	//----------------------------------
	//	Process
	//----------------------------------

	private function getStartupInfo(file:File):NativeProcessStartupInfo
	{
		var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
		info.executable = executable;

		// Set DOT to return XDOT
		var args:Vector.<String> = new Vector.<String>();
		args.push(file.nativePath);
		args.push("-Txdot");
		info.arguments = args;
		
		return info;
	}
}
}
