import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HttpReqManager {
  static final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  static final _urlPrefix = 'c60f-78-176-89-213.eu.ngrok.io';

  static Map<String, String> _headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*',
    'x-access-token': "",
  };

  static addTokenToHeaders(String token) {
    _headers['x-access-token'] = token;
  }

  static Future<String> getReq(String target) async {
    try {
      resultNotifier.value = RequestLoadInProgress();
      final url = Uri.https('$_urlPrefix', '$target');
      Response response = await get(url, headers: _headers);
      _handleResponse(response);
      return response.body;
    } catch (e) {
      print(e);
      return "";
    }
  }

  static Future<String> postReq(String target, String json) async {
    try {
      resultNotifier.value = RequestLoadInProgress();
      final url = Uri.https('$_urlPrefix', '$target');
      final response = await post(url, headers: _headers, body: json);
      _handleResponse(response);
      return response.body;
    } catch (e) {
      print(e);
      return "";
    }
  }

  static Future<bool> putReq(String target, String? json) async {
    try {
      resultNotifier.value = RequestLoadInProgress();
      final url = Uri.https('$_urlPrefix', '$target');
      final response = await put(url, headers: _headers, body: json);
      _handleResponse(response);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> patchReq(String target, String json) async {
    try {
      resultNotifier.value = RequestLoadInProgress();
      final url = Uri.https('$_urlPrefix', '$target');
      final response = await patch(url, headers: _headers, body: json);
      _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> deleteReq(String target) async {
    try {
      resultNotifier.value = RequestLoadInProgress();
      final url = Uri.https('$_urlPrefix', '$target');
      final response = await delete(url, headers: _headers);
      _handleResponse(response);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}
