import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gugu/src/api/apis.dart';
import 'package:flutter/material.dart';

class hairDressers {
  Api api = Api();
  static String branchId = dotenv.env['BRANCH_ID'] ?? '1';
  static String companyId = dotenv.env['COMPANY_ID'] ?? '1';
  Map<String, dynamic> data = {
    'companyId': companyId,
    'branchId': branchId
  };
  Future getHairDresser(BuildContext context) async {
    final response = await api.post(context, 'getHairDresser', data);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }

  Future getStyles(BuildContext context) async {
    final response = await api.post(context, 'getAllHairStyle', data);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }

  Future getHairDresserById(BuildContext context, String id) async {
    Map<String, dynamic> dataValue = {
      'styleId': id,
    };
    final response = await api.post(context, 'getHairDresserById', dataValue);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }

  Future getProducts(BuildContext context) async {
    String companyId = dotenv.env['COMPANY_ID'] ?? '1';
    Map<String, dynamic> dataValue = {
      'companyId': companyId,
    };
    final response = await api.post(context, 'products', dataValue);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }

  Future makeOrder(BuildContext context, String name, String phone,
      String hairStyleId, String hairDresserId, String randomNumber) async {
    String branchId = dotenv.env['BRANCH_ID'] ?? '1';
    String companyId = dotenv.env['COMPANY_ID'] ?? '1';
    Map<String, dynamic> dataValue = {
      'name': name,
      'phone': phone,
      'hairStyleId': hairStyleId,
      'hairDresserId': hairDresserId,
      'randomNumber': randomNumber,
      'branchId': branchId,
      'companyId': companyId
    };
    final response = await api.post(context, 'addOrder', dataValue);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }
}
