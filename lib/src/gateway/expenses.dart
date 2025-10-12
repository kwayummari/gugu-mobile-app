import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../api/apis.dart';
import '../widgets/app_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class expensesServices {
  final Api api = Api();
  static String branchId = dotenv.env['BRANCH_ID'] ?? '1';
  static String companyId = dotenv.env['COMPANY_ID'] ?? '1';
  Future<String> expenses(
    BuildContext context,
    String valueHolder,
    String amount,
    String description,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final managerId = prefs.getString('id');
      Map<String, dynamic> data = {
        'valueHolder': valueHolder,
        'amount': amount,
        'description': description,
        'companyId': companyId,
        'branchId': branchId,
        'managerId': managerId,
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
    } catch (e) {
      print('Expense API error: ${e.toString()}');
      AppSnackbar(
        isError: true,
        response: 'Failed to create expense. Please try again.',
      ).show(context);
      return 'failed';
    }
  }
}
