import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class ApiService extends GetxService {
  final String appBaseUrl;
  static const String connectionIssue = 'Connection failed!';
  final int timeoutInSeconds = 30;

  ApiService({required this.appBaseUrl});

  void logHeader() {
    log('\n====== 🌐 API SERVICE LOG ======\n');
  }

  Future<Response> getPublic(String uri) async {
    logHeader();
    log("➡️ GET PUBLIC: $appBaseUrl$uri");

    try {
      http.Response response = await http.get(Uri.parse(appBaseUrl + uri)).timeout(Duration(seconds: timeoutInSeconds));

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, uri);
    } catch (e) {
      log("❌ ERROR (GET PUBLIC): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> getPrivate(String uri, String token) async {
    logHeader();
    log("➡️ GET PRIVATE: $appBaseUrl$uri");
    log("🔑 TOKEN: $token");

    try {
      http.Response response =
          await http.get(Uri.parse(appBaseUrl + uri), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}).timeout(Duration(seconds: timeoutInSeconds));

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, uri);
    } catch (e) {
      log("❌ ERROR (GET PRIVATE): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> uploadFiles(
    String uri,
    List<MultipartBody> multipartBody,
  ) async {
    logHeader();
    log("➡️ UPLOAD FILES: $appBaseUrl$uri");

    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));

      for (MultipartBody multipart in multipartBody) {
        File file = File(multipart.file.path);
        log("📁 Uploading file: ${file.path}");

        request.files.add(http.MultipartFile(
          multipart.key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ));
      }

      var streamed = await request.send();
      http.Response response = await http.Response.fromStream(streamed);

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, uri);
    } catch (e) {
      log("❌ ERROR (UPLOAD FILES): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPublic(String uri, dynamic body, {Map<String, String>? headers}) async {
    logHeader();
    log("➡️ POST PUBLIC: $appBaseUrl$uri");
    log("📦 BODY: ${jsonEncode(body)}");

    try {
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, appBaseUrl + uri);
    } catch (e) {
      log("❌ ERROR (POST PUBLIC): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPrivate(
    String uri,
    dynamic body,
    String token,
  ) async {
    logHeader();
    log("➡️ POST PRIVATE: $appBaseUrl$uri");
    log("🔑 TOKEN: $token");
    log("📦 BODY: ${jsonEncode(body)}");

    try {
      http.Response response = await http.post(Uri.parse(appBaseUrl + uri),
          body: jsonEncode(body), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}).timeout(Duration(seconds: timeoutInSeconds));

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, uri);
    } catch (e) {
      log("❌ ERROR (POST PRIVATE): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> logout(
    String uri,
    String token,
  ) async {
    logHeader();
    log("➡️ LOGOUT API: $appBaseUrl$uri");
    log("🔑 TOKEN: $token");

    try {
      http.Response response = await http
          .post(Uri.parse(appBaseUrl + uri), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}).timeout(Duration(seconds: timeoutInSeconds));

      log("⬅️ RESPONSE (${response.statusCode}): ${response.body}");
      return parseResponse(response, uri);
    } catch (e) {
      log("❌ ERROR (LOGOUT): $e");
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Response parseResponse(http.Response res, String uri) {
    log("🔍 PARSING RESPONSE FOR: $uri");
    log("📨 RAW: ${res.body}");

    dynamic body;

    try {
      body = jsonDecode(res.body);
    } catch (e) {
      log("⚠️ JSON PARSE ERROR: $e");
      body = res.body;
    }

    Response response = Response(
      body: body,
      bodyString: res.body.toString(),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );

    log("📌 FINAL RESPONSE OBJECT: $response");

    if (response.statusCode != 200 && response.body != null && response.body is! String) {
      log("⚠️ ERROR STATUS: ${response.statusCode}");
      log("⚠️ ERROR BODY: ${response.body}");

      if (response.body.toString().startsWith('{errors: [{code:')) {
        response = Response(statusCode: response.statusCode, body: response.body, statusText: 'error');
      } else if (response.body.toString().startsWith('{message')) {
        response = Response(statusCode: response.statusCode, body: response.body, statusText: response.body['message']);
      }
    }

    return response;
  }
}

class MultipartBody {
  String key;
  XFile file;
  MultipartBody(this.key, this.file);
}
