package com.thejustinwalsh.data
{
	public class IDBObjectStore
	{
		public function IDBObjectStore()
		{
		}
		
		public function get indexNames():Array
		{
			return [];
		}
		
		public function get keyPath():String
		{
			return "";
		}
		
		public function get name():String
		{
			return "";
		}
		
		public function get transaction():IDBTransaction
		{
			return new IDBTransaction();
		}
		
		public function get autoIncrement():Boolean
		{
			return true;
		}
		
		public function add(value:*, key:* = null):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function clear():IDBRequest
		{
			return new IDBRequest();
		}
		
		public function count(key:* = null):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function createIndex(name:String, keyPath:String, params:Object = null):IDBIndex
		{
			var unique:Boolean = true;
			var multiEntry:Boolean = false;
			if (params && params.hasOwnProperty("unique")) unique = params.unique;
			if (params && params.hasOwnProperty("multiEntry")) multiEntry = params.multiEntry;
			
			return new IDBIndex();
		}
		
		// delete is a keyword in actionscript
		public function destroy(key:*):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function destroyIndex(indexName:String):void
		{
			
		}
		
		public function get(key:*):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function index(name:String):IDBIndex
		{
			return new IDBIndex();
		}
		
		public function openCursor(range:IDBKeyRange = null, direction:uint = 1):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function put(value:*, key:* = null):IDBRequest
		{
			return new IDBRequest();
		}
	}
}