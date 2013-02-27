package com.thejustinwalsh.data
{
	import flash.events.Event;

	public class IDBVersionChangeEvent extends IDBEvent
	{
		private var _oldVersion:uint;
		public function get oldVersion():uint { return _oldVersion; }
		
		private var _newVersion:uint;
		public function get newVersion():uint { return _newVersion; }
		
		public function IDBVersionChangeEvent(type:String, target:Object, oldVersion:uint, newVersion:uint)
		{
			super(type, target);
			_oldVersion = oldVersion;
			_newVersion = newVersion;
		}
		
		override public function clone():Event
		{
			return new IDBVersionChangeEvent(this.type, this.target, this.oldVersion, this.newVersion);
		}
	}
}