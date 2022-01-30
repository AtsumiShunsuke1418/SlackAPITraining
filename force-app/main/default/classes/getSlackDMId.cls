global class getSlackDMId {
	private final String token;
	private final String baseUrl;
	private Http http = new Http();

	public getSlackDMId(String token) {
		this(token, 'https://www.slack.com/api');
	}

	public getSlackDMId(String token, String baseUrl) {
		this.token = token;
		this.baseUrl = baseUrl;
	}
//ResponseクラスでJSONレスポンスをbodyに格納
	public class Response {
		public HttpResponse httpResponse;
		public Map<String, Object> body;
		public String rawBody;
		public Response(HttpResponse httpResponse) {
			this.httpResponse = httpResponse;
			this.rawBody = httpResponse.getBody();
			this.body = (Map<String, Object>) JSON.deserializeUntyped(this.rawBody);
		}
	}
//apiMethodnameとparamsを引数に取るcallApiメソッド 返り値は
	public Response callApi(String apiMethodName, Map<String, Object> params) {
		HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(this.baseUrl + apiMethodName);
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setHeader('Authorization', 'Bearer ' + this.token);
		Map<String, String> encodedParams = new Map<String, String>();
		String body = '';
		for (String name : params.keySet()) {
			if (params.get(name) != null) {
				String value = params.get(name).toString();
				String regExp = '%(?![0-9a-fA-F]{2})';
				value = value.replaceAll(regExp, '%25');
				body += '&' + name + '=' + EncodingUtil.urlDecode(value, 'utf-8');
			}
		}
		request.setBody(body.substring(1));
		return new Response(this.http.send(request));
	}
}

