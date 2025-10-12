import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/apis.dart';
import '../provider/login-provider.dart';
import '../utils/routes/route-names.dart';
import '../widgets/app_snackbar.dart';

class loginService {
  final Api api = Api();

  Future<void> login(BuildContext context, String name, String password) async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateLoging(!myProvider.myLoging);

    // Use 'email' key for both endpoints (can be email or phone)
    Map<String, dynamic> data = {'email': name, 'password': password};

    // Try regular user login first
    final response = await api.post(context, 'login', data);
    final newResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      myProvider.updateLoging(!myProvider.myLoging);
      AppSnackbar(
        isError: false,
        response: newResponse['message'],
      ).show(context);
      final prefs = await SharedPreferences.getInstance();

      // Save user data from user table
      await prefs.setString('name', newResponse['user']['fullname'] ?? name);
      await prefs.setString('id', newResponse['user']['id'].toString());
      await prefs.setString('email', newResponse['user']['email'] ?? '');
      await prefs.setString('phone', newResponse['user']['phone'] ?? '');

      // Save JWT token for authentication
      if (newResponse['token'] != null) {
        await prefs.setString('authToken', newResponse['token']);
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.bottomNavigationBar,
        (_) => false,
      );
    } else {
      myProvider.updateLoging(!myProvider.myLoging);
      AppSnackbar(
        isError: true,
        response: newResponse['message'],
      ).show(context);
    }
  }
}
