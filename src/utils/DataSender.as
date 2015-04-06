package utils
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;

	public class DataSender
	{
		
		public var response:Object="";
		
		private var _loader:URLLoader;
		private var _url:String="";
		private var _hidden:Boolean = false;
		private var _callBack:Function;
		
		public static var isShowPoPUp:Boolean = false;
		public static var countLoading:int = 0;
		
		private static var connecting:ConnectingPreloader;
		
		public function DataSender()
		{
		}
		
		/**
		 * send message to server
		 */ 
		public function sendRequestData(url:String, sendArr:Object, callBack:Function, hidden:Boolean = false):void
		{
			_callBack = callBack;
			_hidden = hidden;
			
			if(!_hidden && !isShowPoPUp)
			{
				connecting = ConnectingPreloader(PopUpManager.createPopUp(FlexGlobals.topLevelApplication.getChildAt(0), ConnectingPreloader, true));
				connecting.x= (FlexGlobals.topLevelApplication.getChildAt(0).width-connecting.width)/2;
				connecting.y= (FlexGlobals.topLevelApplication.getChildAt(0).height-connecting.height)/2;
				isShowPoPUp = true;
				
			}
			countLoading +=1;
			_url = url;
			
			var request:URLRequest = new URLRequest(url); 
			request.method = URLRequestMethod.POST; 
			var variables:URLVariables = new URLVariables(); 
			variables.antiCashData = Utils.anticash; 
			
			for(var s:String in sendArr)
			{
				variables[s] = sendArr[s]; 
			}
			
			request.data = variables; 
			_loader = new URLLoader (request); 
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(ErrorEvent.ERROR, onError);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.addEventListener(IOErrorEvent.NETWORK_ERROR, onError);
			_loader.addEventListener(IOErrorEvent.VERIFY_ERROR, onError);
			_loader.addEventListener(IOErrorEvent.DISK_ERROR, onError);
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			try
			{
				_loader.load(request);
			}
			catch (e:*)
			{
				onError(null);
			}
		}
		
		private function onError(e:ErrorEvent):void
		{
			countLoading = 0;
			hidePopUp();
			Alert.show("Ошибка соединения с сервером \n url = "+ _url,"Error");
		}
		
		private function hidePopUp():void
		{
			if (countLoading == 0)
			{
				PopUpManager.removePopUp(connecting);
				isShowPoPUp = false;
			}
		}
		
		/**
		 * on server response
		 */ 
		private function onComplete (event:Event):void
		{			
			countLoading -=1;
			
			event.target.removeEventListener(Event.COMPLETE, onComplete); 
			
			hidePopUp();
			try
			{
				response = JSON.parse(event.target.data.toString()); 
				_loader.close();
				_callBack(response);
			}
			catch(e:*)
			{
				Alert.show("Ошибка обработки данных, ответ сервера: \n" + response, "PHP ERROR!");
			}
		} 
	}
}