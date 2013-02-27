package com.thejustinwalsh.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.net.Responder;

	public class SQLStatementChain
	{
		private var _connection:SQLConnection;
		private var _statements:Array = [];
		private var _responder:Responder = new Responder(onSuccess, onError);
		private var _worker:Function;
		
		public var onsuccess:Function;
		public var onerror:Function;
		
		public function add(sql:String, params:Object = null, worker:Function = null):void
		{
			_statements.push({ text: sql, params: params, worker: worker });
		}
		
		public function execute(connection:SQLConnection):void
		{
			_connection = connection;
			onSuccess();
		}
		
		protected function onSuccess(result:SQLResult = null):void
		{
			// Execute our worker if present
			if (_worker != null) { _worker(result); _worker = null; }
			
			// Finish the statement chain, or fire the next statement
			if (_statements.length == 0) {
				if (onsuccess != null) onsuccess();
				_connection = null; _responder = null; onsuccess = null; onerror = null;
			}
			else {			
				var sqlObject:Object = _statements.shift();
				executeStatement(sqlObject.sql, sqlObject.params, sqlObject.worker);
			}
		}
		
		protected function onError(error:SQLError):void
		{
			if (onerror != null) onerror(error);
			_statements = [];
			_connection = null; _responder = null; onsuccess = null; onerror = null;
		}
		
		protected function executeStatement(sql:String, params:Object, worker:Function):void
		{
			// Store the worker for later use
			_worker = worker;
			
			// Build the statement and execute it
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			statement.text = sql;
			if (params) for (var i:* in params) { statement.parameters[i] = params[i]; }
			statement.execute(-1, _responder);
		}
	}
}