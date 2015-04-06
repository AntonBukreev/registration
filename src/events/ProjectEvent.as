package events
{
	import flash.events.Event;
	
	public class ProjectEvent extends Event
	{
		public static const EVENT_LOGIN:String = "EVENT_LOGIN";
		public static const EVENT_OPEN_REGISTRATION:String = "EVENT_OPEN_REGISTRATION";
		public static const EVENT_OPEN_LOGIN:String = "EVENT_OPEN_LOGIN";
		
		public var data:Object;
		public function ProjectEvent(type:String, data:Object=null)
		{
			this.data = data;
			super(type, true, false);
		}
	}
}