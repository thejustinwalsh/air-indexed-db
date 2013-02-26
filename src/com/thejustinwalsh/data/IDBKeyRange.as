package com.thejustinwalsh.data
{
	public class IDBKeyRange
	{
		public static function bound(lower:*, upper:*, lowerOpen:Boolean = false, upperOpen:Boolean = false):IDBKeyRange
		{
			return new IDBKeyRange();
		}
		
		public static function only(value:*):IDBKeyRange
		{
			return new IDBKeyRange();
		}
		
		public static function lowerBound(bound:*, open:Boolean = false):IDBKeyRange
		{
			return new IDBKeyRange();
		}
		
		public static function upperBound(bound:*, open:Boolean = false):IDBKeyRange
		{
			return new IDBKeyRange();
		}
		
		public function IDBKeyRange()
		{
		}
		
		public function get lower():*
		{
			return null;
		}
		
		public function get upper():*
		{
			return null;
		}
		
		public function get lowerOpen():Boolean
		{
			return false;
		}
		
		public function get upperOpen():Boolean
		{
			return false;
		}
	}
}