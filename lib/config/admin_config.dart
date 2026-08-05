/// Acceso al panel admin (solo UI). La autorización real está en Cloud Functions.
abstract final class AdminConfig {
  static const Set<String> emails = {
    'elkinoswa@gmail.com',
  };

  static bool isAdminEmail(String? email) {
    if (email == null || email.trim().isEmpty) return false;
    return emails.contains(email.trim().toLowerCase());
  }
}
