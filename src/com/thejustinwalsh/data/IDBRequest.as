package com.thejustinwalsh.data
{
	public class IDBRequest
	{
		// Callbacks (events)
		public var onerror:Function;
		public var onsuccess:Function;
		
		public function IDBRequest()
		{
		}
		
		public function get result():*
		{
			return null;
		}
		
		public function get error():Error
		{
			return new Error();
		}
		
		public function get source():Object
		{
			return null;
		}
		
		public function get transaction():IDBTransaction
		{
			return null;
		}
		
		public function get readyState():String
		{
			return "";
		}
	}
}