import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = Provider<LoginService>((ref) {
  return LoginService();
});

class LoginService {
  bool validateCredentials(String username, String password) {
    return username == 'admin' && password == 'admin';
  }
}
