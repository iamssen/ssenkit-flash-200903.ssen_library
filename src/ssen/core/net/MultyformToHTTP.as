package ssen.core.net 
{
	import flash.net.URLRequestMethod;	

	import ssen.core.number.MathEx;	

	import flash.events.Event;	
	import flash.errors.IOError;	
	import flash.net.URLLoader;	
	import flash.net.URLRequest;	
	import flash.utils.ByteArray;	
	import flash.events.EventDispatcher;
	/**
	 * Multipart form data 를 전송한다
	 * @author SSen
	 */
	public class MultyformToHTTP extends EventDispatcher 
	{
		private var _request : URLRequest;
		private var _loader : URLLoader;
		private var _boundary : String;
		private var _content : ByteArray;

		/*
		 * TODO image 뿐 아니라 여러가지 다른 파일형식들을 지원할 수 있도록 한다
		 */
		public function MultyformToHTTP()
		{
			_boundary = _getRandomBoundary();
			_content = new ByteArray();
		}
		/**
		 * HTTP 프로토콜의 body 에 보낼 이미지파일을 추가한다
		 * @param imgbyte ByteArray 로 인코딩 된 이미지파일 데이터
		 * @param imgname 원하는 이미지 파일의 이름
		 * @param filetype png, jpg 등 파일형식
		 */
		public function pushImage(imgByte : ByteArray, imgName : String, fileType : String) : void
		{
			try {
				_content.writeUTFBytes('-----------------------------' + _boundary + '\r\n');
				_content.writeUTFBytes('Content-Disposition: form-data; name="' + imgName + '"; filename="' + imgName + '.' + fileType + '"\r\n');
				_content.writeUTFBytes('Content-Type: application/octet-stream\r\n\r\n');
					
				_content.writeBytes(imgByte, 0, imgByte.length);
				_content.writeUTFBytes("\r\n");
				trace("SSEN//", imgName + " : write ok");
			} catch (e : IOError) {
				trace("SSEN//", e);
			}
		}
		/**
		 * 최종적으로 web 으로 전송한다
		 * @param url 파일처리를 할 서버사이드 스크립트의 경로
		 * 
		 */
		public function send(url : String) : void
		{
			_content.writeUTFBytes('-----------------------------' + _boundary + '\r\nContent-Disposition: form-data; name="Upload"\r\n\r\nSubmit Query\r\n-----------------------------' + _boundary + '--\r\n');
				
			trace("SSEN//", "start send");
			_request = new URLRequest(url);
			_request.data = _content;
			_request.method = URLRequestMethod.POST;
			_request.contentType = "multipart/form-data; boundary=---------------------------" + _boundary;
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, _loaderComplete);
			
			try {
				_loader.load(_request);
			} catch (e : Error) {
				trace("SSEN//", "Error : " + e);
			}
		}
		// complete event
		private function _loaderComplete(event : Event) : void
		{
			dispatchEvent(event);
		}
		// 13 자리로 된 multypart/form-data 의 boundary 를 랜덤생성 합니다.
		private function _getRandomBoundary() : String
		{
			var boundary : String = "";
			var sets : Array = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e"];
			for (var f : int = 1;f <= 13; f++) {
				var n : int = MathEx.rand(1, 14);
				boundary += sets[n];
			}
			
			return boundary;
		}
	}
}
