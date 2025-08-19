import 'package:coalll/widgets/password_strength_indicator.dart';

class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool hasUppercase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  static PasswordStrength getPasswordStrength(String password) {
    if (password.length < 6) return PasswordStrength.weak;
    if (!hasUppercase(password) || !hasNumber(password)) {
      return PasswordStrength.medium;
    }
    return PasswordStrength.strong;
  }
}
