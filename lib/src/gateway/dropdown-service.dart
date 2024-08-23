import 'dart:convert';

import 'package:gugu/src/api/apis.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class dropdownService {
  static String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  Api api = Api();

  Future dropdown(BuildContext context, String endPoint) async {
    final response = await api.get(context, endPoint);
    return response;
  }

  Future dropdownPost(BuildContext context, String endPoint) async {
    Map<String, dynamic> dataValue = {
      'companyId': '1',
    };
    final response = await api.post(context, endPoint, dataValue);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }
}
