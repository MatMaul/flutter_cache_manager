import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

///Flutter Cache Manager
///Copyright (c) 2019 Rene Floor
///Released under MIT License.

typedef Future<FileFetcherResponse> FileFetcher(String url,
    {Map<String, String> headers});

abstract class FileFetcherResponse {
  get statusCode;

  Stream<List<int>> get bodyStream => null;

  bool hasHeader(String name);
  String header(String name);
}

class HttpFileFetcherResponse implements FileFetcherResponse {
  http.StreamedResponse _response;

  HttpFileFetcherResponse(this._response);

  @override
  bool hasHeader(String name) {
    return _response.headers.containsKey(name);
  }

  @override
  String header(String name) {
    return _response.headers[name];
  }

  @override
  Stream<List<int>> get bodyStream => _response.stream;

  @override
  get statusCode => _response.statusCode;
}
