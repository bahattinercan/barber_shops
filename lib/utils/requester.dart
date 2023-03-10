import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Requester {
  static final notifier = ValueNotifier<RequestState>(RequestInitial());
  static const _urlPrefix = 'f0c2-78-176-89-213.eu.ngrok.io';

  static final Map<String, String> _headers = {
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
      notifier.value = RequestLoadInProgress();
      final url = Uri.https(_urlPrefix, target);
      Response response = await get(url, headers: _headers);
      _handleResponse(response);
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  static Future<String> postReq(String target, String json) async {
    try {
      notifier.value = RequestLoadInProgress();
      final url = Uri.https(_urlPrefix, target);
      final response = await post(url, headers: _headers, body: json);
      _handleResponse(response);
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  static Future<bool> putReq(String target, String? json) async {
    try {
      notifier.value = RequestLoadInProgress();
      final url = Uri.https(_urlPrefix, target);
      final response = await put(url, headers: _headers, body: json);
      _handleResponse(response);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<void> patchReq(String target, String json) async {
    try {
      notifier.value = RequestLoadInProgress();
      final url = Uri.https(_urlPrefix, target);
      final response = await patch(url, headers: _headers, body: json);
      _handleResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<bool> deleteReq(String target) async {
    try {
      notifier.value = RequestLoadInProgress();
      final url = Uri.https(_urlPrefix, target);
      final response = await delete(url, headers: _headers);
      _handleResponse(response);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      notifier.value = RequestLoadFailure();
    } else {
      notifier.value = RequestLoadSuccess(response.body);
    }
  }

  static bool get isSuccess {
    if (Requester.notifier.value is RequestLoadSuccess) {
      return true;
    } else {
      return false;
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
