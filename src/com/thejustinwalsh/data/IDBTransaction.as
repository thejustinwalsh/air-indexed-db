package com.thejustinwalsh.data
{
	public class IDBTransaction
	{
		private static const READ_WRITE:String = "readwrite";
		private static const READ_ONLY:String = "readonly";
		private static const VERSION_CHANGE:String = "versionchange";
		
		// Callbacks (events)
		public var onabort:Function;
		public var oncomplete:Function;
		public var onerror:Function;
		
		public function IDBTransaction()
		{
		}
		
		public function get db():IDBDatabase
		{
			return null;
		}
		
		public function get mode():String
		{
			return READ_ONLY;
		}
		
		public function get error():Error
		{
			return new Error();
		}
		
		public function abort():void
		{
			
		}
		
		public function objectStore(name:String):IDBObjectStore
		{
			return new IDBObjectStore();
		}
	}
}