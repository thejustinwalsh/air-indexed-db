package com.thejustinwalsh.data
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.utils.UIDUtil;

	public class IDBFactory
	{
		use namespace idb_internal;
		
		private static const SCHEMA_VERSION:uint = 1;
		
		private var _indexConnection:SQLConnection;
		private var _databaseIndex:Object = {};
		private var _connections:Object = {};
		
		public function IDBFactory()
		{
			// Open a synchronous connection to our databse index
			var index:File = File.applicationStorageDirectory.resolvePath("indexeddb.sqlite");
			_indexConnection = new SQLConnection();
			_indexConnection.open(index);
			
			// Create the index table if needed
			var stmnt:SQLStatement = new SQLStatement();
			stmnt.text = SQLHelper.TABLE_TOC;
			stmnt.sqlConnection = _indexConnection;
			stmnt.execute();
			
			// Cache the databases
			cacheDatabaseIndex();
		}
				
		public function open(name:String, version:uint = 1):IDBOpenDBRequest
		{
			
			if (_databaseIndex.hasOwnProperty(name) == false) {
				var guid:String = UIDUtil.createUID();
				insertDatabase(name, guid);
				cacheDatabaseIndex();
			}
			
			var databaseFile:File = File.applicationStorageDirectory.resolvePath(_databaseIndex[name]+".sqlite");
			var request:IDBOpenDBRequest = new IDBOpenDBRequest();
			request._source = this;
			
			var database:IDBDatabase = IDBDatabase.construct(databaseFile, name, version, request);
			if (_connections.hasOwnProperty(name) == false) _connections[name] = [];
			_connections[name].push(database);
			
			return request;
		}
		
		public function destroyDatabase(name:String):IDBOpenDBRequest
		{
			var request:IDBOpenDBRequest = new IDBOpenDBRequest();
			request._source = null;
			return new IDBOpenDBRequest();
		}
		
		public function cmp(first:*, second:*):int
		{
			return 0;
		}
		
		private function cacheDatabaseIndex():void
		{
			var stmnt:SQLStatement = new SQLStatement();
			stmnt.text = "SELECT name, guid, schema_version FROM 'index'";
			stmnt.sqlConnection = _indexConnection;
			stmnt.execute();
			var results:SQLResult = stmnt.getResult();
			for (var i:int = 0; results.data && i < results.data.length; ++i) {
				_databaseIndex[results.data[i].name] = results.data[i].guid;
			}
		}
		
		private function insertDatabase(name:String, guid:String):void {
			var stmnt:SQLStatement = new SQLStatement();
			stmnt.text = "INSERT INTO 'index' (name, guid, schema_version) VALUES (?, ?, ?)";
			stmnt.parameters[0] = name;
			stmnt.parameters[1] = guid;
			stmnt.parameters[2] = SCHEMA_VERSION;
			stmnt.sqlConnection = _indexConnection;
			stmnt.execute();
		}
	}
}
