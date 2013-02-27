package com.thejustinwalsh.data
{
	internal class SQLHelper
	{
		public static const TABLE_TOC:String = <![CDATA[
			CREATE TABLE IF NOT EXISTS 'index' ( 
				name TEXT NOT NULL,
				guid TEXT NOT NULL,
				schema_version INTEGER NOT NULL DEFAULT 1
			);
		]]>;
		
		public static const TABLE_DATABASE:String = <![CDATA[
			CREATE TABLE database ( 
				name TEXT NOT NULL, 
				version INTEGER NOT NULL DEFAULT 0 
			);
		]]>;
		
		public static const TABLE_OBJECT_STORE:String = <![CDATA[
			CREATE TABLE object_store (
      			id INTEGER PRIMARY KEY, 
      			auto_increment INTEGER NOT NULL DEFAULT 0, 
      			name TEXT NOT NULL, 
      			key_path TEXT, 
      			UNIQUE (name)
    		);
		]]>;
		
		public static const TABLE_OBJECT_DATA:String = <![CDATA[
			CREATE TABLE object_data (
				id INTEGER PRIMARY KEY, 
				object_store_id INTEGER NOT NULL, 
				key_value BLOB DEFAULT NULL, 
				file_ids TEXT, 
				data BLOB NOT NULL, 
				UNIQUE (object_store_id, key_value), 
				FOREIGN KEY (object_store_id) REFERENCES object_store(id) ON DELETE 
					CASCADE
				);
		]]>;
		
		public static const TABLE_OBJECT_STORE_INDEX:String = <![CDATA[
			CREATE TABLE object_store_index (
				id INTEGER PRIMARY KEY, 
				object_store_id INTEGER NOT NULL, 
				name TEXT NOT NULL, 
				key_path TEXT NOT NULL, 
				unique_index INTEGER NOT NULL, 
				multientry INTEGER NOT NULL, 
				UNIQUE (object_store_id, name), 
				FOREIGN KEY (object_store_id) REFERENCES object_store(id) ON DELETE 
					CASCADE
			);
		]]>;
		
		public static const TABLE_INDEX_DATA:String = <![CDATA[
			CREATE TABLE index_data (
				index_id INTEGER NOT NULL, 
				value BLOB NOT NULL, 
				object_data_key BLOB NOT NULL, 
				object_data_id INTEGER NOT NULL, 
				PRIMARY KEY (index_id, value, object_data_key), 
				FOREIGN KEY (index_id) REFERENCES object_store_index(id) ON DELETE 
					CASCADE, 
				FOREIGN KEY (object_data_id) REFERENCES object_data(id) ON DELETE 
					CASCADE 
			);
		]]>;
		
		public static const INDEX_OBJECT_DATA:String = <![CDATA[
			CREATE INDEX index_data_object_data_id_index 
			ON index_data (object_data_id);
		]]>;
		
		public static const TABLE_UNIQUE_INDEX_DATA:String = <![CDATA[
			CREATE TABLE unique_index_data (
				index_id INTEGER NOT NULL, 
				value BLOB NOT NULL, 
				object_data_key BLOB NOT NULL, 
				object_data_id INTEGER NOT NULL, 
				PRIMARY KEY (index_id, value, object_data_key), 
				UNIQUE (index_id, value), 
				FOREIGN KEY (index_id) REFERENCES object_store_index(id) ON DELETE 
					CASCADE 
				FOREIGN KEY (object_data_id) REFERENCES object_data(id) ON DELETE 
					CASCADE 
			);
		]]>;
		
		public static const INDEX_UNIQUE_OBJECT_DATA:String = <![CDATA[
			CREATE INDEX unique_index_data_object_data_id_index 
    		ON unique_index_data (object_data_id);
		]]>;
	}
}