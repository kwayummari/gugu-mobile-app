import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../api/apis.dart';
import '../widgets/app_snackbar.dart';

class expensesServices {
  final Api api = Api();
  static String branchId = dotenv.env['BRANCH_ID'] ?? '1';
  static String companyId = dotenv.env['COMPANY_ID'] ?? '1';
  Future<String> expenses(
      BuildContext context, String valueHolder, String amount, String description) async {
    Map<String, dynamic> data = {
      'valueHolder': valueHolder,
      'amount': amount,
      'description': description,
      'companyId': companyId,
      'branchId': branchId
    };
    final response = await api.post(context, 'add_expenses', data);
    final newResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AppSnackbar(
        isError: false,
        response: newResponse['message'],
      ).show(context);
      return 'success';
    } else {
      AppSnackbar(
        isError: true,
        response: newResponse['message'],
      ).show(context);
      return 'failed';
    }
  }
}
