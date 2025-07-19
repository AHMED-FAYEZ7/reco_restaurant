class AppRegex {
  static bool isEmailValid(String email) {
    email = email.trim();
    return RegExp(
      r'^[^\s@]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.trim().length >= 6;
  }

  static String cleanFirebaseError(String error) {
    final regex = RegExp(r'^\[.*?\]\s*');
    return error.replaceFirst(regex, '');
  }
}
