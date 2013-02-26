package com.thejustinwalsh.data
{
	public class IDBIndex
	{
		public function IDBIndex()
		{
		}
		
		public function get name():String
		{
			return "";
		}
		
		public function get objectStore():IDBObjectStore
		{
			return new IDBObjectStore();
		}
		
		public function get keyPath():String
		{
			return "";
		}
		
		public function get multiEntry():Boolean
		{
			return false;
		}
		
		public function get unique():Boolean
		{
			return false;
		}
		
		public function get(key:*):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function getKey(key:*):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function count(key:* = null):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function openCursor(range:*, direction:uint = 1):IDBRequest
		{
			return new IDBRequest();
		}
		
		public function openKeyCursor(range:*, direction:uint = 1):IDBRequest
		{
			return new IDBRequest();
		}
	}
}