import 'dart:convert';
import 'dart:io';

final class ClientService {
  static const String _baseUrl = "https://65e04610d3db23f76248cbbc.mockapi.io";
  static const String _api = "/users";

  static Future<bool> post(Map<String, dynamic> data) async {
    HttpClient httpClient = HttpClient();
    Uri url = Uri.parse("$_baseUrl/$_api");

    try{
      HttpClientRequest request = await httpClient.postUrl(url);
      request.headers.set("Content-Type", "application/json");
      request.add(utf8.encode(json.encode(data)));
      HttpClientResponse response = await request.close();
      httpClient.close();
      response.transform(utf8.decoder).join();

      if([HttpStatus.ok, HttpStatus.created].contains(response.statusCode)) return true;
    } catch(e){
      httpClient.close();
    }

    return false;
  }
}
