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
	import shaman.database.tokyocabinet.TokyoCabinetHash;
	import flash.desktop.NativeProcess;
	
	
	public class Main extends MovieClip
	{
		public static const APPLICATION_DATABASE  : String  = 'db.tch';
		public static const APPLICATION_RESOURCES : String  = 'resources/';
		
		public function Main()
		{
			//var svn : Subversion = new Subversion();
			//svn.status();
			output.text = NativeProcess.isSupported.toString();
			var tc : TokyoCabinetHash = TokyoCabinetHash.databaseWithFilenameAndWorkingDirectory(Main.APPLICATION_DATABASE, Main.APPLICATION_RESOURCES);
			/*tc.put('pogo', '{"name":"pogo"}');
			tc.put('olley', '{"name":"olley"}');
			tc.put('lucy', '{"name":"lucy"}');
			tc.put('forbs', '{"name":"forbs"}');
			tc.put('foo', '{"name":"BAR!"}');
			tc.put('tucker', '{"name":"tucker"}');
			*/
			//tc.get('test');
			//tc.get('foo');
			
			/*tc.remove('pogo');
			tc.remove('olley');
			tc.remove('lucy');
			tc.remove('forbs');
			tc.remove('tucker');
			tc.remove('foo');
			tc.remove('nano');
			tc.remove('goucho');
			tc.remove('test');
			*/
			
			tc.list(true);
		}
	}
}