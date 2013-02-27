package com.thejustinwalsh.data
{
	import com.thejustinwalsh.sql.SQLStatementChain;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
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
		
		private function versionChange(currentVersion:uint):void
		{
			if (_version != currentVersion) {
				trace("TODO: Fire the versionChange event"); // TODO
				
				// Store the current version in the DB
				var sql:SQLStatement = new SQLStatement();
				sql.text = "UPDATE 'database' SET version=? WHERE name=?";
				sql.parameters[0] = _version;
				sql.parameters[1] = _name;
				sql.sqlConnection = _connection;
				sql.execute(1, new Responder(onFinalize, onOpenError));
			}
			else {
				onFinalize();
			}
		}
		
		private function createSchema():void
		{
			var sqlChain:SQLStatementChain = new SQLStatementChain();
			sqlChain.add(SQLHelper.TABLE_DATABASE);
			sqlChain.add("INSERT INTO 'database' (name, version) VALUES (?, ?)", [_name, _version]); // TODO: Version change on creation?
			sqlChain.add(SQLHelper.TABLE_OBJECT_STORE);
			sqlChain.add(SQLHelper.TABLE_OBJECT_DATA);
			sqlChain.add(SQLHelper.TABLE_OBJECT_STORE_INDEX);
			sqlChain.add(SQLHelper.TABLE_INDEX_DATA);
			sqlChain.add(SQLHelper.INDEX_OBJECT_DATA);
			sqlChain.add(SQLHelper.TABLE_UNIQUE_INDEX_DATA);
			sqlChain.add(SQLHelper.INDEX_UNIQUE_OBJECT_DATA);
			sqlChain.onsuccess = onFinalize;
			sqlChain.onerror = onOpenError;
			sqlChain.execute(_connection);
		}
		
		protected function onOpen(result:SQLEvent):void
		{
			// Attempt to retrieve the DB version, if unable to retrieve the version, create the schema
			var sql:SQLStatement = new SQLStatement();
			sql.text = "SELECT version FROM 'database' LIMIT 1;";
			sql.sqlConnection = _connection;
			sql.execute(1, new Responder(
				function(result:SQLResult):void { versionChange(result.data[0].version); },
				function(error:SQLError):void { createSchema(); }
			));
		}
		
		protected function onFinalize(result:SQLResult = null):void
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
