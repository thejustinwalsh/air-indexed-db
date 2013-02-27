package com.thejustinwalsh.data
{
	import flash.events.Event;

	internal class IDBEvent extends Event
	{
		private var _target:Object;
		override public function get target():Object { return _target; }
		
		public function IDBEvent(type:String, target:Object)
		{
			_target = target;
			super(type, false, false);
		}
		
		override public function clone():Event
		{
			return new IDBEvent(this.type, this.target);
		}
	}
}