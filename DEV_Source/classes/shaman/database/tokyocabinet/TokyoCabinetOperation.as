package shaman.database.tokyocabinet
{
	import flash.utils.ByteArray;
	
	public class TokyoCabinetOperation
	{
		public var  data       : ByteArray;
		private var _name      : String;
		private var _arguments : Vector.<String>;
		
		public function TokyoCabinetOperation(name:String, arguments:Vector.<String>)
		{
			this._name      = name;
			this._arguments = arguments;
		}
		
		public function initialize():void
		{
			data = new ByteArray();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get arguments():Vector.<String>
		{
			return _arguments;
		}
		
	}
}