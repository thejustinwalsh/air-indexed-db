package com.thejustinwalsh.data
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import mx.events.Request;

	public class IDBDatabase
	{
		use namespace idb_internal;
		
		private var _connection:SQLConnection;
		private var _responder:Responder;
		private var _request:IDBRequest;
		
		private var _name:String;
		private var _version:uint;
		private var _objectStoreNames:Array = [];
		
		// Callbacks (events)
		public var onabort:Function;
		public var onerror:Function;
		public var onversionchange:Function;
		
		public function IDBDatabase(factory:__idb_database_factory)
		{
			if (factory == null) throw new ArgumentError("IDBDatabase"+" class cannot be instantiated.", 2012);
		}
		
		idb_internal static function construct(database:File, name:String, version:uint, request:IDBRequest):IDBDatabase
		{
			var db:IDBDatabase = new IDBDatabase(new __idb_database_factory);
			db._name = name;
			db._version = version;
			db._request = request;
			db._connection = new SQLConnection();
			db._responder = new Responder(db.onOpen, db.onOpenError);
			db._connection.openAsync(database, SQLMode.CREATE, db._responder);
			
			return db;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get version():uint
		{
			return _version;
		}
		
		public function get objectStoreNames():Array
		{
			return _objectStoreNames;
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
			// TODO: Rules of closing the connection
			_connection.close();
		}
		
		protected function onOpen(result:SQLEvent):void
		{
			// Set the state of the request object
			_request._readyState = "done";
			_request._result = this;
			_request._error = null;
			
			// If there is a callback registered fire it
			if (_request.onsuccess != null) _request.onsuccess(new IDBEvent("DOMEvent", _request));
			
			// Release the request object as we no longer have a use for it
			_request = null; _responder = null;
		}
		
		protected function onOpenError(error:SQLError):void
		{
			// Set the state of the request object
			_request._readyState = "done";
			_request._result = null;
			_request._error = error;
			
			// If there is a callback registered fire it
			if (_request.onerror != null) _request.onerror(new IDBEvent("DOMEvent", _request));
			
			// Release the request object as we no longer have a use for it
			_request = null; _responder = null;
		}
	}
}

class __idb_database_factory {}
