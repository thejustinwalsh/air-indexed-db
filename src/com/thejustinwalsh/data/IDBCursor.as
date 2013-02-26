package com.thejustinwalsh.data
{
	public class IDBCursor
	{
		public function IDBCursor()
		{
		}
		
		public function get source():*
		{
			return null; // IDBObjectSotre || IDBIndex
		}
		
		public function get direction():String
		{
			return "";
		}
		
		public function get key():*
		{
			return null;
		}
		
		public function get primaryKey():*
		{
			return null;
		}
		
		public function update(key:*):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function advance(count:uint):void
		{
			
		}
		
		// continue is a keyword in actionscript
		public function next(key:*):void
		{
			
		}
		
		// delete is a keyword in actionscript
		public function destroy():IDBRequest
		{
			return new IDBRequest();
		}
	}
}