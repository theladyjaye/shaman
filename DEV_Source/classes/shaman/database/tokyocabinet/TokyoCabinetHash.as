package shaman.database.tokyocabinet
{
	import flash.desktop.NativeProcess;
	import flash.events.NativeProcessExitEvent;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class TokyoCabinetHash
	{
		private var binary           : String = 'tchmgr';
		
		private var database         : String;
		private var workingDirectory : String;
		private var operationQueue   : Dictionary;
		
		public static function databaseWithFilenameAndWorkingDirectory(filename:String, workingDirectory:String=null):TokyoCabinetHash
		{
			var tc:TokyoCabinetHash = new TokyoCabinetHash();
			tc.database             = filename;
			tc.workingDirectory     = workingDirectory;
			tc.operationQueue       = new Dictionary();
			return tc;
		}
		
		
		public function remove(key:String):void
		{
			this.execute(new TokyoCabinetOperation('out', Vector.<String>([database, key])));
		}
		
		public function get(key:String):void
		{
			this.execute(new TokyoCabinetOperation('get', Vector.<String>([database, key])));
		}
		
		public function put(key:String, value:String):void
		{
			this.execute(new TokyoCabinetOperation('put', Vector.<String>([database, key, value])));
		}
		
		public function list(include_values:Boolean=false):void
		{
			// this setup is not conducive to multiple options... need to refactor if 
			// exposing the full range of possibilities is desired.
			var operation : TokyoCabinetOperation;
			
			if(include_values)
			{
				operation = new TokyoCabinetOperation('list', Vector.<String>(['-pv', database,]));
			}
			else
			{
				operation = new TokyoCabinetOperation('list', Vector.<String>([database]))
			}
			
			this.execute(operation);
		}
		
		public function execute(operation:TokyoCabinetOperation):void
		{
			var process     : NativeProcess            = new NativeProcess();
			var processInfo : NativeProcessStartupInfo = this.prepareProcessInfo(operation);
			
			/*process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			*/
			
			// sometimes EXIT gets called first effectively rendering ACTIVATE useless since we
			// can't rely on it to be called first.
			//process.addEventListener(Event.ACTIVATE, tokyoCabinetDidStartOperation);
			
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, foundData);
			process.addEventListener(NativeProcessExitEvent.EXIT, tokyoCabinetDidEndOperation);
			
			operation.initialize();
			operationQueue[process] = operation;
			process.start(processInfo);
			
		}
		
		private function prepareProcessInfo(operation:TokyoCabinetOperation):NativeProcessStartupInfo
		{
			var args : Vector.<String>          = Vector.<String>([operation.name]).concat(operation.arguments);
			var file : File                     = File.applicationDirectory.resolvePath(workingDirectory+binary);
			var info : NativeProcessStartupInfo = new NativeProcessStartupInfo();
			
			info.workingDirectory = File.applicationDirectory.resolvePath(workingDirectory);
			info.executable = file;
			info.arguments  = args
			
			return info;
		}
		
		private function tokyoCabinetDidEndOperation(e:NativeProcessExitEvent):void
		{
			trace('End '+operationQueue[e.target].name, operationQueue[e.target].data)
		}
		
		private function foundData(e:ProgressEvent):void
		{
			var process   : NativeProcess         = NativeProcess(e.target);
			var operation : TokyoCabinetOperation = operationQueue[process];
			process.standardOutput.readBytes(operation.data, operation.data.position, process.standardOutput.bytesAvailable)
		}
	}
}