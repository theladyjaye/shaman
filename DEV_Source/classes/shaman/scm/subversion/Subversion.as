package shaman.scm.subversion
{
	import shaman.scm.SCM;
	
	public class Subversion extends SCM
	{
		public function Subversion()
		{
			this.binary = "svn";
		}
		
		public function status()
		{
			this.execute("status");
		}
	}
}