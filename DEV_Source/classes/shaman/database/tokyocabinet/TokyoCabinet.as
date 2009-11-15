package shaman.database.tokyocabinet
{
	import flash.desktop.NativeProcess;
	import flash.events.NativeProcessExitEvent;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	public class TokyoCabinet
	{
		private var database : String = 'db.tch';
		
		public function TokyoCabinet()
		{
		}
		
		public function remove(key:String):void
		{
			this.execute('out', database, key);
		}
		
		public function get(key:String):void
		{
			this.execute('get', database, key);
		}
		
		public function put(key:String, value:String):void
		{
			this.execute('put', database, key, value);
		}
		
		public function execute(...argv):void
		{
			var process     : NativeProcess            = new NativeProcess();
			var processInfo : NativeProcessStartupInfo = this.prepareProcessInfo(argv);
			
			process.start(processInfo);
			
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			/*process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			process.addEventListener(Event.ACTIVATE, onActivate);
			*/
		}
		
		private function onOutputData(e:ProgressEvent):void
		{
			var process : NativeProcess = NativeProcess(e.target);
			trace("Got: ", process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable));
		}
		
		private function prepareProcessInfo(argv:Array):NativeProcessStartupInfo
		{
			var args : Vector.<String> = new Vector.<String>();
			
			for each(var arg:String in argv){
				args.push(arg);
			}
			
			trace(args);
			
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var file:File = File.applicationDirectory.resolvePath("resources/tchmgr");
			nativeProcessStartupInfo.workingDirectory = File.applicationDirectory.resolvePath('resources/');
			nativeProcessStartupInfo.executable = file;
			nativeProcessStartupInfo.arguments  = args
			return nativeProcessStartupInfo;
		}
	}
}