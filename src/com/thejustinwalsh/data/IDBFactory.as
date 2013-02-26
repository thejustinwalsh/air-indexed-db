package com.thejustinwalsh.data
{
	public class IDBFactory
	{
		public function IDBFactory()
		{
		}
		
		public function open(name:String, version:uint = 0):IDBOpenDBRequest
		{
			return new IDBOpenDBRequest();
		}
		
		public function destroyDatabase(name:String):IDBOpenDBRequest
		{
			return new IDBOpenDBRequest();
		}
		
		public function cmp(first:*, second:*):int
		{
			return 0;
		}
	}
}