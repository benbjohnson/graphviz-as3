package graphviz.utils
{
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

/**
 *	This class provides helper methods to read and write files.
 */
public class FileUtil
{
	//-------------------------------------------------------------------------
	//
	//  Static methods
	//
	//-------------------------------------------------------------------------

	/**
	 *	Reads the entire contents of the file as a string.
	 *	
	 *	@param file  The file to read.
	 *	
	 *	@return      A string representing the contents of the file.
	 */
	static public function read(file:File):String
	{
		return readBytes(file).toString();
	}

	/**
	 *	Reads the entire contents of the file as a byte array.
	 *	
	 *	@param file  The file to read.
	 *	
	 *	@return      A byte arry of the file contents.
	 */
	static public function readBytes(file:File):ByteArray
	{
		// If file does not exist, return null
		if(!file || !file.exists) {
			return null;
		}
		
		// Otherwise read file
		var bytes:ByteArray = new ByteArray();
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		return bytes;
	}

	/**
	 *	Writes a string to file.
	 *	
	 *	@param file  The file to write to.
	 *	@param data  The string to write to file.
	 */
	static public function write(file:File, data:String):void
	{
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);
		stream.writeUTFBytes(data);
		stream.close();
	}

	/**
	 *	Writes bytes to a file.
	 *	
	 *	@param file  The file to write to.
	 *	@param data  The byte array to write to file.
	 */
	static public function writeBytes(file:File, data:ByteArray):void
	{
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);
		stream.writeBytes(data);
		stream.close();
	}

	/**
	 *	Deletes a file.
	 *	
	 *	@param file  The file to delete.
	 */
	static public function deleteFile(file:File):void
	{
		try {
			file.deleteFile();
		} catch(e:Error) {
			trace("Error removing file: " + e.toString());
		}
	}
}
}