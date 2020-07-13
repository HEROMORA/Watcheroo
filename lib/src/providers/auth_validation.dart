import 'package:flutter/foundation.dart';
import 'package:watcherooflutter/src/models/validation_item.dart';

import 'auth.dart';

class AuthValidation with ChangeNotifier {
  ValidationItem _fullName = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  bool _isLogin = true;

  // GETTERS
  ValidationItem get fullName => _fullName;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  bool get isLogin => _isLogin;

  bool get isValid {
    if (email.value != null && password.value != null) {
      return isLogin ? true : _fullName.value != null ? true : false;
    }
    return false;
  }

  // SETTERS
  void changeFullName(String name) {
    bool nameValid = RegExp(r"\b[a-zA-Z]+\s[a-zA-Z]+\b").hasMatch(name);
    if (nameValid) {
      _fullName = ValidationItem(name, null);
    } else {
      _fullName = ValidationItem(null, 'Invalid Name');
    }
    notifyListeners();
  }

  void changeEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      _email = ValidationItem(email, null);
    } else {
      _email = ValidationItem(null, 'Invalid email');
    }
    notifyListeners();
  }

  void changePassword(String password) {
    bool passValid = password.length >= 6;
    if (passValid) {
      _password = ValidationItem(password, null);
    } else {
      _password = ValidationItem(null, 'Invalid Password');
    }
    notifyListeners();
  }

  void changeLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void submitData(Auth auth) {
    if (isLogin) {
      auth.login(email.value, password.value);
    } else {
      auth.register(email.value, password.value, fullName.value);
    }
  }
}
