package com.thejustinwalsh.data
{
	public class IDBEnvironment
	{
		private static const instance:IDBFactory = new IDBFactory();
		
		public static function get indexedDB():IDBFactory
		{
			return instance;
		}
	}
}
