package com.thejustinwalsh.data
{
	public class IDBDatabase
	{
		// Callbacks (events)
		public var onabort:Function;
		public var onerror:Function;
		public var onversionchange:Function;
		
		public function IDBDatabase()
		{
		}
		
		public function get name():String
		{
			return "";
		}
		
		public function get version():uint
		{
			return 0;
		}
		
		public function get objectStoreNames():Array
		{
			return [];
		}
		
		public function createObjectStore(name:String, params:Object = null):IDBObjectStore
		{
			var keyPath:String = "";
			var autoIncrement:Boolean = false;
			if (params && params.hasOwnProperty("keyPath")) keyPath = params.keyPath;
			if (params && params.hasOwnProperty("autoIncrement")) autoIncrement = params.autoIncrement;
			
			return new IDBObjectStore();
		}
		
		public function destroyObjectStore(name:String):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function transaction(storeNames:*, mode:String = "readonly"):IDBTransaction
		{
			if (storeNames is String) storeNames = [storeNames];
			
			return new IDBTransaction();
		}
		
		public function close():void
		{
			
		}
	}
}