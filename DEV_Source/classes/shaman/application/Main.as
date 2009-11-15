/* Debug:
Start fdb @ /Developer/SDKs/flex_sdk_3/bin/fdb
Type run

Then, in the app dir, type (to allow native processes):
/Applications/Adobe\ Flash\ CS4/AIK1.5/bin/adl -profile extendedDesktop MainWindow-app.xml

*/

package shaman.application
{
	import flash.display.MovieClip;
	import shaman.scm.subversion.Subversion;
	import shaman.database.tokyocabinet.TokyoCabinet;
	import flash.desktop.NativeProcess
	
	public class Main extends MovieClip
	{
		public function Main()
		{
			//var svn : Subversion = new Subversion();
			//svn.status();
			output.text = NativeProcess.isSupported.toString();
			var tc : TokyoCabinet = new TokyoCabinet();
			tc.put('test', '{"name":"Framework"}');
			tc.get('test');
		}
	}
}