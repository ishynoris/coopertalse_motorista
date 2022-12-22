import 'dart:convert';

import 'package:http/http.dart' as http;

class Request {
  static const urlBaseDev = "http://192.168.1.3:80/coopertalse_api/v1";
  static const xDebugger = "XDEBUG_SESSION=PHPSTORM";

  static Future<Map> get(String sUrl) async {
    final response = await http.get(Request._getUri(sUrl));
    return jsonDecode(response.body);
  }

  static Future<Map> post(String sUrl, Map json) async {
    final response = await http.post(
      Request._getUri(sUrl),
      body: json,
    );
    return jsonDecode(response.body);
  }

  static Uri _getUri(String sUrlRelativa) {
    const sUrlBase = Request.urlBaseDev;
    const xDebugger = Request.xDebugger;
    final sUrl = "$sUrlBase$sUrlRelativa?$xDebugger";
    return Uri.parse(sUrl);
  }
}
