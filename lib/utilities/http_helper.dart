import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpHelper {
  static Options optionsHeaders = Options(headers: {
    HttpHeaders.contentTypeHeader:
        'multipart/form-data; boundary=<calculated when request is sent>'
  });

  static prepareStream({@required String url, @required Map map}) {
    Dio dio = Dio();
    return dio
        .post(
          url,
          options: HttpHelper.optionsHeaders,
          data: FormData.fromMap(map),
        )
        .asStream();
  }
}
