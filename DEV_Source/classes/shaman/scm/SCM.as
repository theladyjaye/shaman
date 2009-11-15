package shaman.scm
{
	import flash.desktop.NativeProcess;
	import flash.events.NativeProcessExitEvent;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	public class SCM
	{
		protected var binary : String;
		
		protected function execute(...argv):void
		{
			var process = new NativeProcess();
			process.start(processInfo(argv));
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			process.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		protected function processInfo(argv:Array):NativeProcessStartupInfo
		{
			var args:Vector.<String> = new Vector.<String>;
			
			for each(var a:String in argv){
				args.push(a);
			}
			
			var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var file:File = File.applicationDirectory.resolvePath(binary);
			
			processInfo.executable  = file;
			processInfo.arguments   = args;
			
			return processInfo;
		}
		
		private function onOutputData(e:ProgressEvent):void
		{
			trace('onOutputData');
		}
		
		private function onErrorData(e:ProgressEvent):void
		{
			trace('onErrorData');
		}
		
		private function onExit(e:NativeProcessExitEvent):void
		{
			trace('onExit');
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			trace('onIOError');
		}
		
		private function onActivate(e:Event):void
		{
			trace('onActivate');
		}
		
		
	}
}