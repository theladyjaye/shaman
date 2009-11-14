package shaman.application
{
	import flash.display.MovieClip;
	import shaman.scm.subversion.Subversion;
	
	public class Main extends MovieClip
	{
		public function Main()
		{
			var svn : Subversion = new Subversion();
			svn.status();
		}
	}
}