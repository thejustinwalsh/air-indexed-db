package com.thejustinwalsh.data
{	
	public class IDBRequest
	{
		use namespace idb_internal;
		
		// Callbacks (events)
		public var onerror:Function;
		public var onsuccess:Function;
		
		// Internal interface
		idb_internal var _result:*;
		idb_internal var _error:Error;
		idb_internal var _source:Object;
		idb_internal var _transaction:IDBTransaction;
		idb_internal var _readyState:String = "pending";
		
		// Public interface
		public function get result():*
		{
			if (_readyState != "done") throw new Error("Invalid State Error");
			return _result;
		}
		
		public function get error():Error
		{
			if (_readyState != "done") throw new Error("Invalid State Error");
			return idb_internal::_error;
		}
		
		public function get source():Object
		{
			return _source;
		}
		
		public function get transaction():IDBTransaction
		{
			return _transaction;
		}
		
		public function get readyState():String
		{
			return _readyState;
		}
	}
}
