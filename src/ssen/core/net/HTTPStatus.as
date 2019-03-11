package ssen.core.net 
{
	/**
	 * Http Status
	 * @author SSen
	 */
	public final class HTTPStatus
	{
		static private var _data : XML = <xml>
				<item code="100" name="Continue" discription="Client는 Request를 Server는 Response를 계속진행" />
				<item code="101" name="Switching Protocols" discription="Client의 요청에 따라 연결 프로토콜을 전환" />
				<item code="200" name="OK" discription="Request가 성공적으로 완료되었음" />
				<item code="201" name="Created" discription="Request가 POST method이었으며 성공적으로 완료되었음" />
				<item code="202" name="Accepted" discription="Request가 서버에 전달되었으나 처리 결과를 알 수 없음" />
				<item code="203" name="Non-Authoritative Information" discription="GET Request가 실행되었으며 부분적인 정보를 리턴하였음" />
				<item code="204" name="No Content" discription="Request가 실행되었으나 클라이언트에게 보낼 데이터가 없음" />
				<item code="205" name="Reset Content" discription="클라이언트 폼 전송후 폼 내용 삭제" />
				<item code="206" name="Partial Content" discription="클라이언트가 Range 헤더와 함께 요청의 일부분을 보냈고 서버는 이를 수행했음" />
				<item code="300" name="Multiple Choices" discription="요구된 Request가 여러 위치에 존재하는 자원을 필요로 하므로 Response는  위에 대한 정보를 보낸다. 클라이언트는 가장 적당한 위치를 선택하여야 함" />
				<item code="301" name="Moved Permanently" discription="Request에 의한 요구된 데이터는 영구적으로 새로운 URL로 옮기어 졌음" />
				<item code="302" name="Moved Temporarily" discription="Request가 요구한 데이터를 발견하였으나 실제 다른 URL에 존재함" />
				<item code="303" name="See Other" discription="요구한 데이터를 변경하지 않았기 때문에 문제발생" />
				<item code="304" name="Not Modified" discription="If-Modified-Since 필드를 포함한 GET Method를 받았으나 문서는 수정 되지 않았음" />
				<item code="305" name="User Proxy" discription="요청된 문서는 Location 헤더에 나열된 프록시를 통해 추출되어야 함" />
				<item code="307" name="Temporary Redirect" discription="302 (Found 또는 Temporarily Moved)와 같다" />
				<item code="400" name="Bad Request" discription="Request의 문법이 잘못되었음, 처리할 수 없다" />
				<item code="401" name="Unauhorized" discription="Request가 서버에게 Authorization: 필드를 사용하였으나 값을 지정 하지 않았음. (클라이언트의 인증 실패)" />
				<item code="403" name="Forbidden" discription="Request는 금지된(접근 거부된) 자원을 요구하였음" />
				<item code="404" name="Not Found" discription="문서를 찾을 수 없음" />
				<item code="405" name="Method Not Allowed" discription="클라이언트는 자원을 액세스하기에 부적합한 Method를 이용하였음. 리소스 허용안함" />
				<item code="406" name="Not Acceptable" discription="요구된 자원을 발견하였으나 자원을 타입이 Request Header의 Accept 필드와 일치하지 않아서 전송할 수 없음" />
				<item code="407" name="Prozy Authentication Required" discription="프록시 인증 필요" />
				<item code="408" name="Request Timeout" discription="요청시간이 지남" />
				<item code="409" name="Conflict" discription="리소스간 충돌로 인하여 서버가 응답할 수 없음" />
				<item code="410" name="Gone" discription="요구된 자원은 영구적으로 활용가능하지 않음" />
				<item code="411" name="Length Required" discription="Content-Length를 정의하지 않고 리소스를 요청" />
				<item code="412" name="Precondition Failed" discription="전제조건 실패" />
				<item code="413" name="Request Entity Too Long" discription="Request Entity가 서버가 처리할 수 있는 것보다 큼" />
				<item code="414" name="Ruquest URI Too Long" discription="URI가 너무 김" />
				<item code="415" name="Usupported Media Type" discription="지원되지 않는 미디어 형식" />
				<item code="416" name="Requested Range Not Satisfiable" discription="클라이언트가 요청에 적당하지 않는 Range 헤더를 포함 시켰음" />
				<item code="417" name="Espectation Failed" discription="Expect 요청 헤더의 값이 맞지 않음" />
				<item code="500" name="Internal Server Error" discription="서버에 내부적으로 오류(잘못된 스크립트 실행시)가 발생하여 더 이상을 진행할 수 없음" />
				<item code="501" name="Not Implemented" discription="요청된 Request는 합법적이나 서버는 요구된 Method를 지원하지 않음" />
				<item code="502" name="Bad Gateway" discription="클라이언트는 다른 서버(보조서버)로부터 자원 액세스를 요구하는 서버에 자원을 요구하였으나 보조 서버가 유효한 응답을 전달해오지 않았음" />
				<item code="503" name="Service Unavailabe" discription="서버가 바쁘기 때문에 서비스를 할 수 없음(서버 과부하)" />
				<item code="504" name="Gateway Timeout" discription="502의 오류와 유사하나 보조 서버의 응답이 너무 오래 지체되어 트랜잭션이 실패하였음" />
				<item code="505" name="HTTP Version Not Supported" discription="서버가 요청 라인에 지정된 HTTP 버전을 지원하지 않음" />
			</xml>;

		/** http status 의 code list, 리스트를 교체할 수 있거나 할 수 있다. */
		static public function get data() : XML
		{
			return _data;
		}
		static public function set data(data : XML) : void
		{
			_data = data;
		}

		private var _code : int;
		private var _name : String;
		private var _discription : String;

		public function HTTPStatus(code : int)
		{
			var stat : XML = getItem(code);
			_code = stat.@code;
			_name = stat.@name;
			_discription = stat.@discription;
		}
		private function getItem(code : int) : XML
		{
			var xml : XML = _data["item"].(@code == code.toString())[0];
			return xml;
		}
		/** code */
		public function get code() : int
		{
			return _code;
		}
		/** type */
		public function get name() : String
		{
			return _name;
		}
		public function get discription() : String
		{
			return _discription;
		}
		public function toString() : String
		{
			return '[HTTPStatus code="' + _code + '" name="' + _name + '" discription="' + _discription + '"]';
		}
	}
}