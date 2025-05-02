import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();

  bool isLoading = false;
  String? errorMessage;

  Future<User?> login(String username, String password) async {
    setBusy(true);
    errorMessage = null;

    try {
      final user = await _authService.login(username, password);
      return user;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return null;
    } finally {
      setBusy(false);
    }
  }
}
