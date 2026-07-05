import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Resolves the logged-in manager's branch/company, falling back to the
/// build-time .env defaults only if no user has logged in yet.
class Session {
  static Future<String> get branchId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('branch') ?? dotenv.env['BRANCH_ID'] ?? '1';
  }

  static Future<String> get companyId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyId') ?? dotenv.env['COMPANY_ID'] ?? '1';
  }
}
