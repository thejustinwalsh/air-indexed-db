package com.thejustinwalsh.data
{
	public class IDBEnvironment
	{
		public static function get indexedDB():IDBFactory
		{
			return new IDBFactory();
		}
	}
}